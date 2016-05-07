%**********************************************************************
% ELECTRÓNICA DIGITAL PARA COMUNICACIONES
% PROYECTO FINAL DE LA ASIGNATURA.
% ESTIMADOR DE CANAL Y ECUALIZADOR PARA DVB-T
% Fichero : generaCOE.m
% Francisco Ortiz Abril
%**********************************************************************
%% Descripción: función que genera un fichero formato .coe con los valores recibidos en la 
% transmisión en Matlab. 
%%
function generaCOE(rx_freq,filename,depth)
rx_freq_fixed = zeros(length(rx_freq),depth);

for i=1:length(rx_freq)
    rx_freq_fixed(i,1:depth/2) = dec2tc(real(rx_freq(i)));
    rx_freq_fixed(i,depth/2+1:depth) = dec2tc(imag(rx_freq(i)));
end

%% Escribir en fichero
fid=fopen(filename,'w');
fprintf(fid,'memory_initialization_radix=2;\n');
fprintf(fid,'memory_initialization_vector=\n');
fprintf(fid,'%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d\n',rx_freq_fixed.');
fprintf(fid,';');
fclose(fid);

