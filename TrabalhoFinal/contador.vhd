library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contador is
	port (
			clk, enPC : in std_logic;
			S : out std_logic_vector (4 downto 0)
			);
end contador;

architecture behave of contador is

	signal c : std_logic_vector(4 downto 0) := "00000";

begin
	
	process(clk, enPC)
	begin
		if (rising_edge(clk) and enPC = '1') then
			c <= c+1;
		end if;
	end process;
	
	S <= c;
	
end;