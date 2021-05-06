LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (clk : IN STD_LOGIC;
		opcode: in std_logic_vector(3 downto 0);
		enPC, enA, enB, enOut, enOp, enMulti: OUT STD_LOGIC
		);
END bc;

ARCHITECTURE behave OF bc IS
	TYPE state_type IS (S0, S1, S2, S3, S4, S5, S6, s7, s8, s9, s10);
	SIGNAL state: state_type;
	signal pcaux : std_logic_vector (1 downto 0) := "00";
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, pcaux, opcode)
	BEGIN
		IF rising_edge(clk) THEN
			CASE state IS
				WHEN S0 => state <= S1;
				
				WHEN S1 => state <= S2; 				  

				WHEN S2 => if (pcaux = "00") THEN
									state <= S3;
							  elsif (pcaux(0) = '1') then
									state <= S6;
							  elsif (pcaux = "10") then
									state <= s8;
							  end if;

				WHEN S3 => state <= s4;
			
				when s4 => if (opcode = "0010" or opcode =  "0011" or opcode =  "0100") then
									state <= S5;
							  else 
									state <= s1;
							  end if;
							  
				when s5 => state <= s1;
				
				when s6 => state <= s7;
				
				when s7 => if (pcaux = "00") then
									state <= s0;
								else
									state <= s1;
								end if;
				
				when s8 => state <= s9;
				
				when s9 => if (opcode = "1000") then
									state <= s10;
								else
									state <= s0;
								end if;
								
				when s10 => state <= s0;
				
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
				enMulti <= '0';
				
			WHEN S1 => 
				enPC <= '1';
				enOut <= '0';
				
			WHEN S2 => 
				enPC <= '0';

			WHEN S3 =>
				enOp <= '1';
				pcaux <= "11";

			WHEN S4 =>
				enPC <= '0';
				
			when s5 => pcaux <= "01";		
				
			WHEN S6 =>
				enPC <= '0';
				enA <= '1';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';
				pcaux(0) <= '0';
			
			WHEN S7 =>
				enA <= '0';
			
			WHEN S8 =>
				enPC <= '0';
				enA <= '0';
				enB <= '1';
				enOp <= '0';
				enOut <= '0';	
				
			WHEN S9 =>
				enPC <= '0';
				enA <= '0';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';
				
			WHEN S10 => enMulti <= '1';
				
		END CASE;
	END PROCESS;
END behave;