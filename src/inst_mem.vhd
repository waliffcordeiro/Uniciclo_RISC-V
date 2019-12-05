library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity inst_mem is
	  generic(N: integer := 7; M: integer := 32);
	port(
		address			: in std_logic_vector(N-1 downto 0);
		inst				: out std_logic_vector(M-1 downto 0);
		inst_board		: out std_logic_vector(M-1 downto 0)
	);
end;     

architecture arch_inst_mem of inst_mem is
	
	type dmem_array is array(0 to ((2**N)-1)) of STD_LOGIC_VECTOR(M-1 downto 0);
	signal d_mem: dmem_array := (
										x"abababab",
										x"efefefef",
										x"02146545",
										x"85781546",
										x"69782314",
										x"25459789",
										x"245a65c5",
										x"ac5b4b5b",
										x"ebebebeb",
										x"cacacaca",
										x"ecececec",
										x"facfcafc",
										x"ecaecaaa",
										x"dadadeac",
										others => (others => '1')
									 );
begin

	inst <= d_mem(to_integer(unsigned(address))) when (to_integer(unsigned(address))<((2**N)-1)) else (others => '0');

	inst_board <= d_mem(to_integer(unsigned(address))) when (to_integer(unsigned(address))<((2**N)-1)) else (others => '0');
	
end;
