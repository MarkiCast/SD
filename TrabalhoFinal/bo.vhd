library ieee;
use ieee.std_logic_1164.all;

entity bo is
generic (n : integer := 4);
port (
		clk, enPC, enA, enB, enOut : IN STD_LOGIC;
		opcode: buffer std_logic_vector(3 downto 0);
		S: out std_logic_vector (3 downto 0);
		flagZ: out std_logic_vector (1 downto 0)
		);
end bo;

architecture behave of bo is

	signal pc : std_logic_vector (2 downto 0);
	signal A, B, Sula : std_logic_vector (n-1 downto 0);
	signal opUla : std_logic_vector(3 downto 0);
	signal flagZula : std_logic_vector(1 downto 0);

	component contador is
	port (
			clk, enPC : in std_logic;
			S : out std_logic_vector (2 downto 0)
			)
	end component;
	
	component ROM is
	generic (n : integer);
	port {
			clk : in std_logic;
			pc : in std_logic_vector(2 downto 0);
			dado : out std_logic_vector(n-1 downto 0)
			}
	end component

	component reg is
	generic (n : integer);
	port {
			clk, enable : in std_logic;
			E: in std_logic_vector(n-1 downto 0);
			S : out std_logic_vector(n-1 downto 0)
			}
	end component

	component ula is
	generic (n : integer);
	port {
			A,B : in std_logic_vector (n-1 downto 0);
			opc : in std_logic_vector (3 downto 0);
			flagZula : out std_logic_vector (1 downto 0);
			Sula : out std_logic_vector(n-1 downto 0)
			}
	end component
		
begin
	
	regPC : contador port map (clk, enPC, pc);
	rom: rom generic map (n) port map (clk, pc, opcode);
	regA : reg generic map (n) port map (clk, enA, opcode, A);
	regB : reg generic map (n) port map (clk, enB, opcode, B);
	regOp : reg generic map (n) port map (clk, enOp, opcode(3 downto 0), opUla);
	regS : reg generic map (n) port map (clk, enOut, Sula, S);
	regZ : reg generic map (2) port map (clk, enOut, flagZula, flagZ);
	ula : ula generic map (n) port map (A, B, opc, flagZula, Sula);
	

end behave;