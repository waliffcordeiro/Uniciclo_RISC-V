library ieee;
use ieee.std_logic_1164.all;

entity Controle_ULA is 
	generic(DATA_WITDH: natural := 32);
	port(
		ULAop: in std_logic_vector(6 downto 0);	-- Vetor de 7 bits
		funct7: in std_logic_vector(6 downto 0);	-- Vetor de 7 bits
		funct3: in std_logic_vector(2 downto 0);	-- Vetor de 3 bits
		
		Op_out: out std_logic_vector(3 downto 0)	-- Vetor de 4 bits
	);
end entity Controle_ULA;

architecture Controle of Controle_ULA is			-- Gera o OP da ULA com base no opcode, funct3 e funct7
begin
	
	Op_out <= 	-- Tipo-R
					"0000" when ULAop = "0110011" and funct3 = "000" and funct7 = "0000000" else	-- add
					"0001" when ULAop = "0110011" and funct3 = "000" and funct7 = "0100000" else 	-- sub
					"0010" when ULAop = "0110011" and funct3 = "001" and funct7 = "0000000" else 	-- sll
					"0011" when ULAop = "0110011" and funct3 = "010" and funct7 = "0000000" else 	-- slt
					"0100" when ULAop = "0110011" and funct3 = "011" and funct7 = "0000000" else 	-- sltu
					"0101" when ULAop = "0110011" and funct3 = "100" and funct7 = "0000000" else 	-- xor
					"0110" when ULAop = "0110011" and funct3 = "101" and funct7 = "0000000" else 	-- srl
					"0111" when ULAop = "0110011" and funct3 = "101" and funct7 = "0100000" else 	-- sra
					"1000" when ULAop = "0110011" and funct3 = "110" and funct7 = "0000000" else 	-- or
					"1001" when ULAop = "0110011" and funct3 = "111" and funct7 = "0000000" else 	-- and
				
	
end Controle;