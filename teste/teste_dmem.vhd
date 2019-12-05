library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture tb of tb is
	
	constant N : integer := 7;
	constant M : integer := 32;
	
	signal clk				: std_logic := '0';
	signal address			: std_logic_vector(31 downto 0) := (others => '0');
	signal read_data		: std_logic_vector(M-1 downto 0);
	signal memwrite			: std_logic := '0';
	signal write_data		: std_logic_vector(M-1 downto 0) := (others => '0');
	signal address_board	: std_logic_vector(N-1 downto 0) := (others => '0');
	signal read_data_board	: std_logic_vector(M-1 downto 0);
   
begin

	UUT : entity work.dmem
		generic map(N, M)
	port map ( 
		clk				=> clk,
	    address			=> address(8 downto 2),
	    read_data		=> read_data,
	    memwrite		=> memwrite,
	    write_data		=> write_data,
	    address_board	=> address_board,
	    read_data_board	=> read_data_board
	);
	
	clk <= not clk after 1 ns;
	
	process
		variable saidaULA : integer := 8192;
    begin
		--primeiro a memoria eh escrita com varios valores
		memwrite <= '1';
		for i in 0 to 127 loop
			address <= std_logic_vector(to_unsigned(saidaULA,32) - 8192);
			write_data <= std_logic_vector(to_unsigned(saidaULA,32));
			saidaULA := saidaULA + 4;
			wait for 2 ns;
		end loop;
		
		saidaULA := 8192;
		
		--depois os valores sao lidos
		memwrite <= '0';
		for i in 0 to 127 loop
			address <= std_logic_vector(to_unsigned(saidaULA,32) - 8192);
			saidaULA := saidaULA + 4;
			wait for 2 ns;
		end loop;
		
		wait;
		
	end process;
  

end tb;
