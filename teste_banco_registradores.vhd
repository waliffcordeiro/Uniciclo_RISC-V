library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BR_test is
	generic (DATA_WIDTH : natural := 32);
end entity BR_test;

architecture arch_BR_test of BR_test is
component banco_registradores is
	generic(N: integer := 5; M: integer := 32);
	port (
		rs1, rs2, rs_display, rd: in std_logic_vector(4 downto 0);
		memwrite, clk : in std_logic;
		write_data : in std_logic_vector(31 downto 0);
		rout1, rout2, rout_display : out std_logic_vector(31 downto 0)
	);
end component;

		signal rs1, rs2, rs_display, rd: std_logic_vector(4 downto 0);
		signal memwrite, clk : std_logic;
		signal write_data : std_logic_vector(31 downto 0);
		signal rout1, rout2, rout_display : std_logic_vector(31 downto 0);

	begin
 
		test: banco_registradores port map (rs1, rs2, rs_display, rd, memwrite, clk, write_data, rout1, rout2, rout_display);

		process begin

			-- Escrita
			rs1 <= "00001";
			rs2 <= "00011";
			rs_display <= "00011";
			rd <= "00011";
			memwrite <= '1';
			clk <= '0';
			write_data <= x"00000009";
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
			if (unsigned(rout2)=9) then report "Sucesso - Rout2" severity note;
			else report "Erro - Rout2" severity error;
			end if;

			wait; -- wait forever
		end process;
end arch_BR_test;