library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use IEEE. NUMERIC_STD.ALL;

entity ula is
	generic (n : integer);
	port (
			A,B : in std_logic_vector (n-1 downto 0);
			opc : in std_logic_vector (3 downto 0);
			flagZula : out std_logic_vector (1 downto 0);
			Sula : out std_logic_vector(n-1 downto 0)
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
				  std_logic_vector(signed(A) * signed(B))(3 downto 0) when "1000",
				  std_logic_vector(signed(A) / signed(B)) when "1001",
				  "0000" when others;
				  
--	process (A,B,Sula,opc)
--	begin
--		if (a(n-1) = '0' and b(n-1) = '0') then
--			flagZula <= "0001";
--		end if;
--	end process;
		
end;