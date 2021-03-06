library ieee;
use ieee.std_logic_1164.all;

entity reg is
	generic (n : integer);
	port (
			clk, enable : in std_logic;
			E: in std_logic_vector(n-1 downto 0);
			S : out std_logic_vector(n-1 downto 0)
			);
end reg;

architecture behave of reg is
begin
	
	process(clk, enable)
	begin
		if rising_edge(clk) and enable = '1' then
			S <= E;
		end if;
	end process;
end;