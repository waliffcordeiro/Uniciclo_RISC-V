library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity banco_registradores is
	generic(N: integer := 5; M: integer := 32);
port (
	rs1, rs2, rs_display, rd: in std_logic_vector(4 downto 0);
	memwrite, clk : in std_logic;
	write_data : in std_logic_vector(31 downto 0);
	rout1, rout2, rout_display : out std_logic_vector(31 downto 0)
);
end entity banco_registradores;

architecture arch_banco_registradores of banco_registradores is

begin
	
	rout1 <= d_mem(to_integer(unsigned(rs1))) when (to_integer(unsigned(rs1))<((2**N)-1) and to_integer(unsigned(rs1))> 0 and memwrite='0') else (others => '0');
	rout2 <= d_mem(to_integer(unsigned(rs2))) when (to_integer(unsigned(rs2))<((2**N)-1) and to_integer(unsigned(rs2))> 0 and memwrite='0') else (others => '0');
	rout_display <= d_mem(to_integer(unsigned(rs_display))) when (to_integer(unsigned(rs_display))<((2**N)-1) and to_integer(unsigned(rs_display))> 0 and memwrite='0') else (others => '0');
	
	process(clk) begin
	
		if rising_edge(clk) then 
			
			if to_integer(unsigned(rd))<((2**N)-1) and memwrite='1' then 

					d_mem(to_integer(unsigned(rd))) <= write_data;
					
			end if;
			
		end if;
		
	end process;
	
end arch_banco_registradores;