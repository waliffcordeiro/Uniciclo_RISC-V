library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity genImm32 is
port (
	inst: in std_logic_vector(31 downto 0);
	imm32 : out signed(31 downto 0)
);
end entity genImm32;

architecture a of genImm32 is
-- Vetor com tamanho 20 com o MSB repetido
signal MSB_vector : std_logic_vector(19 downto 0);
signal aux : std_logic_vector(31 downto 0);
begin
	-- Atribuindo ao vetor o bit mais significativo 
	MSB_vector <= (others => inst(31));
	-- Vetor com caracteres do immediato
	aux <=	(31 downto 0 => '0') when unsigned(inst(6 downto 0))= x"33" else --tipo R
				MSB_vector & inst(31 downto 20) when unsigned(inst(6 downto 0))= x"03" or unsigned(inst(6 downto 0))= x"13" or unsigned(inst(6 downto 0))= x"67" else --tipo I
				MSB_vector & inst(31 downto 25) & inst(11 downto 7) when unsigned(inst(6 downto 0))= x"23" else -- tipo S
				MSB_vector & inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0' when unsigned(inst(6 downto 0))= x"63" else -- tipo B
				inst(31 downto 12) & "000000000000" when unsigned(inst(6 downto 0))= x"17" or unsigned(inst(6 downto 0))= x"37" else -- tipo U
				MSB_vector(11 downto 0) & inst(19 downto 12) & inst(20) & inst(30 downto 21) & '0' when unsigned(inst(6 downto 0))= x"6F" else -- tipo J
				inst; -- default
				
	-- Transforma o vetor em número com sinal
	imm32 <= signed(aux);		
end a;
