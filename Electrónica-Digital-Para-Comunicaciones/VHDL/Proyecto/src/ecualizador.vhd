----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Francisco Ortiz Abril 
-- 
-- Create Date:    13:48:41 07/04/2015 
-- Design Name: 
-- Module Name:    ecualizador - Behavioral 
-- Project Name: 	 ESTIMADOR Y ECUALIZADOR DE CANAL
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

entity ecualizador is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           hk : in  STD_LOGIC_VECTOR (31 downto 0);
           yk : in  STD_LOGIC_VECTOR (19 downto 0);
			  stop_in : in STD_LOGIC;
			  stop_out : out STD_LOGIC;
           zk : out  STD_LOGIC_VECTOR (31 downto 0);
			  data_valid : out STD_LOGIC);
end ecualizador;

architecture Behavioral of ecualizador is
	
	component module 
		Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           din_hest : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
	end component;
	
	component conjugador 
		Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           din_hest : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
	end component;
	
	component reg_retraso
		Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0);
           en : in  STD_LOGIC
			  );
	end component;
	
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
	
	component multiplicaysatura 
		Port ( din_divisor : in  STD_LOGIC_VECTOR (31 downto 0);
           din_conj : in  STD_LOGIC_VECTOR (31 downto 0);
           en : in STD_LOGIC;
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           dout_sat : out  STD_LOGIC_VECTOR (21 downto 0)
			  );
	end component;
	
	component multiplicaysatura2 
		Port ( din_canal : in  STD_LOGIC_VECTOR (21 downto 0);
           din_rx : in  STD_LOGIC_VECTOR (19 downto 0);
           en : in STD_LOGIC;
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           resul_sat : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
	end component;
	
	component registro_yk 
		Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (19 downto 0);
           dout : out  STD_LOGIC_VECTOR (19 downto 0);
           en : in  STD_LOGIC
			  );
	end component;

	component reg_bin 
		Port ( clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           entrada : in  STD_LOGIC;
           salida : out  STD_LOGIC;
           en : in  STD_LOGIC
			  );
	end component;

	
	--Signals------------------------------------------------------------------------------	
	signal resul_modulo : STD_LOGIC_VECTOR (31 downto 0);
	signal resul_divisor : STD_LOGIC_VECTOR (31 downto 0);
	signal resul_conjugado : STD_LOGIC_VECTOR (31 downto 0);
	signal resul_conjugado_retrasado : STD_LOGIC_VECTOR (31 downto 0);
	signal resul_inversa_canal : STD_LOGIC_VECTOR (21 downto 0);
	signal resul_zk : STD_LOGIC_VECTOR (31 downto 0);
	signal yk2,yk3,yk4 : STD_LOGIC_VECTOR(19 downto 0);
	signal rfd : STD_LOGIC;
	signal fractional : STD_LOGIC_VECTOR(31 downto 0);
	signal quotient : STD_LOGIC_VECTOR (31 downto 0);
	signal stop2, stop3, stop4 : STD_LOGIC;
	signal enable2,enable3,enable4 : STD_LOGIC;

begin
	
	Inst_module: module PORT MAP (
			din_hest => hk,
			en => '1',
			rst => rst,
			clk => clk,
			dout => resul_modulo
			);
			
	resul_divisor <= 	quotient + fractional;
	Inst_divisor : divisor PORT MAP (
			clk => clk,
			ce => '1',
			rfd => rfd,
			dividend => "00000000000000000000000000000001",
			divisor => resul_modulo,
			quotient => quotient,
			fractional => fractional
			);
			
	Inst_conjugador: conjugador PORT MAP (
			clk => clk,
			en => '1',
			rst => rst,
			din_hest => hk,
			dout => resul_conjugado
			);
			
	Inst_registro: reg_retraso PORT MAP(
			clk => clk,
			rst => rst,
			din => resul_conjugado,
			dout => resul_conjugado_retrasado,
			en => '1'
			);

	Inst_multiplicaysatura: multiplicaysatura PORT MAP(
			clk => clk,
			rst => rst,
			en => '1',
			din_divisor => resul_divisor,
			din_conj => resul_conjugado_retrasado,
			dout_sat => resul_inversa_canal
			);
			
	Inst_multiplicaysatura2: multiplicaysatura2 PORT MAP(
			clk => clk,
			rst => rst,
			en => '1',
			din_canal => resul_inversa_canal,
			din_rx => yk4,
			resul_sat => zk
			);
	--Se retrasa 3 ciclos de reloj el dato yk	
	Inst_registro_yk1: registro_yk PORT MAP(
			clk => clk,
			rst => rst,
			en => '1',
			din => yk,
			dout =>yk2 
			);
			
	Inst_registro_yk2: registro_yk PORT MAP(
			clk => clk,
			rst => rst,
			en => '1',
			din => yk2,
			dout => yk3
			);
			
	Inst_registro_yk3: registro_yk PORT MAP(
			clk => clk,
			rst => rst,
			en => '1',
			din => yk3,
			dout => yk4
			);
	-- Se retrasa 4 ciclos de reloj la señal del generador de direcciones		
	Inst_regbin : reg_bin PORT MAP(
			clk => clk,
			reset => rst,
         entrada => stop_in,
         salida => stop2,
         en => '1'
			);
		
	Inst_regbin2 : reg_bin PORT MAP(
			clk => clk,
			reset => rst,
         entrada => stop2,
         salida => stop3,
         en => '1'
			);
			
	Inst_regbin3 : reg_bin PORT MAP(
			clk => clk,
			reset => rst,
         entrada => stop3,
         salida => stop4,
         en => '1'
			);
			
	Inst_regbin4 : reg_bin PORT MAP(
			clk => clk,
			reset => rst,
         entrada => stop4,
         salida => stop_out,
         en => '1'
			);
			
	--RETRASAMOS 4 CICLOS DE RELOJ LA SEÑAL DE DATA_VALID; DADA POR EL GENERADOR DE DIRECCIONES
	Inst_regbin5: reg_bin PORT MAP(
		reset => rst,
		entrada => en,
		salida => enable2,
		clk => clk,
		en => '1'
		);
		
	Inst_regbin6: reg_bin PORT MAP(
		reset => rst,
		entrada => enable2,
		salida => enable3,
		clk => clk,
		en => '1'
		);
		
	Inst_regbin7: reg_bin PORT MAP(
		reset => rst,
		entrada => enable3,
		salida => enable4,
		clk => clk,
		en => '1'
		);
		
	Inst_regbin8: reg_bin PORT MAP(
		reset => rst,
		entrada => enable4,
		salida => data_valid,
		clk => clk,
		en => '1'
		);
		
end Behavioral;


