LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (clk : IN STD_LOGIC;
		opcode: in std_logic_vector(3 downto 0);
		enPC, enA, enB, enOut: OUT STD_LOGIC
		);
END bc;

ARCHITECTURE behave OF bc IS
	--TYPE state_type IS (S0, S1, S2, S3, S4, S5 );
	--SIGNAL state: state_type;
BEGIN
	-- Logica de proximo estado (e registrador de estado)
--	PROCESS (clk, opcode)
--	BEGIN
--		if(Reset = '1') THEN
--			state <= S0 ;
--		ELSIF (clk'EVENT AND clk = '1') THEN
--			CASE state IS
--				WHEN S0 => if (inicio = '1') THEN
--									state <= S1;
--								end if;
--				WHEN S1 => state <= S2; 
--							  
--
--				WHEN S2 => if ((Az or Bz) = '1') THEN
--									state <= S5;
--							  else 
--									state <= S3;
--							  end if;
--
--				WHEN S3 => state <= S4;	
--
--				WHEN S4 => state <= S2;
--
--				WHEN S5 => state <= S0;	
--
--			END CASE;
--		END IF;
--	END PROCESS;
--	
--	-- Logica de saida
--	PROCESS (state)
--	BEGIN
--		CASE state IS
--			WHEN S0 =>
--				ini <= '0';
--				CA <= '0';
--				dec <= '0';
--				CP <= '0';
--				pronto <= '0';
--				
--			WHEN S1 => dec <= '0';
--						  CP <= '0';
--						  pronto <= '0';
--						  ini <='1';
--						  CA <='1';
--				
--			WHEN S2 => CP <= '0';
--						  ini <= '0';
--						  CA <= '0';
--						  dec <= '0';
--						  pronto <= '0';
--				
--			WHEN S3 =>dec <= '0'; 
--				       CA <= '0';
--						 CP <= '1';
--						 pronto <= '0';
--						 ini <='0';
--
--			WHEN S4 =>ini <= '0';
--						CA <= '1';
--						dec <= '1';
--						CP <= '0';
--						pronto <= '0';
--				
--			WHEN S5 =>ini <= '0';
--						CA <= '0';
--						dec <= '0';
--						CP <= '0';
--						pronto <= '1';
--
--		END CASE;
--	END PROCESS
END behave;