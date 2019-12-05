library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
	generic (DATA_WIDTH : natural := 32);
	port (
		A, B : in std_logic_vector(DATA_WIDTH -1 downto 0);
		result : out std_logic_vector(DATA_WIDTH -1 downto 0);
	);
end entity somador;

architecture arch_somador of somador is
  component ULA is
	  port (
		  A, B : in std_logic_vector(DATA_WIDTH -1 downto 0);
		  op : in std_logic_vector(3 downto 0);
		  result : out std_logic_vector(DATA_WIDTH -1 downto 0);
		  zero : out std_logic
	   );
   end component;

  signal zero : std_logic;
begin

A0: ULA port map (A, B, "0000", result, zero);  

end arch_somador;
