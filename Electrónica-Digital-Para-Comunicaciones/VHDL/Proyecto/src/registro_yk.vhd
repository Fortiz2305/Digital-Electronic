----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:51:01 07/05/2015 
-- Design Name: 
-- Module Name:    registro_yk - Behavioral 
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

entity registro_yk is
	 Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (19 downto 0);
           dout : out  STD_LOGIC_VECTOR (19 downto 0);
           en : in  STD_LOGIC);
end registro_yk;

architecture Behavioral of registro_yk is

signal interna,interna2 : STD_LOGIC_VECTOR (19 downto 0);

begin
 interna2 <=interna when (en='0') else din;
 
 reg: process(clk,rst)
 begin
	if (rst = '1') then
		interna <= (others => '0');
	elsif (rising_edge(clk)) then
		interna <= interna2;
	end if;
 
 end process reg;

 dout<=interna;		

end Behavioral;

