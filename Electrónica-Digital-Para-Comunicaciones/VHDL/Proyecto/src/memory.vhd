--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:00:46 07/01/2015
-- Design Name:   
-- Module Name:   C:/Proyecto/src/memory.vhd
-- Project Name:  Proyecto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: coef_memory
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY memory IS
END memory;
 
ARCHITECTURE behavior OF memory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT coef_memory
    PORT(
         clka : IN  std_logic;
         wea : IN  std_logic_vector(0 downto 0);
         addra : IN  std_logic_vector(10 downto 0);
         dina : IN  std_logic_vector(19 downto 0);
         clkb : IN  std_logic;
         addrb : IN  std_logic_vector(10 downto 0);
         doutb : OUT  std_logic_vector(19 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clka : std_logic := '0';
   signal wea : std_logic_vector(0 downto 0) := (others => '0');
   signal addra : std_logic_vector(10 downto 0) := (others => '0');
   signal dina : std_logic_vector(19 downto 0) := (others => '0');
   signal clkb : std_logic := '0';
   signal addrb : std_logic_vector(10 downto 0) := (others => '0');

 	--Outputs
   signal doutb : std_logic_vector(19 downto 0);

   -- Clock period definitions
   constant clka_period : time := 10 ns;
   constant clkb_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: coef_memory PORT MAP (
          clka => clka,
          wea => wea,
          addra => addra,
          dina => dina,
          clkb => clka,
          addrb => addrb,
          doutb => doutb
        );

   -- Clock process definitions
   clka_process :process
   begin
		clka <= '0';
		wait for clka_period/2;
		clka <= '1';
		wait for clka_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		wait for 10 ns;
		addrb<=addrb+12;
		wait for 10 ns;
		addrb<=addrb+12;
      wait;
   end process;

END;
