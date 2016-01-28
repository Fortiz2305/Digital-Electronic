----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:19:47 07/04/2015 
-- Design Name: 
-- Module Name:    conjugador - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conjugador is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           din_hest : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end conjugador;

architecture Behavioral of conjugador is

signal p_conj,conj : STD_LOGIC_VECTOR (31 downto 0);

begin

dout <= conj;

comb: process (en,din_hest,conj)
 begin
   if (en = '1') then
		p_conj(31 downto 16) <= din_hest(31 downto 16);
		p_conj(15 downto 0) <= (NOT din_hest(15 downto 0)) + 1;
	else
		p_conj <= conj;
	end if;
 end process;

 sinc: process (rst, clk)
 begin
	if (rst = '1') then
		conj <= (others => '0');
	elsif (rising_edge(clk)) then
		conj <= p_conj;
   end if;
 end process;

end Behavioral;

