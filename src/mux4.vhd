library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
	generic(DATA_WIDTH : natural := 32);
	port(
		A, B, C, D : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		OP: in std_logic_vector(1 downto 0);
		F: out std_logic_vector(DATA_WIDTH - 1 downto 0)
	);
end entity mux4;

architecture arch_mux4 of mux4 is
begin
	with op select
	f <= std_logic_vector(A) when "00", 
		 std_logic_vector(B) when "01",
		 std_logic_vector(C) when "10",
		 std_logic_vector(D) when others;
		 
end arch_mux4;