library ieee;
use ieee.std_logic_1164.all;

entity registradorenablenbits is  
	generic(N: positive := 8);
	port( 
	
	--Sinais de controle de entrada
	clk, reset, enable: in std_logic;
	
	--Sinais de dados de entrada
	d: in std_logic_vector(N-1 downto 0);
	
	--Sinais de dados de saida
	q: out std_logic_vector(N-1 downto 0)
	
	);
end entity;

architecture behav of registradorenablenbits is
	
	subtype InternalState is std_logic_vector(N-1 downto 0);		--Mudar conforme estado interno
	
	signal next_state, state_reg: InternalState;
	
begin
	--next_state logic (Combinatorial)
	next_state <= d when enable = '1' else state_reg; --Logica de entrada
	
	--Memory element -- internal state 
	process(clk, reset)
	begin
		if reset = '1' then
			state_reg <= (others => '0');  -- E´  a unica coisa que muda no elemento de memo´ria
		elsif rising_edge(clk) then
			state_reg <= next_state;
		end if;
	end process;
	
	--Output logic (Combinatorial)
	q <= state_reg; --Sem logica de saida

end architecture;