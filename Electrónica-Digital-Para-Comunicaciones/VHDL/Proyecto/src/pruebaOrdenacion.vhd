--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:17:31 07/03/2015
-- Design Name:   
-- Module Name:   C:/proyectocanal/project/edc/pruebaOrdenacion.vhd
-- Project Name:  edc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memoryhestwriter
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY pruebaOrdenacion IS
END pruebaOrdenacion;
 
ARCHITECTURE behavior OF pruebaOrdenacion IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memoryhestwriter
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         address : OUT  std_logic_vector(10 downto 0);
         finish : OUT  std_logic;
         data : IN  std_logic_vector(31 downto 0);
         start : IN  std_logic
        );
    END COMPONENT;
    COMPONENT hest_memory
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;


   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal data : std_logic_vector(31 downto 0) := (others => '0');
   signal start : std_logic := '0';

 	--Outputs
   signal address : std_logic_vector(10 downto 0);
   signal finish : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memoryhestwriter PORT MAP (
          reset => reset,
          clk => clk,
          address => address,
          finish => finish,
          data => data,
          start => start
        );
	your_instance_name : hest_memory
  PORT MAP (
    clka => clk,
    wea => "0",
    addra => (others => '1'),
    dina => (others => '0'),
    clkb => clk,
    addrb => address,
    doutb => data
  );
   -- Clock process definitions
   clk_process :process
   begin
		if (finish /= '1') then
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
		end if;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      --wait for clk_period*10;
		start<='1';
      -- insert stimulus here 
		wait for 10 ns;
      start<='0';
		
		wait;
   end process;

END;
