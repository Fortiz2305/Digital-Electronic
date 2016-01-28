----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:13:38 07/09/2015 
-- Design Name: 
-- Module Name:    generaaddress_waiting - Behavioral 
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
use ieee.std_logic_signed.all;
USE ieee.std_logic_1164.ALL;

entity generaaddress_waiting is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           address : out  STD_LOGIC_VECTOR (11 downto 0);
			  address2: out STD_LOGIC_VECTOR (11 downto 0);
			  finish : out STD_LOGIC;
			  valid: out STD_LOGIC;
			  start: in STD_LOGIC
			  );
end generaaddress_waiting;

architecture Behavioral of generaaddress_waiting is

type estado is (reposo, escritura, espera);
signal estado_actual,estado_siguiente : estado;
signal address_aux, p_address_aux : STD_LOGIC_VECTOR(11 downto 0);
signal finish_aux,p_finish_aux : STD_LOGIC;
signal valid_aux,p_valid_aux : STD_LOGIC;
signal p_contador,contador : STD_LOGIC_VECTOR(6 downto 0); 

begin
--SENTENCIAS CONCURRENTES
finish <= finish_aux;
address <= address_aux;
address2 <= address_aux;
valid <= valid_aux;

 sinc: process (reset, clk)
 begin
	if (reset = '1') then
		estado_actual <= reposo;
	elsif (rising_edge(clk)) then
		estado_actual <= estado_siguiente;
		address_aux <= p_address_aux;
		finish_aux <= p_finish_aux;
		valid_aux <= p_valid_aux;
		contador <= p_contador;
	end if;
 end process;

 fsm:process(estado_actual,start, address_aux,contador)
 begin
		--Valores por defecto.
		--estado_siguiente<=estado_actual;
		p_valid_aux <= '0';
		p_finish_aux <= '0';
		p_address_aux <= address_aux;
		p_contador <= contador;
		estado_siguiente <= estado_actual;
		
		case estado_actual is
			when reposo =>
				p_address_aux <= (others => '0');
				p_contador <= (others => '0');
				if (start = '1') then
					estado_siguiente <= espera;
				end if;
		
			when espera => --Esperamos 70 ciclos de reloj para dar tiempo al divisor a sacar un dato
				if (contador = "1000110" ) then
					estado_siguiente <= escritura;
					p_valid_aux <= '1';
					p_contador <= (others => '0');
				else
					p_contador <= contador+1;
				end if;
		
			when escritura =>
				if(address_aux > "011010101000") then
				--Hemos terminado
					p_finish_aux <= '1';
					estado_siguiente <= reposo;
				else
					p_address_aux <= address_aux+1;
					estado_siguiente <= espera;
				end if;
		end case; 
 end process;

end Behavioral;

