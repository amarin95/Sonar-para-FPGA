----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:36:12 09/17/2015 
-- Design Name: 
-- Module Name:    seleccion_binaria_8_perifericos_salida_con_registro - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seleccion_binaria_8_perifericos_salida_con_registro is
    Port ( out_port : in  STD_LOGIC_VECTOR (7 downto 0);
           port_id : in  STD_LOGIC_VECTOR (7 downto 0);
           clk_micro : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           write_strobe : in  STD_LOGIC;
           out_port_reg : out  STD_LOGIC_VECTOR (7 downto 0);
           sel_puerto_0_out : out  STD_LOGIC;
           sel_puerto_1_out : out  STD_LOGIC;
           sel_puerto_2_out : out  STD_LOGIC;
           sel_puerto_3_out : out  STD_LOGIC;
           sel_puerto_4_out : out  STD_LOGIC;
           sel_puerto_5_out : out  STD_LOGIC;
           sel_puerto_6_out : out  STD_LOGIC;
           sel_puerto_7_out : out  STD_LOGIC);
end seleccion_binaria_8_perifericos_salida_con_registro;

architecture Behavioral of seleccion_binaria_8_perifericos_salida_con_registro is
COMPONENT register_8_bits
	PORT(
		d : IN std_logic_vector(7 downto 0);
		ce : IN std_logic;
		clk : IN std_logic;
		reset : IN std_logic;          
		q : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

COMPONENT decodificador_1_entre_8_con_buses
	PORT(
		sel : IN std_logic_vector(2 downto 0);
		enable : IN std_logic;          
		q : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	signal port_id_int : std_logic_vector(2 downto 0); 
	signal q_int : std_logic_vector(7 downto 0);
	signal l1 : std_logic_vector(7 downto 0);
begin
	
	port_id_int<=port_id(2)&port_id(1)&port_id(0);
	
	Inst_decodificador_1_entre_8_con_buses: decodificador_1_entre_8_con_buses PORT MAP(
		sel => port_id_int,
		enable => '1',
		q => q_int
	);
	Inst_register_8_bits_selout: register_8_bits PORT MAP(
		d => q_int,
		ce =>'1',
		clk => clk_micro,
		reset => reset,
		q => l1
	);
	
	Inst_register_8_bits_out_port: register_8_bits PORT MAP(
		d => out_port,
		ce => '1',
		clk => clk_micro,
		reset => reset,
		q => out_port_reg
	);
	
	sel_puerto_7_out <= (write_strobe and l1(7));
	sel_puerto_6_out <= (write_strobe and l1(6));
	sel_puerto_5_out <= (write_strobe and l1(5));
	sel_puerto_4_out <= (write_strobe and l1(4));
	sel_puerto_3_out <= (write_strobe and l1(3));
	sel_puerto_2_out <= (write_strobe and l1(2));
	sel_puerto_1_out <= (write_strobe and l1(1));
	sel_puerto_0_out <= (write_strobe and l1(0));
end Behavioral;

