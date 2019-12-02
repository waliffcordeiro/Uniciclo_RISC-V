library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.riscv_pkg.all;

entity controleULA is 
	port(
		op_in		:	in std_logic_vector(31 downto 0);
		op_ula	:	in std_logic_vector(1 downto 0);
		op_out	:	out std_logic_vector(3 downto 0)
	);
end controleULA;

architecture rtl of controleULA is
	signal auxi	:	std_logic_vector(3 downto 0);
	signal funct:  std_logic_vector(3 downto 0);

	begin
		op_out <= auxi;
		funct  <= op_in(30) & op_in(14 downto 12);
	proc_ctrl_ula:	process (funct, op_ula, auxi)

	begin
		if(op_in(6 downto 0) = "0110111") then -- lui
			auxi <= "1110"; 
		elsif(op_in(6 downto 0) = "0010011") then -- Tipo I
			case funct(2 downto 0) is
				when "000" => auxi <= "0000"; -- addi
				when "010" => auxi <= "1000"; -- slti
				when "011" => auxi <= "1001"; -- sltiu
				when "100" => auxi <= "0100"; -- xori
				when "110" => auxi <= "0011"; -- ori
				when "111" => auxi <= "0010"; -- andi
				when "001" => auxi <= "0101"; -- slli
				when others => 
				if(op_in(30) = '0') then  -- funct7
					auxi <= "0110"; -- srli
				else
					auxi <= "0111"; -- srai
				end if;
			end case;
		elsif(op_ula = "00") then -- LW e SW
			auxi <= "0000";
		elsif(op_ula = "01") then -- branch
			case funct(2 downto 0) is 
				when "000" =>  auxi <= "0001"; -- beq
				when "100" =>  auxi <= "1010"; -- blt
				when "001" =>  auxi <= "1100"; -- bne
				when "101" =>  auxi <= "1000"; -- bge
				when others => auxi <= "1111"; -- bltu, bgeu
			end case;
			
		elsif(op_ula = "11") then -- Jumps
			case op_in(6 downto 0) is
				when "1101111" => auxi <= "1111"; -- jal
				when "1100111" => auxi <= "1111"; -- jalr
				when others => auxi <= "1111";
			end case;
				
		else
			case funct is -- Tipo R
				when "0000"	=>	auxi	<= "0000"; -- ADD
				when "1000"	=>	auxi	<=	"0001"; -- SUB	
				when "0111"	=>	auxi	<=	"0010"; -- AND
				when "0110"	=> auxi  <= "0011"; -- OR
				when "0100"	=> auxi 	<= "0100"; -- XOR
				when "0001"	=> auxi 	<= "0101"; -- SLL
				when "0101"	=> auxi 	<= "0110"; -- SRL
				when "1101"	=> auxi	<= "0111"; -- SRA
				when "0010"	=>	auxi	<= "1000"; -- SLT
				when "0011"	=> auxi 	<= "1001"; -- SLTU
				when others => auxi  <= "1111";
			end case;
		end if;
	end process;
end rtl;
