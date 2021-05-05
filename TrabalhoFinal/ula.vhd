library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use IEEE. NUMERIC_STD.ALL;

entity ula is
	generic (n : integer := 4);
	port (
			A,B : in std_logic_vector (n-1 downto 0);
			opc : in std_logic_vector (3 downto 0);
			flagZula : out std_logic_vector (1 downto 0);
			Sula : out std_logic_vector(n-1 downto 0);
			saida_multi : in std_logic_vector(n-1 downto 0);
			saida_divi : in std_logic_vector(n-1 downto 0)
			);
end ula;

architecture behave of ula is

begin
	
	with opc select 
		Sula <= A + B when "0000",
				  A - B when "0001",
				  A + 1 when "0010",
				  A - 1 when "0011",
				  not A when "0100",
				  A and B when "0101",
				  A or B when "0110",
				  A xor B when "0111",
				  saida_multi(n-1 downto 0) when "1000",
				  saida_divi(n-1 downto 0) when "1001",
				  "0000" when others;
				  
		flagZula <= "00";
	
		
end behave;