----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:03:58 07/04/2015 
-- Design Name: 
-- Module Name:    multiplicaysatura - Behavioral 
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

entity multiplicaysatura is
    Port ( din_divisor : in  STD_LOGIC_VECTOR (31 downto 0);
           din_conj : in  STD_LOGIC_VECTOR (31 downto 0);
           en : in STD_LOGIC;
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           dout_sat : out  STD_LOGIC_VECTOR (21 downto 0));
end multiplicaysatura;

architecture Behavioral of multiplicaysatura is

signal dout_aux,p_dout_aux : STD_LOGIC_VECTOR (95 downto 0);

begin

dout_sat(21) <= dout_aux(95);
dout_sat(20 downto 11) <= dout_aux(57 downto 48);
dout_sat(10) <= dout_aux(47);
dout_sat(9 downto 0) <= dout_aux(9 downto 0);

comb: process (en,din_divisor,din_conj, dout_aux)
 begin
   if (en = '1') then
		p_dout_aux(95 downto 48) <= din_divisor * din_conj(31 downto 16);
		p_dout_aux(47 downto 0) <= din_divisor * din_conj(15 downto 0);
	else 
		p_dout_aux <= dout_aux;
	end if;
 end process;

 sinc: process (rst, clk)
 begin
	if (rst = '1') then
		dout_aux <= (others => '0');
	elsif (rising_edge(clk)) then
		dout_aux <= p_dout_aux;
   end if;
 end process;

end Behavioral;

