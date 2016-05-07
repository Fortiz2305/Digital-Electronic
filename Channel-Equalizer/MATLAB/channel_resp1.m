%**********************************************************************
% ELECTRÓNICA DIGITAL PARA COMUNICACIONES
% PROYECTO FINAL DE LA ASIGNATURA.
% ESTIMADOR DE CANAL Y ECUALIZADOR PARA DVB-T
% Fichero : channel_resp1.m
% Francisco Ortiz Abril
%**********************************************************************
%%
function [ch_resp_f, ch_resp] = channel_resp1

TSYMB = 224e-6; %Tiempo de símbolo
%k=0:2047; 
attenuation=[0.057662 0.176809 0.407163 0.303585 0.258782 0.061831 0.150340 0.051534 0.185074 0.400967 0.295723 0.350825 0.262909 0.225894 0.170996 0.149723 0.240140 0.116587 0.221155 0.259730];
delay=1e-6.*[1.003019 5.422091 0.518650 2.751772 0.602895 1.016585 0.143556 0.153832 3.324866 1.935570 0.429948 3.228872 0.848831 0.073883 0.203952 0.194207 0.924450 1.381320 0.640512 1.368671];
phase=[4.855121 3.419109 5.864470 2.215894 3.758058 5.430202 3.952093 1.093586 5.775198 0.154459 5.928383 3.053023 0.628578 2.128544 1.099463 3.462951 3.664773 2.833799 3.334290 0.393889];

%Centramos las portadoras
k=(-2047/2:2047/2);
%Respuesta en frecuencia
ch_resp_f =(attenuation.'.*exp(-1i*phase.')).'*exp(-1i*2*pi*1/TSYMB*delay'*k);  
%Ricean Factor
K=1/sqrt(sum(attenuation.^2));
ch_resp_f=K*ch_resp_f;

%Representacion
%figure
%plot(k*(1/TSYMB),20*log10(abs(ch_resp_f)));
%title('Respuesta del canal');
%grid;
ch_resp=fftshift(ch_resp_f);
 
end