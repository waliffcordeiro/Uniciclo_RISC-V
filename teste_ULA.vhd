library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_test is
	generic (DATA_WIDTH : natural := 32);
end entity ULA_test;

architecture arch_ULA_test of ULA_test is
	component ULA is
		port (
			A, B : in std_logic_vector(DATA_WIDTH -1 downto 0);
			op : in std_logic_vector(3 downto 0);
			result : out std_logic_vector(DATA_WIDTH -1 downto 0)
		);
	end component;

	signal A, B, result : std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal op : std_logic_vector(3 downto 0);
	
begin

	test: ULA port map (A, B, op, result);
	
	process begin
		-- Add
		A <= x"00000005";
		B <= x"00000002";
		op <= "0000";
		wait for 10 ns;
		if (unsigned(result)=7 and zero = '0') then report "Sucesso - Soma" severity note;
		else report "Erro - Soma" severity error;
		end if;

		-- Sub
		A <= x"00000005";
		B <= x"00000002";
		op <= "0001";
		wait for 10 ns;
		if (unsigned(result)=3 and zero = '0') then report "Sucesso - Subtracao" severity note;
		else report "Erro - Subtracao" severity error;
		end if;

		-- SLL
		A <= x"00000004";
		B <= x"00000001";
		op <= "0010";
		wait for 10 ns;
		if (unsigned(result)=8 and zero = '0') then report "Sucesso - SLL" severity note;
		else report "Erro - SLL" severity error;
		end if;

		-- SLT A > B
		A <= x"00000000";
		B <= x"FFFFFFFF";
		op <= "0011";
		wait for 10 ns;
		if (unsigned(result)=0 and zero = '1') then report "Sucesso - SLT A > B" severity note;
		else report "Erro - SLT A > B" severity error;
		end if;

		-- SLT A < B
		A <= x"FFFFFFFF";
		B <= x"00000000";
		op <= "0011";
		wait for 10 ns;
		if (unsigned(result)=1 and zero = '0') then report "Sucesso - SLT A < B" severity note;
		else report "Erro - SLT A < B" severity error;
		end if;

		-- SLTU A > B
		A <= x"FFFFFFFF";
		B <= x"00000000";
		op <= "0100";
		wait for 10 ns;
		if (unsigned(result)=0 and zero = '1') then report "Sucesso - SLTU A > B" severity note;
		else report "Erro - SLT A > B" severity error;
		end if;

		-- SLTU A < B
		A <= x"00000000";
		B <= x"FFFFFFFF";
		op <= "0100";
		wait for 10 ns;
		if (unsigned(result)=1 and zero = '0') then report "Sucesso - SLTU A < B" severity note;
		else report "Erro - SLT A < B" severity error;
		end if;

		-- XOR
		A <= x"00000000";
		B <= x"F0F0F0F0";
		op <= "0101";
		wait for 10 ns;
		if (result=x"F0F0F0F0" and zero = '0') then report "Sucesso - Xor" severity note;
		else report "Erro - Xor" severity error;
		end if;
		
		-- SRL
		A <= x"00000004";
		B <= x"00000001";
		op <= "0110";
		wait for 10 ns;
		if (unsigned(result)=2 and zero = '0') then report "Sucesso - SRL" severity note;
		else report "Erro - SRL" severity error;
		end if;

		-- SRA
		A <= x"00000008";
		B <= x"00000002";
		op <= "0111";
		wait for 10 ns;
		if (unsigned(result)=2 and zero = '0') then report "Sucesso - SRA" severity note;
		else report "Erro - SRA" severity error;
		end if;

		-- OR
		A <= x"00000000";
		B <= x"F0F0F0F0";
		op <= "1000";
		wait for 10 ns;
		if (result=x"F0F0F0F0" and zero = '0') then report "Sucesso - OR" severity note;
		else report "Erro - OR" severity error;
		end if;

		-- AND
		A <= x"00000000";
		B <= x"F0F0F0F0";
		op <= "1001";
		wait for 10 ns;
		if (result=x"00000000" and zero = '1') then report "Sucesso - AND" severity note;
		else report "Erro - AND" severity error;
		end if;

		-- SEQ A == B
		A <= x"000F0000";
		B <= x"000F0000";
		op <= "1010";
		wait for 10 ns;
		if (unsigned(result)=1 and zero = '0') then report "Sucesso - SEQ A == B" severity note;
		else report "Erro - SEQ A == B" severity error;
		end if;

		-- SEQ A != B
		A <= x"000F000F";
		B <= x"000F0000";
		op <= "1010";
		wait for 10 ns;
		if (unsigned(result)=0 and zero = '1') then report "Sucesso - SEQ A != B" severity note;
		else report "Erro - SEQ A != B" severity error;
		end if;


		-- SNE A != B
		A <= x"000F000F";
		B <= x"000F0000";
		op <= "1011";
		wait for 10 ns;
		if (unsigned(result)=1 and zero = '0') then report "Sucesso - SNE A != B" severity note;
		else report "Erro - SNE A != B" severity error;
		end if;


		-- SNE A == B
		A <= x"000F000F";
		B <= x"000F000F";
		op <= "1011";
		wait for 10 ns;
		if (unsigned(result)=0 and zero = '1') then report "Sucesso - SNE A == B" severity note;
		else report "Erro - SNE A == B" severity error;
		end if;

		-- SGE  A >= B (Signed)
		A <= x"00000000";
		B <= x"FFFFFFFF";
		op <= "1100";
		wait for 10 ns;
		if (unsigned(result)=1 and zero = '0') then report "Sucesso - SGE A >= B" severity note;
		else report "Erro - SGE A >= B" severity error;
		end if;

		-- SGE  A < B (Signed)
		A <= x"FFFFFFFF";
		B <= x"00000000";
		op <= "1100";
		wait for 10 ns;
		if (unsigned(result)=0 and zero = '1') then report "Sucesso - SGE A < B" severity note;
		else report "Erro - SGE A < B" severity error;
		end if;

		-- SGEU  A >= B (unigned)
		A <= x"FFFFFFFF";
		B <= x"00000000";
		op <= "1101";
		wait for 10 ns;
		if (unsigned(result)=1 and zero = '0') then report "Sucesso - SGEU A >= B" severity note;
		else report "Erro - SGEU A >= B" severity error;
		end if;

		-- SGEU  A < B (unsigned)
		A <= x"00000000";
		B <= x"FFFFFFFF";
		op <= "1101";
		wait for 10 ns;
		if (unsigned(result)=0 and zero = '1') then report "Sucesso - SGEU A < B" severity note;
		else report "Erro - SGEU A < B" severity error;
		end if;

		wait; -- wait forever
	end process;
end arch_ULA_test;
