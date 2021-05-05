library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Conta_multi is
GENERIC (N : INTEGER := 8);
port ( 
  CLK: in std_logic;
  CLR: in std_logic;
  ENA: in std_logic;
  S: out std_logic);
end ContaN;

architecture behv of ContaN is
  signal cnt: integer := N;
  signal pronto: std_logic;
  begin

  process(CLK,CLR, ENA)
  begin
    if (CLR = '1') then
      cnt <= N;
		pronto <=  '0';
		
    elsif (CLK'event and CLK = '1') then
     if (ENA = '1') then
        
        cnt <= cnt - 1;
        pronto <= '0';
      
        if(cnt= 0) then
           pronto <= '1';
            
            
         end if;
     
     end if;
    end if;
  end process;

  S <= pronto;

end behv;