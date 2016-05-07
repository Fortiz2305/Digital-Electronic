----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Francisco Ortiz Abril
-- 
-- Create Date:    11:43:50 06/11/2015 
-- Design Name: 
-- Module Name:    fsm - fsm_behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
--use IEEE.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_rx : in  STD_LOGIC_VECTOR (19 downto 0);
           addr_rx : out  STD_LOGIC_VECTOR (11 downto 0);
           data_pilot : in  STD_LOGIC;
           addr_pilot : out  STD_LOGIC_VECTOR (8 downto 0);
           data_hest : out  STD_LOGIC_VECTOR (31 downto 0);
           addr_hest : out  STD_LOGIC_VECTOR (11 downto 0);
           wre_hest : out  STD_LOGIC;
			  start : in STD_LOGIC;
			  stop: out STD_LOGIC);
end fsm;

architecture fsm_behavioral of fsm is

type estado is (reposo, pilotoInferior1, pilotoInferior2, pilotoSuperior1, pilotoSuperior2, interpolacion, interpolacion2, actualizacion);

signal estado_actual, estado_nuevo : estado;
signal ind,p_ind : STD_LOGIC_VECTOR (4 downto 0); --Indice de 0 a 11 
signal addr_rx_aux, p_addr_rx_aux : STD_LOGIC_VECTOR (11 downto 0); --Dirección Memoria Datos Recibidos
signal addr_pilot_aux, p_addr_pilot_aux : STD_LOGIC_VECTOR (8 downto 0); --Dirección Memoria Pilotos
signal data_hest_aux, p_data_hest_aux: STD_LOGIC_VECTOR (31 downto 0); --Dato Hest 31 bits por estar multiplicado
signal addr_hest_aux, p_addr_hest_aux: STD_LOGIC_VECTOR (11 downto 0); --Dirección Hest
signal stop_aux, p_stop_aux : STD_LOGIC; 
signal wre_hest_aux, p_wre_hest_aux : STD_LOGIC;
signal piloto_inf_re, p_piloto_inf_re : STD_LOGIC_VECTOR (12 downto 0); --13 bits para cuando multiplique por 3
signal piloto_inf_im, p_piloto_inf_im : STD_LOGIC_VECTOR (12 downto 0); 
signal piloto_sup_re, p_piloto_sup_re : STD_LOGIC_VECTOR (12 downto 0); 
signal piloto_sup_im, p_piloto_sup_im : STD_LOGIC_VECTOR (12 downto 0);
signal piloto_inf_re1, p_piloto_inf_re1 : STD_LOGIC_VECTOR (10 downto 0); --11 bits para cuando divido por 4
signal piloto_inf_im1, p_piloto_inf_im1 : STD_LOGIC_VECTOR (10 downto 0);
signal piloto_sup_re1, p_piloto_sup_re1 : STD_LOGIC_VECTOR (10 downto 0);
signal piloto_sup_im1, p_piloto_sup_im1 : STD_LOGIC_VECTOR (10 downto 0);
signal dir_escritura_hest, p_dir_escritura_hest : STD_LOGIC_VECTOR(11 downto 0); 

begin

-- Sentencias concurrentes
addr_rx <= addr_rx_aux;
addr_pilot <= addr_pilot_aux;
data_hest <= data_hest_aux;
addr_hest <= addr_hest_aux;
stop <= stop_aux;
wre_hest <= wre_hest_aux;


--Proceso síncrono
 sinc: process (rst, clk)
 begin
	if (rst = '1') then
		estado_actual <= reposo;
	elsif (rising_edge(clk)) then
		estado_actual <= estado_nuevo;
		addr_rx_aux <= p_addr_rx_aux;
		addr_pilot_aux <= p_addr_pilot_aux;
		data_hest_aux <= p_data_hest_aux;
		addr_hest_aux <= p_addr_hest_aux;
		stop_aux <= p_stop_aux;
		wre_hest_aux <= p_wre_hest_aux;	
		dir_escritura_hest <= p_dir_escritura_hest;
		ind <= p_ind;
		piloto_inf_re <= p_piloto_inf_re;
		piloto_inf_im <= p_piloto_inf_im;
		piloto_sup_re <= p_piloto_sup_re;
		piloto_sup_im <= p_piloto_sup_im;
		piloto_inf_re1 <= p_piloto_inf_re1;
		piloto_inf_im1 <= p_piloto_inf_im1;
		piloto_sup_re1 <= p_piloto_sup_re1;
		piloto_sup_im1 <= p_piloto_sup_im1;
	end if;
 end process;
 
 fsm: process (estado_actual, start, data_hest_aux, wre_hest_aux, ind, stop_aux, data_rx, data_pilot, addr_hest_aux, dir_escritura_hest, addr_rx_aux, addr_pilot_aux, piloto_inf_re, piloto_inf_im, piloto_sup_re, piloto_sup_im, piloto_inf_re1, piloto_inf_im1, piloto_sup_re1, piloto_sup_im1)
  begin 
 
  p_addr_rx_aux <= addr_rx_aux;
  p_addr_pilot_aux <= addr_pilot_aux;
  p_addr_hest_aux <= addr_hest_aux;
  p_dir_escritura_hest <= dir_escritura_hest;
  p_ind <= ind;
  p_stop_aux <= stop_aux;
  p_wre_hest_aux <= '0';
  p_piloto_inf_re <= piloto_inf_re;
  p_piloto_inf_im <= piloto_inf_im;
  p_piloto_inf_re1 <= piloto_inf_re1;
  p_piloto_inf_im1 <= piloto_inf_im1;
  p_piloto_sup_re <= piloto_sup_re;
  p_piloto_sup_im <= piloto_sup_im;
  p_piloto_sup_re1 <= piloto_sup_re1;
  p_piloto_sup_im1 <= piloto_sup_im1;
  p_data_hest_aux <= data_hest_aux;
  estado_nuevo <= estado_actual;

  case estado_actual is
  
	when reposo =>
		--p_addr_rx_aux <= (others => '0');
		p_addr_rx_aux <= "000000000001" - 1;
		p_addr_pilot_aux <= (others => '0');
		p_addr_hest_aux <= (others => '0');
		p_dir_escritura_hest <= (others => '0');
		p_ind <= "00001";
		p_stop_aux <= '0';
		p_wre_hest_aux <= '0';
	
		if (start = '1') then
			estado_nuevo <= pilotoInferior1;
		else
			estado_nuevo <= reposo;
		end if;
		
	when pilotoInferior1 =>	
		p_wre_hest_aux <= '1';  --Se habilita la escritura
		--Se pone valor por defecto
		p_piloto_inf_re <= (others => '0');
		p_piloto_inf_im <= (others => '0');
		if (data_pilot = '1') then	 -- El piloto es positivo	
			p_data_hest_aux (31 downto 16) <= data_rx(19 downto 10) * "001001"; --Multiplicamos por 9 parte real (12*3/4)
			p_data_hest_aux (15 downto 0) <= data_rx(9 downto 0) * "001001";  --Multiplicamos por 9 parte imaginaria
			p_piloto_inf_re <= data_rx(19 downto 10) * "011";  --Multiplicamos por 3 y dividiremos por 4 porque se usa para interpolar
			p_piloto_inf_im <= data_rx(9 downto 0) * "011";  
		else	-- El piloto es negativo
			p_data_hest_aux (31 downto 16) <= data_rx(19 downto 10) * "110111"; --Multiplicamos por -9
			p_data_hest_aux (15 downto 0) <= data_rx(9 downto 0) * "110111"; 
			p_piloto_inf_re <= data_rx(19 downto 10) * "101"; --Dejamos guardado lo que vale para la interpolación
			p_piloto_inf_im <= data_rx(9 downto 0) * "101"; 
	   end if;
		
		--Actualizo direcciones
		p_addr_rx_aux <= addr_rx_aux + 12; --Se suma 12 para llegar al siguiente piloto
		p_addr_pilot_aux <= addr_pilot_aux + 1;	--Se suma 1 en la memoria de pilotos
		
		--Transicion de estados
		estado_nuevo <= pilotoInferior2;
	
	when pilotoInferior2 =>
		-- Divido por 4 después de un ciclo de reloj
		p_piloto_inf_re1 <= piloto_inf_re(12 downto 2); --Parte real
	   p_piloto_inf_im1 <= piloto_inf_im(12 downto 2); --Parte imaginaria
		
		--Se actualiza la dirección de la memoria
		p_addr_hest_aux <= dir_escritura_hest + 12; --Se usa direccion escritura para no perder donde escribo
		
		--Transicion de estados
		estado_nuevo <= pilotoSuperior1;
		
	when pilotoSuperior1 => 
	   --Se habilita la escritura
		p_wre_hest_aux <= '1';
		if (data_pilot = '1') then	
		   p_data_hest_aux (31 downto 16) <= data_rx(19 downto 10) * "001001"; --Multiplicamos por 9 parte real (12*3/4)
			p_data_hest_aux (15 downto 0) <= data_rx(9 downto 0) * "001001";  --Multiplicamos por 9 parte imaginaria
    		p_piloto_sup_re <= data_rx(19 downto 10) * "011"; --Dejamos guardado lo que vale para la interpolación
	   	p_piloto_sup_im <= data_rx(9 downto 0) * "011"; 
		else
		   p_data_hest_aux (31 downto 16) <= data_rx(19 downto 10) * "110111"; --Multiplicamos por -9
			p_data_hest_aux (15 downto 0) <= data_rx(9 downto 0) * "110111"; 
			p_piloto_sup_re <= data_rx(19 downto 10) * "101"; --Dejamos guardado lo que vale para la interpolacion
			p_piloto_sup_im <= data_rx(9 downto 0) * "101"; 
	   end if;
		
		--Se actualizan las direcciones
		p_addr_rx_aux <= addr_rx_aux + 12;
		p_addr_pilot_aux <= addr_pilot_aux + 1;	
		
		--Transicion de estados
		estado_nuevo <= pilotoSuperior2;
	
	when pilotoSuperior2 =>
		 --Divido por 4
		p_piloto_sup_re1 <= piloto_sup_re(12 downto 2); --Parte real
		p_piloto_sup_im1 <= piloto_sup_im(12 downto 2); --Parte imaginaria
		
		--Actualizo direccion escritura
		p_addr_hest_aux <= dir_escritura_hest + ind; 
		
		--Transicion de estados
		estado_nuevo <= interpolacion;
	
	when interpolacion =>
	   --Pongo el dato 
		p_wre_hest_aux <= '1';
		p_data_hest_aux(31 downto 16) <= ("01100"-ind)*piloto_inf_re1 + ind*piloto_sup_re1;
		p_data_hest_aux(15 downto 0) <= ("01100"-ind)*piloto_inf_im1 + ind*piloto_sup_im1;
		
		p_ind <= ind + 1; --Se aumenta el indice para interpolar el siguiente valor
		--Transicion de estado
		estado_nuevo <= interpolacion2;
	
	when interpolacion2 => 
		--Se deja pasar un ciclo de reloj para tener el nuevo valor de "ind" disponible
		--Se actualiza direccion
		p_addr_hest_aux <= dir_escritura_hest + ind;		
		
		--Transicion de estados
		if (ind > "01011") then --Cuando el indice vale más que 11 se ha terminado de interpolar entre estos valores
			estado_nuevo <= actualizacion;
		else
			estado_nuevo <= interpolacion;
		end if;
	
	when actualizacion =>
		p_ind <= "00001"; --Indice = 1 para volver a interpolar
		--Actualizo el valor del piloto inferior para interpolar la próxima vez.
	   p_piloto_inf_re1 <= piloto_sup_re1;
		p_piloto_inf_im1 <= piloto_sup_im1;
		--Se actualizan las direcciones
		p_dir_escritura_hest <= dir_escritura_hest + 12;
		p_addr_hest_aux<=dir_escritura_hest+24;
		--Compruebo si es la última dirección
		if (addr_rx_aux > "011010101001") then  --si es mayor que 1705
			p_stop_aux <= '1';
			estado_nuevo <= reposo;
		else
			estado_nuevo <= pilotoSuperior1;
		end if;
		
	when others =>
		estado_nuevo <= reposo;
		
	end case;

 end process;
 
end fsm_behavioral;

