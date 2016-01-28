%% **********************************************************************
% ELECTRÓNICA DIGITAL PARA COMUNICACIONES
% PROYECTO FINAL DE LA ASIGNATURA.
% ESTIMADOR DE CANAL Y ECUALIZADOR PARA DVB-T
% conversionResultados.m
% Francisco Ortiz Abril
%**********************************************************************
%% 
function resul = conversionResultados(file_vhdl)
NUMPORTADORAS=1705;
fileID = fopen(file_vhdl);
datos = textscan(fileID,'%s');
fclose(fileID);
resul=[];
for ind=1:NUMPORTADORAS
    dato=datos{1}{ind};
    resul=[resul;dato(1:4);dato(5:8)];
end
end
