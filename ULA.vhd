library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ULA is
	generic (DATA_WIDTH : natural := 32);
	port (
		A, B : in std_logic_vector(DATA_WIDTH -1 downto 0);
		op : in std_logic_vector(3 downto 0);
		result : out std_logic_vector(DATA_WIDTH -1 downto 0);
		zero : out std_logic
	);
end entity ULA;

architecture ULA of ULA is

-- Vetor com DATA_WITDH - 1 zeros, com objetivo de deixar o result generico
signal data_width_zero : std_logic_vector(DATA_WIDTH-2 downto 0);

begin

  -- Preenche com zeros
  data_width_zero <= (others => '0');
	
	-- Calcula os resultados dependendo do opcode
	result 	<=	std_logic_vector(signed(A) + signed(B)) when op = "0000" else --ADD
				std_logic_vector(signed(A) - signed(B)) when op = "0001" else -- SUB
				std_logic_vector(unsigned(A) sll to_integer(unsigned(B))) when op = "0010" else -- SLL 
				data_width_zero & '1' when op = "0011" and (signed(A) < signed(B)) else  -- SLT
				data_width_zero & '1' when op = "0100" and (unsigned(A) < unsigned(B)) else  -- SLTU
				A xor B when op = "0101" else -- XOR
				std_logic_vector(unsigned(A) srl to_integer(unsigned(B))) when op = "0110" else -- SRL
				std_logic_vector(unsigned(A) sra to_integer(unsigned(B))) when op = "0111" else -- SRA
				A or B when op = "1000" else -- OR
				A and B when op = "1001" else -- AND
				data_width_zero & '1' when op = "1010" and (unsigned(A) = unsigned(B)) else -- SEQ
				data_width_zero & '1' when op = "1011" and (unsigned(A) /= unsigned(B)) else -- SNE
				data_width_zero & '1' when op = "1100" and (signed(A) >= signed(B)) else --SGE
				data_width_zero & '1' when op = "1101" and (unsigned(A) >= unsigned(B)) else -- SGEU

				data_width_zero & '0'; -- Caso default dos opcodes, e caso n�o satisfeito � condi��o de set

	zero <= '1' when signed(result) = 0 else '0';

end ULA;
