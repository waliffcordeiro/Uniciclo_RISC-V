library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genImm32_test is
end entity genImm32_test;

architecture arch_genImm32_test of genImm32_test is
	component genImm32
		port (
			inst: in std_logic_vector(31 downto 0);
			imm32 : out signed(31 downto 0)
		);
	end component;

	signal saida : signed(31 downto 0);
	signal entrada: std_logic_vector(31 downto 0);
	
begin

	test: genImm32 port map (entrada, saida);
	process begin
		
		entrada <= x"000002b3"; wait for 10 ns;
		if (saida=0) then report "Sucesso - Tipo R" severity note;
		else report "Erro - tipo R" severity error;
		end if;

		entrada <= x"01002283"; wait for 10 ns;
		if (saida=16 ) then report "Sucesso - Tipo I"	severity note;
		else report "Erro - tipo I" severity error;
		end if;

		entrada <= x"f9c00313"; wait for 10 ns;
		if (saida=-100) then report "Sucesso - Tipo I"	severity note;
		else report "Erro - tipo I" severity error;
		end if;

		entrada <= x"fff2c293"; wait for 10 ns;
		if (saida=-1) then report "Sucesso - Tipo I"	severity note;
		else report "Erro - tipo I" severity error;
		end if;
		
		entrada <= x"16200313"; wait for 10 ns;
		if (saida=354) then report "Sucesso - Tipo I"	severity note;
		else report "Erro - tipo I" severity error;
		end if;

		entrada <= x"01800067"; wait for 10 ns;
		if (saida=24) then report "Sucesso - Tipo I"	severity note;
		else report "Erro - tipo I" severity error;
		end if;

		entrada <= x"00002437"; wait for 10 ns;
		if (saida=x"2000") then report "Sucesso - Tipo U"	severity note;
		else report "Erro - tipo U" severity error;
		end if;

		entrada <= x"02542e23"; wait for 10 ns;
		if (saida=60) then report "Sucesso - Tipo S"	severity note;
		else report "Erro - tipo S" severity error;
		end if;

		entrada <= x"fe5290e3"; wait for 10 ns;
		if (saida=-32 ) then report "Sucesso - Tipo B"	severity note;
		else report "Erro - tipo B" severity error;
		end if;

		entrada <= x"00c000ef"; wait for 10 ns;
		if (saida=12) then report "Sucesso - Tipo J"	severity note;
		else report "Erro - tipo J" severity error;
		end if;

		wait; -- wait forever
	end process;
end arch_genImm32_test;
