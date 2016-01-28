%% **********************************************************************
% ELECTRÓNICA DIGITAL PARA COMUNICACIONES
% PROYECTO FINAL DE LA ASIGNATURA.
% ESTIMADOR DE CANAL Y ECUALIZADOR PARA DVB-T
% CROSSCHECK Entre Matlab y VHDL
% Francisco Ortiz Abril
%**********************************************************************
%% 
function [errorReal,errorImag] = crosscheck(Hest_vhdl,Hest_matlab,N)
NCARRIER = 1705;            %Número de portadoras
TSYMB = 224e-6;             %Tiempo de símbolo
invTsymb=1/TSYMB;
%Se separan parte real e imaginaria para compararlas
Hest_vhdl = conversionResultados(Hest_vhdl); 
%escalado que han sufrido los valores en VHDL
escalado = 2^-7*(1/12);          

%Se pasan los números a decimal
resulDec = zeros(length(Hest_vhdl),1);
for i=1:length(Hest_vhdl)
    resulDec(i,1) = hex2dec(Hest_vhdl(i,:));
    if resulDec(i,1) > 2^(N-1)
        resulDec(i,1) = resulDec(i,1)-2^N;
    end
end

%% Comprobación con el canal de Matlab

resulDecReal = resulDec(1:2:end);
resulDecImag = resulDec(2:2:end);
%Canal estimado con VHDL
vhdl_Hest = (resulDecReal + 1i*resulDecImag)*escalado;

%Se calcula la diferencia entre uno y otro en parte real e imaginaria
diffReal = zeros(length(Hest_matlab),1);
diffImag = zeros(length(Hest_matlab),1);
for j= 1:length(Hest_matlab)
   diffReal(j,1) = resulDecReal(j,1)*escalado - real(Hest_matlab(j));
   diffImag(j,1) = resulDecImag(j,1)*escalado - imag(Hest_matlab(j));
end

%Se calcula el error relativo
errorReal = (resulDecReal.*escalado - real(Hest_matlab.'))./real(Hest_matlab.');
errorImag = (resulDecImag.*escalado - imag(Hest_matlab.'))./imag(Hest_matlab.');
%% Representaciones
figure
%Canal Estimado Modelo Matlab
plot((-NCARRIER/2:NCARRIER/2-1)*invTsymb,20*log10(abs(Hest_matlab)),'r');
hold on;
%Canal Estimado con VHDL
plot((-NCARRIER/2:NCARRIER/2-1)*invTsymb,20*log10(abs(vhdl_Hest.')),'b');
hold off;
end