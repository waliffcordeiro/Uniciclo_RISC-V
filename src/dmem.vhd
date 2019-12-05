library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity dmem is
	  generic(N: integer := 7; M: integer := 32);
	port(
		clk				: in std_logic;
		address			: in std_logic_vector(N-1 downto 0);
        read_data		: out std_logic_vector(M-1 downto 0);
		memwrite		: in std_logic;
		write_data		: in std_logic_vector(M-1 downto 0);
        address_board	: in std_logic_vector(N-1 downto 0); --endereco de leitura para a placa (somente leitura)
        read_data_board	: out std_logic_vector(M-1 downto 0) --dado lido de acordo com o endereco definido por read_data_board
	);
end;     

architecture dmem_arch of dmem is
	
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

	read_data <= d_mem(to_integer(unsigned(address))) when (to_integer(unsigned(address))<((2**N)-1) and memwrite='0') else (others => '0');

	read_data_board <= d_mem(to_integer(unsigned(address_board))) when (to_integer(unsigned(address_board))<((2**N)-1) and memwrite='0') else (others => '0');
	
	process(clk) begin
	
		if rising_edge(clk) then 
			
			if to_integer(unsigned(address))<((2**N)-1) and memwrite='1' then 

					d_mem(to_integer(unsigned(address))) <= write_data;
					
			end if;
			
		end if;
		
	end process;
		
end;
