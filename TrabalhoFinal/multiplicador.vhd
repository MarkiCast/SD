library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.all;


entity WallaceTree is
GENERIC (N : INTEGER := 4);
port (M, Q: in std_logic_vector(N-1 downto 0);
		clk, enMulti : in std_logic;
		Saida: out std_logic_vector((N*2)-1 downto 0));
end WallaceTree;

architecture behv of WallaceTree is

	  component andvector is
			generic (N : integer);
			port(
					Q: in std_logic_vector(N-1 downto 0);
					Mi: in std_logic;
					S: out std_logic_vector(N-1 downto 0)
				);
		end component;

	signal reset_reg, pronto: std_logic;
	type oitoarray is array (0 to N-1) of std_logic_vector(N-1 downto 0);
	type ANDARRAY is array (0 to N-1) of std_logic_vector((N*2)-1 downto 0);
	signal USEARRAY, SAIDA_MUX, PROxParcial, REGARRAY, PARTIALARRAY: ANDARRAY ;
	signal helplist: oitoarray; 
	signal criativo: std_logic_vector(n*2-1 downto 0);
	signal mux_reg, Enable_result: std_logic;
	signal controle_registradores, vetor_enable, enable_aux: std_logIC_VECTOR(n-1 to 0); 
	signal resultado: std_logic_vector(N*2-1 downto 0):=(others=>'0');

begin 

	 		
ESTAGIO1 : for i in 0 to N-1 generate

    ANDLIST : andvector generic map (N => N)
    port map (
      Q => Q,
      Mi => M(i),
      S => helplist(i)
    );
	 USEARRAY(i)(i+n-1 downto i) <= helplist(i);
	 USEARRAY(i)(i-1 downto 0) <= (others     => '0');
	 USEARRAY(i)(n*2-1 downto i+n) <= (others => '0');
	 REGARRAY(i) <= USEARRAY(i);
  end generate;

main : 
	process(clk, enMulti)
		variable soma : std_logic_vector(N*2-1 downto 0);
		begin
			if rising_edge(clk) and enMulti = '1' then
				soma := (others => '0');
				for n in 0 to N-1 loop
					soma := soma + REGARRAY(n);                           
				end loop;
			end if;
			saida <=  soma;
	end process;
				 	
end behv;