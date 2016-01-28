%**********************************************************************
% ELECTRÓNICA DIGITAL PARA COMUNICACIONES
% PROYECTO FINAL DE LA ASIGNATURA.
% ESTIMADOR DE CANAL Y ECUALIZADOR PARA DVB-T
% Fichero : generaCOE_pilot.m
% Francisco Ortiz Abril
%**********************************************************************

%%
function generaCOE_pilot(rx,filename)
fid=fopen(filename,'w');
fprintf(fid,'memory_initialization_radix=2;\n');
fprintf(fid,'memory_initialization_vector=\n');
fprintf(fid,'%d\n',rx);
fprintf(fid,';');
fclose(fid);

end