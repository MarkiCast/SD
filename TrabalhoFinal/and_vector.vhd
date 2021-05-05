library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
entity andvector is 
GENERIC (N : INTEGER := 4);
    port (
      Q: in std_logic_vector(N-1 downto 0);
      Mi: in std_logic;
      S: out std_logic_vector(N-1 downto 0)

    );
end andvector;

architecture rtl of andvector is
signal aux: std_logic_vector(N-1 downto 0);
begin

process(Q, Mi, aux)
begin
    and_vector : for i in 0 to N-1 loop
      aux(i) <= Q(i) and Mi;
    end loop and_vector;
	 S <= aux;
end process;

end rtl;