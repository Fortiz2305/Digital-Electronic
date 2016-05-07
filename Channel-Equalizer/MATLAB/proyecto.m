%**********************************************************************
% ELECTRÓNICA DIGITAL PARA COMUNICACIONES
% PROYECTO FINAL DE LA ASIGNATURA.
% ESTIMADOR DE CANAL Y ECUALIZADOR PARA DVB-T
% Fichero principal : proyecto.m
% Francisco Ortiz Abril
%**********************************************************************
%% INICIALIZACIONES
clear all;
close all;

NFFT=2048;                            %numero de muestras FFT
NCP=64;                               %1/32*2048
NCARRIER=1705;                        %numero de portadoras
NDATA=NCARRIER-length(1:12:NCARRIER); %numero de datos: portadoras-pilotos scattered
NUM_SYMB=1;                           %Número de símbolos
CONSTEL='QPSK';
SNR=50;                               %SNR
TSYMB = 224e-6;                       %Tiempo de símbolo
invTsymb=1/TSYMB;

tic 

%% TRANSMISOR

%Constelacion transmitida
C = [1+1i 1-1i -1+1i -1-1i];
M = 2;

if isreal(C)
    C = complex(C);
end

%Generacion bits
numbits = NUM_SYMB*NDATA*M;              %Numero de símbolos*portadoras*bits
bits_tx = rand(numbits,1);               %Numeros entre 0 y 1.
bits_tx = bits_tx > 0.5;                 %Si se cumple la condición devuelve un 1. Si no 
                                         %devuelve un 0.

%Paso de bits a simbolos
aux = reshape(bits_tx,M,[]).';
symb = zeros(size(aux,1),1);

for k = 1:M
    symb = symb+(2^(k-1))*aux(:,k);      %Se pasa de binario a decimal
end

%Mapper
const_points = C(symb+1)/sqrt(2);

if isreal(const_points)
    const_points = complex(const_points);
end

% PRBS. Se obtiene de la función prbs
seq = prbs(NCARRIER);

portadoras = ones(NUM_SYMB,NCARRIER);    %Inicialización de simbolos en frecuencia
ofdm_freq = zeros(NFFT,NUM_SYMB);

portadoras(:,1:12:1705) = ones(NUM_SYMB,1)*(4/3*(2*(1/2-seq(1:12:1705)))); %Inserción de los pilotos
const_points = reshape(const_points,NUM_SYMB,NDATA);
portadoras(find(portadoras==1)) = const_points;                            %Inserción de datos donde no hay pilotos
ofdm_freq(ceil((NFFT-NCARRIER)/2)+(1:NCARRIER),:) = portadoras.';

%Representacion
figure
stem(abs(ofdm_freq(:,1)));
grid;
xlabel('Portadoras OFDM y pilotos');
ylabel('Amplitud');
title('Espectro OFDM');

%Se pone desde -fs/2 a fs/2
ofdm_freq = fftshift(ofdm_freq,1);

%% Transmisión en tiempo
ofdm_time = ifft(ofdm_freq,NFFT,1);                     %Paso a tiempo
ofdm_time = [ofdm_time(end-(NCP-1):end,:); ofdm_time];  %Insercion prefijo cíclico
tx = ofdm_time(:);                                      %Transmisión en tiempo

%Representacion
%figure
%plot(real(tx),'b-');
%hold on
%plot(imag(tx),'r-');
%xlabel('Muestras temporales');
%ylabel('Amplitud');
%legend('real','imag');
%grid
%title('Señal OFDM en el tiempo')

%% INSERCION DE CANAL P1
%Se obtiene la respuesta del canaal de la funcion channel_resp1
[ch_resp_f, ch_resp] = channel_resp1;
ch_resp = ifft(ch_resp,NFFT);

%Convolución de los símbolos transmitidos con el canal
s = conv(tx,ch_resp);
s = s(1:size(tx));      %Nos quedamos con los símbolos que queremos

%% CANAL AWGN
%Ruido que le sumaremos a la señal 
noise = (randn(size(s))+1i*randn(size(s)))/sqrt(2);
Ps = mean(s.*conj(s));
nsr = 10^(-SNR/10); %Pn/Ps
noise = sqrt(Ps*nsr).*noise;

%% SEÑAL RECIBIDA 
rx = s+noise;

%% RECEPTOR
%Se reorganiza en filas y columnas
ofdm_rx_time = reshape(rx,NFFT+NCP,NUM_SYMB);
%Se quita el prefijo cíclico
ofdm_rx_time = ofdm_rx_time(NCP+1:end,:);
%Se pasa  a frecuencia
ofdm_rx_freq = fft(ofdm_rx_time,NFFT,1);
ofdm_rx_freq = fftshift(ofdm_rx_freq,1);
%Me quedo con las portadoras
ofdm_rx_freq = ofdm_rx_freq(ceil((NFFT-NCARRIER)/2)+(1:NCARRIER),:);

%Generar fichero .COE
generaCOE(ofdm_rx_freq,'simb.coe',20);

%ESTIMACIÓN DEL CANAL CON LOS PILOTOS
Srk = ofdm_rx_freq(1:12:1705,:);                    %Señal recibida en los pilotos
Sk = portadoras(:,1:12:1705).';                     %Señal transmitida en los pilotos

%Generación memoria pilotos para VHDL
coef_pilot_memory = Sk>0;
generaCOE_pilot(coef_pilot_memory,'pilot.coe');

Hest_pilot = Srk./Sk;                               %Estimación del canal con los pilotos

%% INTERPOLACION
%Coefientes
h0 = Sk(1);
h12 = Sk(2);

coef = ones(2,1)*[1:11];
coef(1,:) = coef(1,:)./12;      c1=coef(1,:);
coef(2,:) = (1-coef(2,:)/12);   c0=coef(2,:);

Hest = zeros(NUM_SYMB,NCARRIER);            %Inicialización 
Hest(:,1:12:NCARRIER) = Hest_pilot.';       %Inserción de pilotos

%Interpolación 
for i = 1:12:NCARRIER-12;
    h0 = Hest(:,i);
    h12 = Hest(:,i+12);
    Hest(:,i+1:i+11) = h0*c0+h12*c1;
end

%REPRESENTACIÓN DE LA ESTIMACIÓN DE CANAL
figure
%plot((-NCARRIER/2:NCARRIER/2-1)*invTsymb,20*log10(abs(Hest)));
plot((-NCARRIER/2:NCARRIER/2-1)*invTsymb,20*log10(abs(Hest)),'b');
hold on;
%plot((-NCARRIER/2:12:NCARRIER/2-1)*invTsymb,20*log10(abs(Hest_pilot)),'bo');
%hold on;
plot((-NFFT/2:NFFT/2-1)*invTsymb,20*log10(abs(ch_resp_f)),'r');
%title('Respuesta del canal');
%grid;
hold off;
title('Canal estimado vs Canal real');
grid;

%% ECUALIZACIÓN
S_rx_est = ofdm_rx_freq.'./Hest;
%Se quitan los pilotos
S_rx_est(:,1:12:end) = [];
%Constelacion recibida
rx_constel = S_rx_est(:).';

figure
plot(rx_constel,'or');
hold on;
plot(const_points,'xb');
hold off;
grid
axis([-2.5 2.5 -2.5 2.5]);
title('Constelacion recibida');
xlabel('I');
ylabel('Q');

%Demap
bits_rx = zeros(1,length(rx_constel)*2);
bits_rx(2:2:end) = real(rx_constel)<0;
bits_rx(1:2:end) = imag(rx_constel)<0;

%BER
BER = mean(xor(bits_rx,bits_tx.'));
fprintf(1,'BER = %f\n',BER);

toc

