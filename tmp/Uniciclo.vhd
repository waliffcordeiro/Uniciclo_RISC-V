library ieee;
use ieee.std_logic_1164.all;

entity Uniciclo is 
end entity Uniciclo;

architecture arch_Uniciclo of Uniciclo is

-- Component 
component pc is
	port (
		addr_in : in std_logic_vector(31 downto 0);
		clk, rst : in std_logic;
		addr_out : out std_logic_vector(31 downto 0)
	);
end component;

component somador is
	generic (DATA_WIDTH : natural := 32);
	port (
		A, B : in std_logic_vector(DATA_WIDTH -1 downto 0);
		result : out std_logic_vector(DATA_WIDTH -1 downto 0);
	);
end component;

component banco_registradores is
	generic(N: integer := 5; M: integer := 32);
port (
	rs1, rs2, rs_display, rd: in std_logic_vector(4 downto 0);
	memwrite, clk : in std_logic;
	write_data : in std_logic_vector(31 downto 0);
	rout1, rout2, rout_display : out std_logic_vector(31 downto 0)
);
end component;

component controle is
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
end component;

component Controle_ULA is 
	generic(DATA_WITDH: natural := 32);
	port(
		ULAop: in std_logic_vector(6 downto 0);	-- Vetor de 7 bits
		funct7: in std_logic_vector(6 downto 0);	-- Vetor de 7 bits
		funct3: in std_logic_vector(2 downto 0);	-- Vetor de 3 bits
		Op_out: out std_logic_vector(3 downto 0)	-- Vetor de 4 bits
	);
end component;

component genImm32 is
port (
	inst: in std_logic_vector(31 downto 0);
	imm32 : out signed(31 downto 0)
);
end component;

component ULA is
	generic (DATA_WIDTH : natural := 32);
	port (
		A, B : in std_logic_vector(DATA_WIDTH -1 downto 0);
		op : in std_logic_vector(3 downto 0);
		result : out std_logic_vector(DATA_WIDTH -1 downto 0);
		zero : out std_logic
	);
end component;

component mux2 is
	generic(DATA_WIDTH : natural := 32);
	port(
		A, B : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		OP: in std_logic;
		F: out std_logic_vector(DATA_WIDTH - 1 downto 0)
	);
end component;
------------------------------------------------------------------------------
-- CLK
signal cl : std_logic;
-- Sinais ULA
signal rout1, rout2 : std_logic_vector(31 downto 0);
signal B : std_logic_vector(31 downto 0); -- Talvez Substituir por rout2 no port map mux_ula para otimizar
signal result_ULA : std_logic_vector(31 downto 0);
signal zero : std_logic;

-- Sinais
signal inst, imediato : std_logic_vector(31 downto 0);
signal rs_display: std_logic_vector(5 downto 0); -- Sinal externo vem da FPGA

-- Sinais do controle
signal op_ula : std_logic_vector(1 downto 0);
signal branch, le_mem, mem_para_reg, escreve_mem, orig_alu, escreve_reg, jump, jal,	luictr : std_logic;

begin
-- Gerar os imediatos
genimediato: genImm32 port map (inst(6 downto 0), imediato)
-- Gerar as flags do controle
controle : controle port map (inst(6 downto 0), op_ula, branch, le_mem, mem_para_reg, escreve_mem, orig_alu, escreve_reg, jump, jal, luictr);
-- Decodifica as instruções e coloca no banco de registradores
decoder: banco_registradores port map (inst(19 downto 15), inst(24 downto 20), rs_display, 
													inst(11 downto 7), escreve_reg, clk, write_data(saida do mux), rout1, rout2, rout_display(saida para fpga));
-- Multiplex saida da ULA
mux_ula: mux2 port map (rout2, imediato, orig_alu, B);

-- ULA
ula_map : ULA port map (rout1, rout2, ULAOP(saida do controle da ula), result_ULA, zero);


end arch_Uniciclo;
