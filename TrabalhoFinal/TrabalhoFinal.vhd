library ieee;
use ieee.std_logic_1164.all;

entity TrabalhoFinal is
generic (n : integer := 4);
port (
		clk: in std_logic;
		flagZ: out std_logic_vector(1 downto 0);
		S: out std_logic_vector(n-1 downto 0)
		);
end TrabalhoFinal;

architecture behave of trabalhoFinal is

	signal opcode : std_logic_vector (3 downto 0);
	signal enPC, enA, enB, enOut, enOp: std_logic;
	
	--Multi
	signal Amaior, Amenor, Aigual, pronto: std_logic;
	signal RegM, RegN, RegAQ, Mux_count, Dlc, R: std_logic;
	signal OP, mux_aq: std_logic_vector(1 downto 0);

	component bc IS
		PORT (
				clk : IN STD_LOGIC;
				opcode: in std_logic_vector(3 downto 0);
				enPC, enA, enB, enOut, enOp: OUT STD_LOGIC;
				
				--Multi
				Amaior, Amenor, Aigual, Pronto: in std_logic;
				RegM, RegN, RegAQ, mux_count, dlc, r: out std_logic;
				OP, mux_aq: out std_logic_vector(1 downto 0)
				
				);
		END component;

	component bo IS
	generic ( n : integer);
		PORT (
				clk, enPC, enA, enB, enOut, enOp : IN STD_LOGIC;
				opcode: out std_logic_vector(3 downto 0);
				S: out std_logic_vector (3 downto 0);
				flagZ: out std_logic_vector (1 downto 0);
				
				--Multi
				Amaior, Amenor, Aigual, pronto: out std_logic;
				RegM, RegN, RegAQ, mux_count, dlc, r: in std_logic;
				OP, mux_aq: in std_logic_vector(1 downto 0)
					
				);
		END component;
		
begin
	
	blocontrole: bc port map (clk, opcode, enPC, enA, enB, enOut, enOp,
										
									  --Multi
									  Amaior, Amenor, Aigual, pronto, RegM, RegN, RegAQ, mux_count, dlc, r, OP, mux_aq												
																							
																							);
																							
	blocoperativo: bo generic map (n) port map (clk, enPC, enA, enB, enOut, enOp, opcode, S, flagZ,
																
																--Multi
																Amaior, Amenor, Aigual, pronto, RegM, RegN, RegAQ, mux_count, dlc, r, OP, mux_aq
																
																																);

end behave;