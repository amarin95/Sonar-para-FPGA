----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:59:26 09/17/2015 
-- Design Name: 
-- Module Name:    gestion_2_interrupciones - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_2_interrupciones is
    Port ( clk_micro : in  STD_LOGIC;
           interrupt_ack : in  STD_LOGIC;
           peticion_int_0 : in  STD_LOGIC;
           peticion_int_1 : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           interrupt : out  STD_LOGIC;
           origen_int : out  STD_LOGIC);
end gestion_2_interrupciones;

architecture Behavioral of gestion_2_interrupciones is
COMPONENT codificador_con_prioridad_2_a_1
	PORT(
		cod_in : IN std_logic_vector(1 downto 0);          
		cod_out : OUT std_logic
		);
	END COMPONENT;
COMPONENT d_flip_flop
	PORT(
		ce : IN std_logic;
		clk : IN std_logic;
		d : IN std_logic;
		reset : IN std_logic;          
		q : OUT std_logic
		);
	END COMPONENT;
COMPONENT decodificador_1_a_2
	PORT(
		dec_in : IN std_logic;
		en : IN std_logic;          
		out_0 : OUT std_logic;
		out_1 : OUT std_logic
		);
	END COMPONENT;
COMPONENT detector_flancos
	PORT(
		entrada : IN std_logic;
		clk : IN std_logic;
		reset : IN std_logic;          
		fa_entrada : OUT std_logic;
		fd_entrada : OUT std_logic;
		f_entrada : OUT std_logic;
		entrada_s : OUT std_logic
		);
	END COMPONENT;
COMPONENT or_2_bits
	PORT(
		a : IN std_logic;
		b : IN std_logic;          
		o : OUT std_logic
		);
	END COMPONENT;
COMPONENT rs_flip_flop
	PORT(
		clk : IN std_logic;
		r : IN std_logic;
		reset : IN std_logic;
		s : IN std_logic;          
		q : OUT std_logic
		);
	END COMPONENT;

signal fa_s_int: std_logic;
signal fa_hd1_s_int : std_logic;
signal out_1_r : std_logic;
signal out_0_r : std_logic;
signal cod_out_int : std_logic;
signal cod_in_int_0 : std_logic;
signal cod_in_int_1 : std_logic;
signal cod_in_int :std_logic_vector(1 downto 0);
begin

	Inst_rs_flip_flop: rs_flip_flop PORT MAP(
		clk => clk_micro,
		r => out_0_r,
		reset => reset,
		s => fa_s_int,
		q => cod_in_int_0
	);
	Inst_rs_flip_flop_HD2: rs_flip_flop PORT MAP(
		clk => clk_micro,
		r => out_1_r,
		reset => reset,
		s => fa_hd1_s_int,
		q => cod_in_int_1
	);
	Inst_or_2_bits: or_2_bits PORT MAP(
		a => cod_in_int_0,
		b => cod_in_int_1,
		o => interrupt
	);
	Inst_detector_flancos: detector_flancos PORT MAP(
		entrada => peticion_int_0,
		clk => clk_micro,
		reset => reset,
		fa_entrada => fa_s_int,
		fd_entrada =>open ,
		f_entrada => open,
		entrada_s => open 
	);
	Inst_detector_flancos_HD1: detector_flancos PORT MAP(
		entrada =>peticion_int_1 ,
		clk => clk_micro,
		reset => reset,
		fa_entrada => fa_hd1_s_int,
		fd_entrada =>open ,
		f_entrada => open,
		entrada_s =>open 
	);
	Inst_decodificador_1_a_2: decodificador_1_a_2 PORT MAP(
		dec_in =>cod_out_int ,
		en => interrupt_ack,
		out_0 => out_0_r,
		out_1 => out_1_r
	);
	Inst_d_flip_flop: d_flip_flop PORT MAP(
		ce => interrupt_ack,
		clk => clk_micro,
		d => cod_out_int,
		reset => reset,
		q => origen_int
	);
	
		cod_in_int<=cod_in_int_1 & cod_in_int_0;

	Inst_codificador_con_prioridad_2_a_1: codificador_con_prioridad_2_a_1 PORT MAP(
		cod_in => cod_in_int,
		cod_out => cod_out_int
	);

end Behavioral;

