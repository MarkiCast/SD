library ieee;
use ieee.std_logic_1164.all;

entity sequentialtemplate is  --Esse exemplo e´ um flipflopD
	port( 
	--Sinais de controle de entrada
	clk, reset: in std_logic;
	
	--Sinais de dados de entrada
	d: in std_logic;
	
	--Sinais de dados de saida
	q: out std_logic
	
	);
end entity;

architecture behav of sequentialtemplate is
	
	subtype InternalState is std_logic;		--Mudar conforme estado interno
	
	signal next_state, state_reg: InternalState;
	
begin
	--next_state logic (Combinatorial)
	next_state <= d; --Logica de entrada
	
	--Memory element -- internal state 
	process(clk, reset)
	begin
		if reset = '1' then
			state_reg <= '0';  -- E´  a unica coisa que muda no elemento de memo´ria
		elsif rising_edge(clk) then
			state_reg <= next_state;
		end if;
	end process;
	
	--Output logic (Combinatorial)
	q <= state_reg; --Sem logica de saida

end architecture;