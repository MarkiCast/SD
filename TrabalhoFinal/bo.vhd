library ieee;
use ieee.std_logic_1164.all;

entity bo is
generic (n : integer := 4);
port (
		clk, enPC, enA, enB, enOut, enOp, enMulti : in std_logic;
		opcode: out std_logic_vector(3 downto 0);
		S: out std_logic_vector (3 downto 0);
		flagZ: out std_logic_vector (1 downto 0)
		);
end bo;

architecture behave of bo is

	signal pc : std_logic_vector (4 downto 0);
	signal A, B, Sula : std_logic_vector (n-1 downto 0);
	signal opUla: std_logic_vector(3 downto 0);
	signal flagZula : std_logic_vector(1 downto 0);
	signal dado : std_logic_vector(7 downto 0);
	signal saida_multi : std_logic_vector ((2*n)-1 downto 0);

	component contador is
	port (	
			clk, enPC : in std_logic;
			S : buffer std_logic_vector (4 downto 0)
			);
	end component;
	
	component ROM is
	port (
			address : in std_logic_vector(4 downto 0);
			clock : in std_logic;
			q : out std_logic_vector(7 downto 0)
			);
	end component;

	component reg is
	generic (n : integer);
	port (
			clk, enable : in std_logic;
			E: in std_logic_vector(n-1 downto 0);
			S : out std_logic_vector(n-1 downto 0)
			);
	end component;

	component ula is
	generic (n : integer);
	port (
			A,B : in std_logic_vector (n-1 downto 0);
			opc : in std_logic_vector (3 downto 0);
			flagZula : out std_logic_vector (1 downto 0);
			Sula : out std_logic_vector(n-1 downto 0);
			saida_multi : in std_logic_vector(n-1 downto 0)
			);
	end component;
		
	component WallaceTree is
	GENERIC (N : INTEGER := 4);
	port (M, Q: in std_logic_vector(N-1 downto 0);
			clk, enMulti: std_logic;
			Saida: out std_logic_vector((N*2)-1 downto 0));
	end component;
		
begin
	
	opcode <= opUla;
	
	regPC : contador port map (clk, enPC, pc);
	memoria: rom port map (pc, clk, dado);
	regA : reg generic map (n) port map (clk, enA, dado(n-1 downto 0), A);
	regB : reg generic map (n) port map (clk, enB, dado(n-1  downto 0), B);
	regOp : reg generic map (n) port map (clk, enOp, dado(3 downto 0), opUla);
	regS : reg generic map (n) port map (clk, enOut, Sula, S);
	regZ : reg generic map (2) port map (clk, enOut, flagZula, flagZ);
	ula1 : ula generic map (n) port map ( A, B, opUla, flagZula, Sula, saida_multi(n-1 downto 0));
	
	multi : WallaceTree generic map (n) port map (A,B,clk,enMulti,saida_multi);
	
end behave;