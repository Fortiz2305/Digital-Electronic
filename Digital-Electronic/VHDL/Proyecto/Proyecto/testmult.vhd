
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 USE ieee.std_logic_signed.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testmult IS
END testmult;
 
ARCHITECTURE behavior OF testmult IS
    
   --Inputs
   signal a : std_logic_vector(12 downto 0);
	--signal b : std_logic;
	signal c : std_logic_vector(9 downto 0);

BEGIN
   
	c <= "1100001101";
	a <= c * "101";
 

--   -- Stimulus process
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for clk_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;

END;
