library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.all;

entity Reg_multi is 
GENERIC (N : INTEGER := 8);
	port (
    CLK: in std_logic;
    R: in std_logic;
    E: in std_logic;
	 Dlc: in std_logic;
    D: in std_logic_vector(N-1 downto 0);
    Q: out std_logic_vector(N-1 downto 0)
	 );
end Reg_multi;
architecture behv of Reg_multi is 
begin
    process(CLK, D, E, R, Dlc)
    begin
       if (R = '1') then
			Genbits: FOR i IN 0 TO N-1 LOOP
			Q(i)  <=  '0';
			END LOOP;

       else
            if (CLK'event and CLK = '1') then        
               if (E = '1') then
                    Q <= D;
					elsif (Dlc = '1') then
						Q <= D(N-1) & D(N-1 downto 1);
               end if;
                    
            end if;
       end if;
    end process;
end behv;