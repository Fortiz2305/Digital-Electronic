--------------------------------------------------------------------------------
-- Company: 
-- Engineer: Francisco Ortiz 
--
-- Create Date:   12:22:12 06/24/2015
-- Design Name:   
-- Module Name:   C:/Proyecto/src/fsm_tb.vhd
-- Project Name:  Proyecto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fsm
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
USE ieee.std_logic_signed.ALL;
USE work.vhdl_verification.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY proyecto_tb IS
END proyecto_tb;
 
ARCHITECTURE behavior OF proyecto_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fsm
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         data_rx : IN  std_logic_vector(19 downto 0);
         addr_rx : OUT  std_logic_vector(11 downto 0);
         data_pilot : IN  std_logic;
         addr_pilot : OUT  std_logic_vector(8 downto 0);
         data_hest : OUT  std_logic_vector(31 downto 0);
         addr_hest : OUT  std_logic_vector(11 downto 0);
         wre_hest : OUT  std_logic;
         start : IN  std_logic;
         stop : OUT  std_logic
        );
    END COMPONENT;
	 
	 COMPONENT coef_memory
	 PORT (
			clka : IN STD_LOGIC;
			wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			dina : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
			clkb : IN STD_LOGIC;
			addrb : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			doutb : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
			);
    END COMPONENT;
    
	 COMPONENT pilot_memory
	 PORT (
			clka : IN STD_LOGIC;
			wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			dina : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			clkb : IN STD_LOGIC;
			addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			doutb : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
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
	 
	  COMPONENT generaaddress
	  PORT (
			reset: in STD_LOGIC;
			clk : in  STD_LOGIC;
         address : out  STD_LOGIC_VECTOR (11 downto 0);
			address2 : out STD_LOGIC_VECTOR (11 downto 0);
			finish : out STD_LOGIC;
			valid: out STD_LOGIC;
			start: in STD_LOGIC 
			);
      END COMPONENT;
		
	  COMPONENT generaaddress_waiting 
     PORT ( 
			  reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           address : out  STD_LOGIC_VECTOR (11 downto 0);
			  address2: out STD_LOGIC_VECTOR (11 downto 0);
			  finish : out STD_LOGIC;
			  valid: out STD_LOGIC;
			  start: in STD_LOGIC
			  );
	  end COMPONENT;
		
	  COMPONENT ecualizador 
	  PORT ( 
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           hk : in  STD_LOGIC_VECTOR (31 downto 0);
           yk : in  STD_LOGIC_VECTOR (19 downto 0);
			  stop_in : in STD_LOGIC;
			  stop_out : out STD_LOGIC;
           zk : out  STD_LOGIC_VECTOR (31 downto 0);
			  data_valid : out STD_LOGIC
			  );
	  END COMPONENT;
	  -- Multiplexador
	  COMPONENT interruptor
		PORT(
				clk : IN std_logic;
				reset : IN std_logic;
				enable : IN std_logic;
				check : IN std_logic;
				entrada1 : IN std_logic_vector(11 downto 0);
				entrada2 : IN std_logic_vector(11 downto 0);          
				salida : OUT std_logic_vector(11 downto 0)
				);
		END COMPONENT;
				
	  COMPONENT reg_bin 
	  PORT ( 
			  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           entrada : in  STD_LOGIC;
           salida : out  STD_LOGIC;
           en : in  STD_LOGIC
			  );
	  END COMPONENT;
	  
   --Inputs fsm
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal start : std_logic := '0';

 	--Outputs fsm
   signal addr_rx : std_logic_vector(11 downto 0);
   signal addr_pilot : std_logic_vector(8 downto 0);
   signal data_hest : std_logic_vector(31 downto 0);
   signal addr_hest : std_logic_vector(11 downto 0);
   signal wre_hest : std_logic;
   signal stop, stop_delayed : std_logic := '0';
	
	--Signals coef_memory
	signal doutb : std_logic_vector (19 downto 0);
	signal wea_v: std_logic_vector (0 downto 0) := (others => '0');
	signal wea : std_logic := '0';
	signal dina : std_logic_vector (19 downto 0) := (others => '0');
	signal addra : std_logic_vector (10 downto 0) := "11111111111";
	
	--Signals pilot_memory
	signal doutb_pilot_v : std_logic_vector (0 downto 0);
	signal wea_pilot_v : std_logic_vector (0 downto 0) := (others => '0');
	signal wea_pilot : std_logic := '0';
	signal dina_pilot_v : std_logic_vector (0 downto 0) := (others => '0');
	signal addra_pilot : std_logic_vector (7 downto 0) := "11111111";
	
	--Signals hest_memory
	signal wea_hest_v : std_logic_vector (0 downto 0);
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	--Signals memoryhestwriter and datawriter
	signal datavalid,finished,finished2,finished_delayed,datavalid_equalizer : std_logic := '0';
	signal addr_hest_writer, addr_unused : std_logic_vector(11 downto 0);
	signal data_writer : std_logic_vector (31 downto 0) := (others=>'0');
	signal enable_equalizer : std_logic := '0';
	--Signals equalizer
	signal equalized_signal : std_logic_vector (31 downto 0);
	signal final_stop : std_logic := '0';
 
   --Señales para la multiplexion de los puertos de la memoria
	signal addr_rx_fsm, addr_rx_ag : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
	signal addr_hest_writer1, addr_hest_writer2 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fsm PORT MAP (
          clk => clk,
          rst => rst,
          data_rx => doutb,
          addr_rx => addr_rx_fsm,
          data_pilot => doutb_pilot_v(0),
          addr_pilot => addr_pilot,
          data_hest => data_hest,
          addr_hest => addr_hest,
          wre_hest => wre_hest,
          start => start,
          stop => stop
			 );

   wea_v(0) <= wea;
	coe_memory: coef_memory PORT MAP (
			 clka => clk,
			 wea => wea_v,
			 addra => addra,
			 dina => dina,
			 clkb => clk,
			 addrb => addr_rx(10 downto 0),
			 doutb => doutb
			 );
	
	wea_pilot_v(0) <= wea_pilot;
	pil_memory: pilot_memory PORT MAP (
			 clka => clk,
			 wea => wea_pilot_v,
			 addra => addra_pilot,
			 dina => dina_pilot_v,
			 clkb => clk,
			 addrb => addr_pilot(7 downto 0),
			 doutb => doutb_pilot_v
			 );
	
	wea_hest_v(0) <= wre_hest;
	hest: hest_memory PORT MAP (
			 clka => clk,
			 wea => wea_hest_v,
			 addra => addr_hest(10 downto 0),
			 dina => data_hest,
			 clkb => clk,
			 addrb => addr_hest_writer(10 downto 0),
			 doutb => data_writer
			 );
	--Instancia del datawrite para escribir en fichero
	datawrite_inst: datawrite
	GENERIC MAP (
		SIMULATION_LABEL => "estimador_out",
		VERBOSE => false,
		DEBUG => false,
		OUTPUT_FILE => "./out/estimated_channel.txt",
		OUTPUT_NIBBLES => 8,
		DATA_WIDTH => 32
		)
	PORT MAP (
			 clk => clk,
			 data => data_writer,
			 valid => datavalid,
			 endsim => finished
	       );
			 
	--Esta instancia permite multiplexar el puerto de lectura de la memoria RX.
	Inst_interruptor: interruptor PORT MAP(
		clk => clk,
		reset => rst,
		enable => '1',
		check => stop,
		entrada1 => addr_rx_fsm,
		entrada2 => addr_rx_ag,
		salida => addr_rx
	);
	
	 --Registro de un bit para retrasar una señal
	Inst_registrouno: reg_bin PORT MAP(
		reset => rst,
		entrada => stop,
		salida => stop_delayed,
		clk => clk,
		en => '1'
	);

			 
	--Instancia para obtener datos de la memoria. Esta instancia permite 
	--generar todas las direcciones que se introducen en la memoria de canal estimado 
	genera_address_hest : generaaddress PORT MAP (
			 reset => rst,
			 clk => clk,
			 address => addr_hest_writer1,
			 address2 => addr_unused,
			 finish => finished,
			 valid => datavalid,
			 start => stop_delayed
			 );
	--Esta instancia permite generar las direcciones que se introducen en las memorias 
	--de canal estimado y de datos recibidos. Es necesario para el ecualizador
	genera_address_equalizer : generaaddress_waiting PORT MAP (
			 reset => rst,
			 clk => clk,
			 address => addr_hest_writer2,
			 address2 => addr_rx_ag,
			 finish => finished2,
			 valid => enable_equalizer,
			 start => finished_delayed
			 );
			 
	Inst_registrouno2: reg_bin PORT MAP(
			 reset => rst,
			 entrada => finished,
			 salida => finished_delayed,
			 clk => clk,
			 en => '1'
			 );
		
	--Multiplexa el puerto de lectura de la memoria Hest, utilizado por las dos instancias de address_generator.	
		Inst_interruptor2: interruptor PORT MAP(
			 clk => clk,
			 reset => rst,
			 enable => '1',
			 check => finished,
			 entrada1 => addr_hest_writer1,
			 entrada2 => addr_hest_writer2,
			 salida => addr_hest_writer
			 );
	
   --Ecualizador	
	ecualiza : ecualizador PORT MAP (
			  clk => clk,
           rst => rst,
           en => enable_equalizer,
           hk => data_writer,
           yk => doutb,
			  stop_in => finished2,
			  stop_out => final_stop,
           zk => equalized_signal,
			  data_valid => datavalid_equalizer
			  );
			  
	--Escribir la salida del ecualizador
	datawrite_inst2: datawrite 
	GENERIC MAP (
		SIMULATION_LABEL => "ecualizador_out",
		VERBOSE => false,
		DEBUG => false,
		OUTPUT_FILE => "./out/ecualized_signal.txt",
		OUTPUT_NIBBLES => 8,
		DATA_WIDTH => 32
		)
	PORT MAP (
			 clk => clk,
			 data => equalized_signal,
			 valid => datavalid_equalizer,
			 endsim => final_stop 
	       );
			  
   -- Clock process definitions
   clk_process :process
   begin
		if (final_stop /= '1') then
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

      wait for clk_period*10;

      -- insert stimulus here 
		rst<='1';
		wait for 50 ns;	
		rst<='0';
		wait for 50 ns;	
		start<='1';
		wait for 20 ns;
		start<='0';

      wait;
   end process;

END;
