LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (clk : IN STD_LOGIC;
		opcode: in std_logic_vector(3 downto 0);
		enPC, enA, enB, enOut, enOp: OUT STD_LOGIC
		);
END bc;

ARCHITECTURE behave OF bc IS
	TYPE state_type IS (S0, S1, S2, S3, S4, S5, S6, S7, S8);
	SIGNAL state: state_type;
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, opcode)
	BEGIN
		IF rising_edge(clk) THEN
			CASE state IS
				WHEN S0 => state <= S1;
				
				WHEN S1 => state <= S2; 				  

				WHEN S2 => if (opcode = "0010" or opcode =  "0011" or opcode =  "0100") THEN
									state <= S3;
							  else 
									state <= S5;
							  end if;

				WHEN S3 => state <= S4;
			
				when s4 => state <= s0;
				
				when s5 => state <= s6;
				
				when s6 => state <= s7;
				
				when s7 => state <= s8;
				
				when s8 => state <= s0;
				
			END CASE;
		END IF;
	END PROCESS;
	
	-- Logica de saida
	PROCESS (state)
	BEGIN
		CASE state IS
			WHEN S0 =>
				enPC <= '0';
				enA <= '0';
				enB <= '0';
				enOp <= '0';
				enOut <= '1';
				
			WHEN S1 => 
				enPC <= '1';
				enA <= '0';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';
				
			WHEN S2 => 
				enPC <= '0';
				enA <= '0';
				enB <= '0';
				enOp <= '1';
				enOut <= '0';
				
			WHEN S3 =>
				enPC <= '1';
				enA <= '0';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';

			WHEN S4 =>
				enPC <= '0';
				enA <= '1';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';
				
			WHEN S5 =>
				enPC <= '1';
				enA <= '0';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';
			
			WHEN S6 =>
				enPC <= '0';
				enA <= '1';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';	
			
			WHEN S7 =>
				enPC <= '1';
				enA <= '0';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';	
				
			WHEN S8 =>
				enPC <= '0';
				enA <= '0';
				enB <= '1';
				enOp <= '0';
				enOut <= '0';
				
		END CASE;
	END PROCESS;
END behave;