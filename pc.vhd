library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
port (
	addr_in : in std_logic_vector(31 downto 0);
	clk, rst : in std_logic;
	addr_out : out std_logic_vector(31 downto 0)
);
end entity pc;

architecture arch_pc of pc is
begin
	process(clk, rst) begin
		if rst = '1' then
			addr_out <= x"00000000";
		elsif rising_edge(clk) then 
			addr_out <= addr_in;
		end if;
	end process;
end arch_pc
