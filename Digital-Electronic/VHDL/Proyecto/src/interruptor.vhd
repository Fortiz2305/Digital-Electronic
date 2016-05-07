----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:30:59 07/08/2015 
-- Design Name: 
-- Module Name:    interruptor - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interruptor is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           check : in  STD_LOGIC;
			  entrada1 : in STD_LOGIC_VECTOR(11 downto 0);
			  entrada2 : in STD_LOGIC_VECTOR(11 downto 0);
           salida : out  STD_LOGIC_VECTOR(11 downto 0));
end interruptor;

architecture Behavioral of interruptor is
type estado is (reposo, cambio);
signal estado_actual, estado_siguiente : estado;
signal mux, p_mux : std_logic;
begin
sinc: process (reset, clk)
 begin
 if (reset = '1') then
	estado_actual <= reposo;
 elsif (rising_edge(clk)) then
 estado_actual <= estado_siguiente;
 mux<=p_mux;
 end if;
end process;

salida <= entrada1 when mux='0' else entrada2;




fsm:process(estado_actual,check)
begin
--Valores por defecto.
p_mux<=mux;
case estado_actual is
	when reposo =>
		if(check='1') then
			estado_siguiente<=cambio;
			p_mux<='1';
		else
			estado_siguiente<=reposo;
			p_mux<='0';
		end if;
	when cambio =>
		if(check='1') then
			estado_siguiente<=reposo;
			p_mux<='0';
		else
			estado_siguiente<=cambio;
		  p_mux<='1';
		end if;
	end case;
end process;
end Behavioral;

