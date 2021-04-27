library ieee;
use ieee.std_logic_1164.all;

entity TrabalhoFinal is
generic (n : integer := 4);
port (
		clk: in std_logic;
		flagZ: in std_logic_vector(1 downto 0);
		S: out std_logic_vector(n-1 downto 0);
		);
end TrabalhoFinal;

architecture behave of trabalhoFinal is

	signal opcode : std_logic_vector (3 downto 0);
	signal enPC, enA, enB, enOut: std_logic;

	component bc IS
		PORT (
				clk : IN STD_LOGIC;
				opcode: in std_logic_vector(3 downto 0);
				enPC, enA, enB, enOut: OUT STD_LOGIC
				);
		END component;

	component bo IS
	generic ( n : integer);
		PORT (
				clk, enPC, enA, enB, enOut : IN STD_LOGIC;
				opcode: in std_logic_vector(3 downto 0);
				S: out std_logic_vector (3 downto 0);
				flagZ: out std_logic_vector (1 downto 0)
				);
		END component;
		
begin
	
	blocontrole: bc port map (clk, opcode, enPC, enA, enB, enOut);
	blocoperativo: bo generic map (n) port map (clk, enPC, enA, enB, enOut, opcode, S, flagZ);

end behave;