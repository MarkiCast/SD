library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.all;


entity multi_booth is
	GENERIC (N : INTEGER := 4);
	port (
			M, Q: in std_logic_vector(N-1 downto 0);
			Clock: in std_logic;
			Saida: out std_logic_vector((N*2)-1 downto 0);

			Amaior, Amenor, Aigual, pronto: out std_logic;
			RegM, RegN, RegAQ, mux_count, dlc, r: in std_logic;
			OP, mux_aq: in std_logic_vector(1 downto 0)
			
		  );
end multi_booth;

architecture behv of multi_booth is
	component Reg_multi is
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

component Comparador is
port(
		A:  in  std_logic;
		B:  in  std_logic;
		Maior:  out  std_logic;
		Igual:  out  std_logic;
		Menor:  out  std_logic
);
end component;

component Contador_multi is
GENERIC (N : INTEGER);
port(CLK: in std_logic;
  CLR: in std_logic;
  ENA: in std_logic;
  S: out std_logic
  );
end component;

signal pronto_s, NA : std_logic;
signal Maux: Std_logic_vector(N-1 downto 0);
signal Count, Countaux: Std_logic_vector(N-1 downto 0);
signal AQAux, AQ: Std_logic_vector((N*2)-1 downto 0);
signal Saux, signed_sem_motivo: SIGNED(N-1 downto 0);
signal S,numero_contador: std_logic_vector(N-1 downto 0);
constant zero: std_LOGIC_VECTOR(N-1 downto 0) := (others => '0') ;

begin 

PRONTO_SINAL : Contador_multi generic map (N => N)
					port map(
					CLK => Clock,
					CLR => R,
					ENA => RegN,
					S => Pronto_s);
					
with mux_aq select
	AQ <=	S&(AQAux(N-1 downto 0)) when "00",
			zero&Q when "01",
			AQAux when others;

with op select
	S <=  AQAux(N*2-1 downto N) - Maux when "01",
			AQAux(N*2-1 downto N) + Maux when "10",
			AQAux(N*2 - 1 downto N) when others;

with pronto_s select
	Saida <= AQAux  when '1',
				zero&zero when others;	
pronto <= pronto_s;

REGISTM : Reg_multi generic map (N => N)
			port map (
			CLK => Clock,
			R => R,
			E => RegM,
			Dlc => NA,
			D => M,
			Q => Maux
			);


REGISTAQ : Reg_multi generic map (N => N*2)
			port map (
			CLK => Clock,
			R => R,
			E => RegAQ,
			Dlc => Dlc,
			D => AQ,
			Q => AQaux
			);


COMP: Comparador port map(
			A => AQAux(0),
			B => AQAux(1),
			Maior => Amaior,
			Igual => Aigual,
			Menor => Amenor
			);

			
end behv;
    