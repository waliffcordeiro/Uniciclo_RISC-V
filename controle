library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity controle is
	port(
		op					:	in std_logic_vector(6 downto 0);
		
		op_ula			:	out std_logic_vector(3 downto 0); -- 4 bits da OpUla
		reg_dst,			-- Se o registrador de escrita rt ou rd
		orig_alu,		-- Se a segunda entrada na ula vira do imediato ou nao
		mem_para_reg,	--	O valor que vem da memoria de dados para se escrita no registrador
		escreve_reg,	-- Permite escrever na memoria de registradores
		le_mem,			-- Permite a leitura da memoria
		escreve_mem,	-- Permite a escrita na memoria
		branch,			--	Ligado caso haja uma instrucao de branch equal
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
					reg_dst 			<= '1';
					orig_alu 		<= '0';
					mem_para_reg 	<= '1';
					escreve_reg		<= '1';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "0010";
					
				when	"0010011" =>	-- Tipo I
					reg_dst 			<= '0';
					orig_alu 		<= '1';
					mem_para_reg 	<= '1';
					escreve_reg		<= '1';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "0010";
				 
				when	"0000011" =>	-- Tipo I - LW
					reg_dst 			<= '0';
					orig_alu 		<= '1';
					mem_para_reg 	<= '0';
					escreve_reg		<= '1';
					le_mem			<= '1';
					escreve_mem		<= '0';
					branch			<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "0010";
					
				when	"1100111" => -- Tipo I - Jump
					reg_dst 			<= '0';
					orig_alu 		<= '0';
					mem_para_reg 	<= '1';
					escreve_reg		<= '0';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					jump				<= '1';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "0010";
				
				when	"0100011" =>	-- Tipo S - SW
					reg_dst 			<= '1';
					orig_alu 		<= '1';
					mem_para_reg 	<= '0';
					escreve_reg		<= '1';
					le_mem			<= '0';
					escreve_mem		<= '1';
					branch			<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "0000";
				
				when	"1100011" => -- Tipo B
					reg_dst 			<= '0';
					orig_alu 		<= '0';
					mem_para_reg 	<= '1';
					escreve_reg		<= '0';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '1';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "0001";
				
				when	"1101111" => -- Tipo J - JAL
					reg_dst 			<= '0';
					orig_alu 		<= '0';
					mem_para_reg 	<= '1';
					escreve_reg		<= '1';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					jump				<= '1';
					jal				<= '1';
					luictr			<= '0';
					op_ula			<= "0000";
				
				when	"0110111" => -- Tipo U - LUI
					reg_dst 			<= '0';
					orig_alu 		<= '1';
					mem_para_reg 	<= '1';
					escreve_reg		<= '1';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '1';
					op_ula			<= "0111";
					
				when	"0010111" => -- Tipo U - AUIPC
					reg_dst 			<= '0';
					orig_alu 		<= '1';
					mem_para_reg 	<= '1';
					escreve_reg		<= '1';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "0111";
					
				when others =>	
					reg_dst 			<= '0';
					orig_alu 		<= '0';
					mem_para_reg 	<= '0';
					escreve_reg		<= '0';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					jump				<= '0';
					jal				<= '0';
					luictr			<= '0';
					op_ula			<= "0000";
				end case;
	end process;
end behavioral;
