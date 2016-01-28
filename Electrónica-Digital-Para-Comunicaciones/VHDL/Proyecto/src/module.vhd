----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:01:08 07/04/2015 
-- Design Name: 
-- Module Name:    module - Behavioral 
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

entity module is
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           din_hest : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end module;

architecture Behavioral of module is

signal p_module,module : STD_LOGIC_VECTOR (31 downto 0);

begin

dout <= module;

 comb: process (en,din_hest,module)
 begin
   if (en = '1') then
		p_module <= din_hest(31 downto 16)*din_hest(31 downto 16) + din_hest(15 downto 0)*din_hest(15 downto 0);
	else 
		p_module <= module;
	end if;
 end process;

 sinc: process (rst, clk)
 begin
	if (rst = '1') then
		module <= (others => '0');
	elsif (rising_edge(clk)) then
		module <= p_module;
   end if;
 end process;

end Behavioral;

