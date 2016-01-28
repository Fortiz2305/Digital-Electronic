--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:26:06 07/06/2015
-- Design Name:   
-- Module Name:   C:/Proyecto/src/prueba_divisor.vhd
-- Project Name:  Proyecto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: module
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
use ieee.std_logic_signed.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY prueba_divisor IS
END prueba_divisor;
 
ARCHITECTURE behavior OF prueba_divisor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component divisor
		Port ( clk: in std_logic;
				 ce: in std_logic;
				 rfd: out std_logic;
			    dividend: in std_logic_vector(31 downto 0);
				 divisor: in std_logic_vector(31 downto 0);
				 quotient: out std_logic_vector(31 downto 0);
				 fractional: out std_logic_vector(31 downto 0)
				 );
		end component;

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
   
 	--Outputs
   signal resul_divisor : std_logic_vector(31 downto 0);
	signal fractional : std_logic_vector(31 downto 0);
	signal quotient : std_logic_vector (31 downto 0);
	signal rfd : std_logic;
	signal div : std_logic_vector(31 downto 0) := "00000000000000000000000000000001";

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	Inst_divisor : divisor PORT MAP (
			clk => clk,
			ce => '1',
			rfd => rfd,
			dividend => "00000000000000000000000000000010",
			divisor => div,
			quotient => quotient,
			fractional => fractional
			);
		resul_divisor <= quotient + fractional;
			
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
