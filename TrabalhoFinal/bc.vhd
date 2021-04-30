LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (clk : IN STD_LOGIC;
		opcode: in std_logic_vector(3 downto 0);
		enPC, enA, enB, enOut, enOp: OUT STD_LOGIC
		);
END bc;

ARCHITECTURE behave OF bc IS
	
	TYPE state_type IS (S0, S1, S2, S3, S4, s5);
	SIGNAL state: state_type;
	signal PCaux : std_logic_vector(1 downto 0) := "00";
	
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, opcode, pcaux)
	BEGIN
		IF rising_edge(clk) THEN
			CASE state IS
				WHEN S0 => state <= S1;
				
				WHEN S1 => if (pcaux(0) = '1') then
									state <= s4;
								elsif (pcaux = "10") then
									state <= s5;
							  else
									state <= s2;
							  end if;

				WHEN S2 => if (opcode = "0010" or opcode = "0011" or opcode = "0100") then
									state <= s3;
							  else 
									state <= s1;
							  end if;

				when s3 => state <= s1;
				
				WHEN S4 => if (pcaux = "00") THEN
									state <= S0;
							  else
									state <= S1;
							  end if;
				
				WHEN S5 => state <= S0;
			
				
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
				pcaux <= "00";
				
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
				pcaux <= "11";
							
			WHEN S3 =>
				enPC <= '0';
				enA <= '0';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';
				pcaux <= "01";
				
			WHEN S4 =>
				enPC <= '0';
				enA <= '1';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';
				pcaux(0) <= '0';
			
			WHEN S5 =>
				enPC <= '0';
				enA <= '0';
				enB <= '1';
				enOp <= '0';
				enOut <= '0';
	
		END CASE;
	END PROCESS;
END behave;