%**********************************************************************
% ELECTRÓNICA DIGITAL PARA COMUNICACIONES
% PROYECTO FINAL DE LA ASIGNATURA.
% ESTIMADOR DE CANAL Y ECUALIZADOR PARA DVB-T
% Fichero : dec2tc.m
% Francisco Ortiz Abril
%**********************************************************************
%% Descripción: función que convierte un número decimal a complemento a 2 con 10 bits con coma fija. La
%conversión saldrá en un formato donde los pesos asignados a cada bit son tales que se pueden 
%representar números entre -4 y 4.
%%
function out = dec2tc(data)
%% Inicializaciones
nBits=10;
powOf2(1) = 4;
powOf2(2) = 2;
powOf2(3:10) = 1./(2.^[0:nBits-3]);

out = false(1,nBits);
ind = 1;
data1=0;
datatemp = 0;

%% Ponemos data como potencia de 2 
datatemp = data;
if data < 0
    datatemp = data*(-1);
end
while ind <= 10
    if datatemp >= powOf2(ind)
        data1 = data1+powOf2(ind);
        datatemp = datatemp-powOf2(ind);
    end
    ind = ind + 1;
end
ind = 1;
%% Si el número era positivo se deja igual, si era negativo se prepara para
%representarse en C2
if data >= 0
    out(1) = 0;
else
    out(1) = 1;
    data1 = powOf2(1)-data1;
end

%% Se calcula la salida
while ind <= 10
    if data1 >= powOf2(ind)
        data1 = data1-powOf2(ind);
        out(ind) = true;
    end
    ind = ind + 1;
end

end
