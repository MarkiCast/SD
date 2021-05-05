LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (clk : IN STD_LOGIC;
		opcode: in std_logic_vector(3 downto 0);
		enPC, enA, enB, enOut, enOp, enMulti: OUT STD_LOGIC;
		
		--divisor
		Amenor, Pronto: in std_logic;
		RegM, RegN, RegAQ, Q0, Dlc, R: out std_logic;
		OP, mux_aq: out std_logic_vector(1 downto 0)
		
		);
END bc;

ARCHITECTURE behave OF bc IS
	TYPE state_type IS (S0, S1, S2, S3, S4, S5, S6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20);
	SIGNAL state: state_type;
	signal pcaux : std_logic_vector (1 downto 0) := "00";
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, pcaux, opcode, AMenor, Pronto)
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
								elsif (opcode = "1001") then
									state <= s11;
								else
									state <= s0;
								end if;
								
				when s10 => state <= s0;
				
				--divisor
				when S11 => state <= S12;
		
				when S12 => state <= S13;
			
				when S13 => state <= S14;
					
				when S14 => state <= s15;
		
				when s15 => if (AMenor = '1') then
									state <= S16;
								else
									state <= S17;
								end if;
			
				when S16 => state <= S18;
			
				when S17 => state <= S18;  --Estado do count
			
				when s19=> if (Pronto = '1') then
								state <= S20;
							else
								state <= s18;
							end if;
							
				when s18  => state  <= s13;
				
				when s20 => state <= s0;
				
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
				
				R <= '1';
				RegM <= '0';
				RegN <='0';
				RegAQ <= '0';
				Q0 <= '0';
				op <= "00";
				mux_aq <= "01";
				dlc <= '0';
				
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
				
			--divisor	
						
			when S11 => R <= '1';
						  RegM <= '0';
						  RegN <='0';
						  RegAQ <= '0';
						  Q0 <= '0';
						  op <= "00";
						  mux_aq <= "01";
						  dlc <= '0';
						 
								
			 when S12 => R <= '0';
						  RegM <= '1';
						  RegN <='0';
						  RegAQ <='1';
						  Q0 <= '0';
						  op <= "00";
						  mux_aq <= "01";
						  dlc <= '0';
						 
						  
								
			 when S13 =>  R <= '0';
						  RegM <= '0';
						  RegN <='0';
						  RegAQ <='0';
						  Q0 <= '0';
						  op <= "00";
						  mux_aq <= "10";
						  dlc <= '1';

				
			 when S14 =>R <= '0';
						  RegM <= '0';
						  RegN <='0';
						  RegAQ <='1';
						  Q0 <= '0';
						  op <= "01";
						  mux_aq <= "00";
						  dlc <= '0';

			when s15 =>  R <= '0';
								  RegM <= '0';
								  RegN <='0';
								  RegAQ <='0';
								  Q0 <= '0';
								  op <= "00";
								  mux_aq <= "10";
								  dlc <= '0';			
			 
			 when S16 =>  R <= '0'; --Estado que faz A+M  e Q0=0
						  RegM <= '0';
						  RegN <='0';
						  RegAQ <='1';
						  Q0 <= '0';
						  op <= "10";
						  mux_aq <= "00";
						  dlc <= '0';

			  
			 when S17 => R <= '0';
						  RegM <= '0';
						  RegN <='0';
						  RegAQ <='1';
						  Q0 <= '1';
						  op <= "10";
						  mux_aq <= "11";
						  dlc <= '0';
			
			when s18 =>  R <= '0';
						  RegM <= '0';
						  RegN <='1';
						  RegAQ <='0';
						  Q0 <= '0';
						  op <= "00";
						  mux_aq <= "01";
						  dlc <= '0';
			 
			 
			 when s19 => R <= '0';
						  RegM <= '0';
						  RegN <='0';
						  RegAQ <='0';
						  Q0 <= '0';
						  op <= "00";
						  mux_aq <= "01";
						  dlc <= '0';
																 
										  
			 when s20 =>  R <= '0';
								  RegM <= '0';
								  RegN <='0';
								  RegAQ <='0';
								  Q0 <= '0';
								  op <= "00";
								  mux_aq <= "10";
								  dlc <= '0';

		
						
				
		END CASE;
	END PROCESS;
END behave;