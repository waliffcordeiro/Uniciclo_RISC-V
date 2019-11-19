library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_32bits is
	generic(DATA_WIDTH : natural := 32);
	port(
		A, B : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		OP: in std_logic;
		F: out std_logic_vector(DATA_WIDTH - 1 downto 0)
	);
end entity mux2to1_32bits;

architecture mux2to1_32bits of mux2to1_32bits is
begin
	with op select
	f <= std_logic_vector(a) when '0', 
		  std_logic_vector(b) when others;
		 
end mux2to1_32bits;