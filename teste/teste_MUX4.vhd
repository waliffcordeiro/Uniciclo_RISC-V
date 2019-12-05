library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_test is
	generic (DATA_WIDTH : natural := 32);
end entity MUX_test;

architecture arch_MUX4_test of MUX_test is
	component MUX4 is
		port (
			A, B, C, D : in std_logic_vector(DATA_WIDTH - 1 downto 0);
			OP: in std_logic_vector(1 downto 0);
			F: out std_logic_vector(DATA_WIDTH - 1 downto 0)
			);
	end component;

	signal A, B, C, D : std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal OP : std_logic_vector(1 downto 0);
	signal F : std_logic_vector(DATA_WIDTH - 1 downto 0);

	begin
 
		test: MUX4 port map (A, B, C, D, OP, F);

		process begin

			-- Elem1
			A <= x"00000005";
			B <= x"00000002";
			C <= x"00000007";
			D <= x"00000009";
			op <= "00";
			wait for 10 ns;
			if (unsigned(F)=5) then report "Sucesso - Elem1" severity note;
			else report "Erro - Elem1" severity error;
			end if;

			-- Elem2
			A <= x"00000005";
			B <= x"00000002";
			C <= x"00000007";
			D <= x"00000009";
			op <= "01";
			wait for 10 ns;
			if (unsigned(F)=2) then report "Sucesso - Elem2" severity note;
			else report "Erro - Elem2" severity error;
			end if;

			-- Elem3
			A <= x"00000005";
			B <= x"00000002";
			C <= x"00000007";
			D <= x"00000009";
			op <= "10";
			wait for 10 ns;
			if (unsigned(F)=7) then report "Sucesso - Elem3" severity note;
			else report "Erro - Elem3" severity error;
			end if;

			-- Elem4
			A <= x"00000005";
			B <= x"00000002";
			C <= x"00000007";
			D <= x"00000009";
			op <= "11";
			wait for 10 ns;
			if (unsigned(F)=9) then report "Sucesso - Elem4" severity note;
			else report "Erro - Elem4" severity error;
			end if;

			wait; -- wait forever
		end process;
end arch_MUX4_test;