LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (clk : IN STD_LOGIC;
		opcode: in std_logic_vector(3 downto 0);
		enPC, enA, enB, enOut, enOp: OUT STD_LOGIC;
		
		--Multi
		Amaior, Amenor, Aigual, Pronto: in std_logic;
		RegM, RegN, RegAQ, mux_count, dlc, r: out std_logic;
		OP, mux_aq: out std_logic_vector(1 downto 0)
		
		);
END bc;

ARCHITECTURE behave OF bc IS
	TYPE state_type IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, s13);
	SIGNAL state: state_type;
	signal pcaux : std_logic_vector (1 downto 0) := "00";
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, pcaux, opcode, AMaior, AMenor, AIgual, Pronto)
	BEGIN
		IF rising_edge(clk) THEN
			CASE state IS
				WHEN S0 => state <= S1;
				
				WHEN S1 => state <= S2; 				  

				WHEN S2 => if (pcaux = "00") THEN
									state <= S3;
							  elsif (pcaux(0) = '1') then
									state <= S5;
							  elsif (pcaux = "10") then
									state <= s6;
							  end if;

				WHEN S3 => state <= s4;
			
				when s4 => if (opcode = "0010" or opcode =  "0011" or opcode =  "0100") then
									state <= S13;
							  else 
									state <= s1;
							  end if;
				
				when s5 => if (pcaux = "00") then
									state <= s0;
								else
									state <= s1;
								end if;
				
				when s6 => if (opcode = "1000") then
									state <= s7;
								else
									state <= s0;
								end if;
				
				when S7 => state <= S8;
		
				when S8 => state <= S9;
				
				when S9 =>
				if (Pronto = '1') then
					state <= S0;
					else
						if (AMaior = '1') then
							state <= S11;
						elsif (AMenor = '1') then
							state <= S10;
						else
							state <= S12;
						end if;
				end if;
				
				when S10 => state <= S12;
				
				when S11 => state <= S12;
				
				when S12 => state <= S9;
				
				when s13 => state <= s1;
				
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
				enOp <= '0';
				enOut <= '0';
				
			WHEN S3 =>
				enPC <= '0';
				enA <= '0';
				enB <= '0';
				enOp <= '1';
				enOut <= '0';
				pcaux <= "11";

			WHEN S4 =>
				enPC <= '0';
				enA <= '0';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';
				
			WHEN S5 =>
				enPC <= '0';
				enA <= '1';
				enB <= '0';
				enOp <= '0';
				enOut <= '0';
				pcaux(0) <= '0';
			
			WHEN S6 =>
				enPC <= '0';
				enA <= '0';
				enB <= '1';
				enOp <= '0';
				enOut <= '0';	
				
			
			when S7 => RegM <= '0';
							RegAQ <= '0';
							Op <= "00";
							Dlc <= '0';
							RegN <= '0';
							R <= '1';
							mux_count <= '0';
							mux_AQ <= "01";
							
		 when S8 => RegM <= '1';
							RegAQ <= '1';
							Op <= "00";
							Dlc <= '0';
							RegN <= '1';
							R <= '0';
							mux_count <= '1';
							mux_AQ <= "01";
	
							
		 when S9 => RegM <= '0';    
							RegAQ <= '0';
							Op <= "00";
							Dlc <= '0';
							RegN <= '0';
							R <= '0';
							mux_count <= '0';
							mux_AQ <= "11";
	
	
							
		 when S10 => RegM <= '0';    
							RegAQ <= '1';
							Op <= "10";
							Dlc <= '0'; 
							RegN <= '0';
							R <= '0';
							mux_count <= '0';
							mux_AQ <= "00";
	
	
		 when S11 => RegM <= '0';    
							RegAQ <= '1';
							Op <= "01";
							Dlc <= '0'; 
							RegN <= '0';
							R <= '0';
							mux_count <= '0';
							mux_AQ <= "00";
	
		 when S12 => RegM <= '0';    
							RegAQ <= '0';
							Op <= "11";
							Dlc <= '1';
							RegN <= '1';
							R <= '0';
							mux_count <= '0';
							mux_AQ <= "00";

		when s13 => pcaux <= "01";	
						
				
		END CASE;
	END PROCESS;
END behave;