library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.all;


entity divisor is
GENERIC (N : INTEGER := 4);
port (
		Q: in std_logic_vector(N-1 downto 0);
		M: in std_logic_vector(n-1  downto 0);
		resultado: out std_logic_vector(n-1 downto 0);
		
		--divisor
		Amenor, Pronto: out std_logic;
		clk, RegM, RegN, RegAQ, Q0, Dlc, R: in std_logic;
		OP, mux_aq: in std_logic_vector(1 downto 0)
     );
end divisor;

architecture behv of divisor is
component Reg_divisor is
generic (N : integer);
port(
		 CLK: in std_logic;
		 R: in std_logic;
		 E: in std_logic;
		 Dlc: in std_logic;
		 D: in std_logic_vector(N-1 downto 0);
		 Q: out std_logic_vector(N-1 downto 0)
		 
		 );
end component;

	component ContaN is
		GENERIC (N : INTEGER);
		port(CLK: in std_logic;
			  CLR: in std_logic;
			  ENA: in std_logic;
			  S: out std_logic
			  );
	end component;

	signal Maux:std_logic_vector((N/2)downto 0);
	signal AQ, AQaux: std_logic_vector(N*2 downto 0);
	constant zero: std_LOGIC_VECTOR(N downto 0) := (others => '0') ;
	signal S: std_LOGIC_VECTOR(N downto 0);
	signal saida: std_logic_vector((N*2) downto 0);
	signal Mmodificado: std_logic_vector(N/2 downto 0) := (others => '0');
	signal RegCount, Reset_Reg: std_logic;
	signal NA: std_logic := '0';

begin 
	Mmodificado <= "0" & M(N/2-1 downto 0);

	Amenor <= std_logic(AQAux((N*2)));
	REGISTM : Reg_divisor generic map (N => N/2 +1)
				port map (
				CLK => clk,
				R => Reset_Reg,
				E => RegM,
				Dlc => NA,
				D => Mmodificado,
				Q => Maux
				);


	REGISTAQ : Reg_divisor generic map (N => N*2+1)
				port map (
				CLK => clk,
				R => Reset_Reg,
				E => RegAQ,
				Dlc => Dlc,
				D => AQ,
				Q => AQaux
				);

	PRONTO_SINAL : ContaN generic map (N => N/2 + 1)
						port map(
						CLK => clk,
						CLR => Reset_Reg,
						ENA => RegCount,
						S => Pronto
						);

	with mux_aq select
		AQ <=	S&(AQAux(N-1 downto 0)) when "00",
				zero&Q when "01",
				AQAux(N*2 downto 1)&q0 when "11",
				AQAux when others;

	with op select
		S <=  AQAux(N*2 downto N) - Maux when "01",
				AQAux(N*2 downto N) + Maux when "10",
				AQAux(N*2 downto N) when others;	
			
	
	resultado <= saida(n-1 downto 0);
	
	Saida <= AQAux;
	
end behv;
    