----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:03:58 07/04/2015 
-- Design Name: 
-- Module Name:    multiplicaconj - Behavioral 
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

entity multiplicaysatura2 is
    Port ( din_canal : in  STD_LOGIC_VECTOR (21 downto 0);
           din_rx : in  STD_LOGIC_VECTOR (19 downto 0);
           en : in STD_LOGIC;
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           resul_sat : out  STD_LOGIC_VECTOR (31 downto 0));
end multiplicaysatura2;

architecture Behavioral of multiplicaysatura2 is

signal dout_aux,p_dout_aux : STD_LOGIC_VECTOR (41 downto 0);

begin

--Saturación del resultado 
--Bit de signo parte real 
resul_sat(31) <= dout_aux(41);
resul_sat(30 downto 16) <= "111111111111111" when dout_aux(41 downto 21) > "000000111111111111111" else
									"000000000000000" when dout_aux(41 downto 21) < "111111000000000000000" 
									else dout_aux(35 downto 21);
--Bit de signo parte imaginaria
resul_sat(15) <= dout_aux(20);
resul_sat(14 downto 0) <= "111111111111111" when dout_aux(20 downto 0) > "000000111111111111111" else
								  "000000000000000" when dout_aux(20 downto 0) < "111111000000000000000"
								  else dout_aux(14 downto 0);

comb: process (en,din_canal,din_rx, dout_aux)
 begin
   if (en = '1') then
		p_dout_aux(41 downto 21) <= din_canal(21 downto 11) * din_rx(19 downto 10);
		p_dout_aux(20 downto 0) <= din_canal(10 downto 0) * din_rx(9 downto 0);
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

