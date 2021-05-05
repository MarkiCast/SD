library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity Comparador is
port (
		A:  in  std_logic;
		B:  in  std_logic;
		Maior:  out  std_logic;
		Igual:  out  std_logic;
		Menor:  out  std_logic
     );
end Comparador;

architecture behv of Comparador is
begin 
	Menor <= not(A) and B;
	Igual <= A xnor B;
	Maior <= A and not(B);
end behv;