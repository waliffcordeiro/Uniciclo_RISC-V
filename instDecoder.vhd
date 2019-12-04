library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity instDecoder is
	generic (DATA_WIDTH : natural := 32);
	port (
		inst : in std_logic_vector(DATA_WIDTH -1 downto 0);
		rs1 : out std_logic_vector(4 downto 0);
		rs2 : out std_logic_vector(4 downto 0);
		rd : out std_logic_vector(4 downto 0);
		opcode : out std_logic_vector(6 downto 0);
		func3 : out std_logic_vector(2 downto 0);
		func7 : out std_logic_vector(6 downto 0)
	);
end entity instDecoder;

architecture instDecoder of instDecoder is

-- Vetor com DATA_WITDH - 1 zeros, com objetivo de deixar o result generico

begin
		rs1 <= inst(19 downto 15);
		rs2 <= inst(24 downto 20);
		rd <= inst(11 downto 7);
		opcode <= inst(6 downto 0);
		func3 <= inst(14 downto 12);
		func7 <= inst(31 downto 25);

 
end instDecoder; -- boa waliff
