----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:38:50 07/07/2015 
-- Design Name: 
-- Module Name:    regbin_escribeEQ - Behavioral 
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

entity regbin is
	Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           entrada : in  STD_LOGIC;
           salida : out  STD_LOGIC;
           en : in  STD_LOGIC);
end regbin;

architecture Behavioral of regbin is

signal interna,interna2 : STD_LOGIC;

begin
interna2 <=interna when (en='0') else entrada;

reg: process(clk)
begin
	if (reset = '1') then
		interna <= '0';
	elsif (clk'event) and (clk = '1')then
		interna <= interna2;
	end if;
end process reg;
salida<=interna;
		
end Behavioral;


