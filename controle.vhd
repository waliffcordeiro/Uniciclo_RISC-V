library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controle is
	port(
		op					:	in std_logic_vector(6 downto 0);
		
		op_ula			:	out std_logic_vector(1 downto 0); -- 2 bits da OpUla
		
		branch,			--	Ligado caso haja uma instrucao de branch
		le_mem,			-- Permite a leitura da memoria
		mem_para_reg,	--	O valor que vem da memoria de dados para se escrita no registrador
		escreve_mem,	-- Permite a escrita na memoria
		orig_alu,		-- Se a segunda entrada na ula vira do imediato ou nao
		escreve_reg,	-- Permite escrever na memoria de registradores	
		jump,				-- Ligado caso seja instrucao de jump
		jal,				-- Ligado caso seja instrucao de link
		luictr			-- Ligado caso seja instrucao de lui
		:	out std_logic
	);
end controle;

architecture behavioral of controle is
	begin
	process	(op)
		begin
			case op is
				when	"0110011" =>	-- Tipo R
					branch			<= '0';
					le_mem			<= '0';
					mem_para_reg 	<= '0';
					escreve_mem		<= '0';
					orig_alu 		<= '0';
					escreve_reg		<= '1';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "10";
					
				when	"0010011" =>	-- Tipo I
					branch			<= '0';
					le_mem			<= '0';
					mem_para_reg 	<= '0';
					escreve_mem		<= '0';
					orig_alu 		<= '1';
					escreve_reg		<= '1';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "10";

				when	"0000011" =>	-- Tipo I - LW
					branch			<= '0';
					le_mem			<= '1';
					mem_para_reg 	<= '1';
					escreve_mem		<= '0';
					orig_alu 		<= '1';
					escreve_reg		<= '1';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "00";
					
				when	"1100111" => -- Tipo I - Jalr
					branch			<= '1';
					le_mem			<= '0';
					mem_para_reg 	<= '0';
					escreve_mem		<= '0';
					orig_alu 		<= '1';
					escreve_reg		<= '1';
					jump				<= '1';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "11";				
				
				when	"0100011" =>	-- Tipo S - SW
					branch			<= '0';
					le_mem			<= '0';
					mem_para_reg 	<= '0';
					escreve_mem		<= '1';
					orig_alu 		<= '1';
					escreve_reg		<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "00";
				
				when	"1100011" => -- Tipo B
					branch			<= '1';
					le_mem			<= '0';
					mem_para_reg 	<= '0';
					escreve_mem		<= '0';
					orig_alu 		<= '0';
					escreve_reg		<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "01";
				
				when	"1101111" => -- Tipo J - JAL
					branch			<= '1';
					le_mem			<= '0';
					mem_para_reg 	<= '0';
					escreve_mem		<= '0';
					orig_alu 		<= '0';
					escreve_reg		<= '1';
					jump				<= '0';
					jal				<= '1';
					luictr			<= '0';
					op_ula			<= "11";
				
				when	"0110111" => -- Tipo U - LUI
					branch			<= '1';
					le_mem			<= '0';
					mem_para_reg 	<= '0';
					escreve_mem		<= '0';
					orig_alu 		<= '1';
					escreve_reg		<= '1';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '1';
					op_ula			<= "11";
					
				when	"0010111" => -- Tipo U - AUIPC
					branch			<= '1';
					le_mem			<= '0';
					mem_para_reg 	<= '0';
					escreve_mem		<= '0';
					orig_alu 		<= '1';
					escreve_reg		<= '1';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "11";
					
				when others =>	
					branch			<= '0';
					le_mem			<= '0';
					mem_para_reg 	<= '0';
					escreve_mem		<= '0';
					orig_alu 		<= '0';
					escreve_reg		<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "00";
					
				end case;
	end process;
end behavioral;
