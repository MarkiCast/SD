library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity contador is
	port (
			clk, enPC : in std_logic;
			S : out std_logic_vector (4 downto 0)
			);
end contador;

architecture behave of contador is
begin
	
	process(clk, enPC)
	variable c : integer range -1 to 31;
	begin
		if (rising_edge(clk) and enPC = '1') then
			c := c+1;
		end if;
		S <= conv_std_logic_vector(c,5);
	end process;
	
end;