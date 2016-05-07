----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:50:55 07/03/2015 
-- Design Name: 
-- Module Name:    memoryhestwriter - Behavioral 
-- Project Name: 
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:50:55 07/03/2015 
-- Design Name: 
-- Module Name:    generaaddress - Behavioral 
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
LIBRARY ieee;
use ieee.std_logic_signed.all;
USE ieee.std_logic_1164.ALL;

entity generaaddress is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           address : out  STD_LOGIC_VECTOR (11 downto 0);
			  address2 : out STD_LOGIC_VECTOR (11 downto 0);
			  finish : out STD_LOGIC;
			  valid: out STD_LOGIC;
			  start: in STD_LOGIC
			  );
end generaaddress;

architecture Behavioral of generaaddress is
	type estado is (reposo, escritura);
	signal estado_actual,estado_siguiente : estado;
	signal address_aux, p_address_aux : STD_LOGIC_VECTOR(11 downto 0);
	signal finish_aux,p_finish_aux : STD_LOGIC;
	signal valid_aux,p_valid_aux : STD_LOGIC;
 
begin
	--Sentencias concurrentes
	finish <= finish_aux;
	address <= address_aux;
	address2 <= address_aux;
	valid <= valid_aux;
 
 --Proceso síncrono
 sinc: process (reset, clk)
 begin
	if (reset = '1') then
		estado_actual <= reposo;
	elsif (rising_edge(clk)) then
		estado_actual <= estado_siguiente;
		address_aux <= p_address_aux;
		finish_aux <= p_finish_aux;
		valid_aux <= p_valid_aux;
	end if;
 end process;

 fsm:process(estado_actual,start, address_aux)
 begin
	--Valores por defecto.
	p_valid_aux <= '0';
	p_finish_aux <= '0';
	p_address_aux <= address_aux;

	case estado_actual is
		when reposo =>
			p_address_aux <= (others => '0');
			if ( start='1') then
				estado_siguiente <= escritura;
			else
				estado_siguiente <= reposo;
			end if;
	
		when escritura =>
			if(address_aux > "011010101000") then
			--Se ha terminado 
				p_finish_aux <= '1';
				estado_siguiente <= reposo;
			else
				p_address_aux <= address_aux+1;
				p_valid_aux <= '1';
				estado_siguiente <= escritura;
			end if;
			
		when others =>
				estado_siguiente <= reposo;
	end case;	

end process;
	

end Behavioral;

