%**********************************************************************
% ELECTRÓNICA DIGITAL PARA COMUNICACIONES
% PROYECTO FINAL DE LA ASIGNATURA.
% ESTIMADOR DE CANAL Y ECUALIZADOR PARA DVB-T
% Fichero : prbs.m
% Francisco Ortiz Abril
%**********************************************************************
%% Descripción: función que genera una secuencia de tamaño NCARRIER(número de portadoras) a partir del prbs.
%%
function [seq] = prbs(NCARRIER)

%Inicializaciones
prbs=ones(1,11);        %Secuencia PRBS   
seq=zeros(1,NCARRIER);  %Secuencia de salida

for i=1:NCARRIER
    seq(i) = prbs(11);
    new_value = xor(prbs(11),prbs(9));
    prbs(2:11) = prbs(1:10);
    prbs(1) = new_value;
end

end