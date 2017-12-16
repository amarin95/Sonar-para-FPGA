------------------------------------------------------------------
-- top_template_picoblaze_3_placa_Nexys_2 -- Main file
-- Design for Nexys 2 board for Picoblaze
-- Without STARTUP component and without reset signal in the frequency_divider component
-- Both things will make the Picoblaze malfunction
------------------------------------------------------------------
-- Luis Jacobo Alvarez Ruiz de Ojeda
-- Dpto. Tecnologia Electronica
-- University of Vigo
-- 27, September, 2014 
-- Tool versions: ISE 14
-- Description: 
	-- Plantilla para la conexión del microprocesador Picoblaze con 8 periféricos de entrada,
	-- 8 periféricos de salida y 1 fuente de interrupción en la placa Nexys 2.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_template_picoblaze_3_placa_Nexys_2 is
    Port (
	 -- INPUTS
	 clk : 	in std_logic; -- Clock signal (50 MHz)
	 AN: in std_logic;
	 TX : in std_logic;
	 RX : out std_logic;
	 SW: in std_logic_vector (7 downto 0);	-- Switches
	 BTN: in std_logic_vector (3 downto 0); -- Pushbuttons
	PWD: in std_logic; --periferico
	-- OUTPUTS
	 LEDs: out std_logic_vector (7 downto 0); -- LEDs
	 an0, an1, an2, an3: out std_logic; -- Anodes for the dynamic 4-digit 7-segment display
	 A,B,C,D,E,F,G,DP: out std_logic -- Cathodes for the dynamic 4-digit 7-segment display
	  );
end top_template_picoblaze_3_placa_Nexys_2;

architecture Behavioral of top_template_picoblaze_3_placa_Nexys_2 is

-- Declaración del divisor de reloj
	COMPONENT frequency_divider
	PORT(
		clk50MHz : IN std_logic;
		reset : IN std_logic;          
		clk2MHz : OUT std_logic;
		clk1MHz : OUT std_logic;
		clk1kHz : OUT std_logic
		);
	END COMPONENT;
	-- Declaracion biestable 8 bits
COMPONENT flipflop_8bits
	PORT(
		ce : IN std_logic;
		clk : IN std_logic;
		d : IN std_logic_vector(7 downto 0);
		reset : IN std_logic;          
		q : OUT std_logic_vector(7 downto 0)
		);
		END COMPONENT;
		-- Declaracion del conversor 
		
	COMPONENT conversor_binario_a_letra
	PORT(
		digito : IN std_logic_vector(7 downto 0);          
		letra : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

-- Declaración del circuito de control del visualizador dinámico
	COMPONENT control_visualizador_dinamico_Nexys_2_8_segmentos
	PORT(
		reset : IN std_logic;
		vis3_D : IN std_logic_vector(7 downto 0);
		vis2_D : IN std_logic_vector(7 downto 0);
		vis1_D : IN std_logic_vector(7 downto 0);
		vis0_D : IN std_logic_vector(7 downto 0);
		gctr : IN std_logic;
		clk1kHz : IN std_logic;
		gvis : IN std_logic;
		gvis3 : IN std_logic;
		gvis2 : IN std_logic;
		gvis1 : IN std_logic;
		gvis0 : IN std_logic;          
		an3 : OUT std_logic;
		an2 : OUT std_logic;
		an1 : OUT std_logic;
		an0 : OUT std_logic;
		A : OUT std_logic;
		B : OUT std_logic;
		C : OUT std_logic;
		D : OUT std_logic;
		E : OUT std_logic;
		F : OUT std_logic;
		G : OUT std_logic;
		DP : OUT std_logic
		);
	END COMPONENT;

-- Declaración del componente Picoblaze 3 empotrado
	COMPONENT picoblaze3_empotrado
	PORT(
		in_port : IN std_logic_vector(7 downto 0);
		interrupt : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		port_id : OUT std_logic_vector(7 downto 0);
		write_strobe : OUT std_logic;
		out_port : OUT std_logic_vector(7 downto 0);
		read_strobe : OUT std_logic;
		interrupt_ack : OUT std_logic
		);
	END COMPONENT;

-- Declaración del componente de selección binaria de 8 periféricos de entrada con registro
	COMPONENT seleccion_binaria_8_perifericos_entrada_con_registro
	PORT(
		port_id : IN std_logic_vector(7 downto 0);
		puerto_00_in : IN std_logic_vector(7 downto 0);
		puerto_01_in : IN std_logic_vector(7 downto 0);
		puerto_02_in : IN std_logic_vector(7 downto 0);
		puerto_03_in : IN std_logic_vector(7 downto 0);
		puerto_04_in : IN std_logic_vector(7 downto 0);
		puerto_05_in : IN std_logic_vector(7 downto 0);
		puerto_06_in : IN std_logic_vector(7 downto 0);
		puerto_07_in : IN std_logic_vector(7 downto 0);
		clk_micro : IN std_logic;
		reset : IN std_logic;          
		in_port : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;


-- Declaración del componente de selección binaria de 8 periféricos de salida con registro
COMPONENT seleccion_binaria_8_perifericos_salida_con_registro
	PORT(
		out_port : IN std_logic_vector(7 downto 0);
		port_id : IN std_logic_vector(7 downto 0);
		clk_micro : IN std_logic;
		reset : IN std_logic;
		write_strobe : IN std_logic;          
		out_port_reg : OUT std_logic_vector(7 downto 0);
		sel_puerto_0_out : OUT std_logic;
		sel_puerto_1_out : OUT std_logic;
		sel_puerto_2_out : OUT std_logic;
		sel_puerto_3_out : OUT std_logic;
		sel_puerto_4_out : OUT std_logic;
		sel_puerto_5_out : OUT std_logic;
		sel_puerto_6_out : OUT std_logic;
		sel_puerto_7_out : OUT std_logic
		);
	END COMPONENT;

-- Declaración del componente de gestión de una interrupción de un pulsador

	COMPONENT gestion_2_interrupciones
	PORT(
		clk_micro : IN std_logic;
		interrupt_ack : IN std_logic;
		peticion_int_0 : IN std_logic;
		peticion_int_1 : IN std_logic;
		reset : IN std_logic;          
		interrupt : OUT std_logic;
		origen_int : OUT std_logic
		);
	END COMPONENT;
	
-- Declaración del componente registro de 8 bits
COMPONENT register_8_bits
	PORT(
		ce : IN std_logic;
		clk : IN std_logic;
		d : IN std_logic_vector(7 downto 0);
		reset : IN std_logic;          
		q : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;


-- Declaración de señales internas

-- Picoblaze
	signal in_port_gestor_perif_in : std_logic_vector(7 downto 0) := x"00";
	signal interrupt_aux : std_logic := '0';
	signal port_id : std_logic_vector(7 downto 0) := x"00";
	signal write_strobe_gestor_perif_out : std_logic := '0';
	signal out_port_gestor_perif_out : std_logic_vector(7 downto 0) := x"00";
	signal interrupt_ack_gestor_pulsador : std_logic;
	signal interrupt_aux_gestor_perif_in : std_logic_vector(7 downto 0);
	signal read_strobe : std_logic :='0';
-- frequency divider	
	signal clk1kHz : 	std_logic := '0';							

-- Periféricos de entrada
signal PWD_aux:  std_logic_vector(7 downto 0);
signal PWD_out: std_logic_vector(7 downto 0);
signal BTN_AUX: std_logic_vector(7 downto 0):= x"00";
 signal btn_0_out: std_logic_vector(7 downto 0);
 signal ar_btn_aux : std_logic_vector(7 downto 0);

-- Periféricos de salida
signal out_port_reg_aux : std_logic_vector(7 downto 0);
	signal a_reg_dig0: std_logic;
	signal a_reg_dig1: std_logic;
	signal a_reg_dig2: std_logic;
	signal a_reg_dig3: std_logic;
	signal a_reg_LEDs: std_logic;
	signal a_vis_0_d: std_logic_vector(7 downto 0);
	signal a_vis_1_d: std_logic_vector(7 downto 0);
	signal a_vis_2_d: std_logic_vector(7 downto 0);
	signal a_vis_3_d: std_logic_vector(7 downto 0);
	signal a_conv_0: std_logic_vector(7 downto 0);
	signal a_conv_1: std_logic_vector(7 downto 0);
	signal a_conv_2: std_logic_vector(7 downto 0);


	signal interrupt_ack_aux: std_logic;

-- Interrupciones
-- INCLUIR

-- Componentes placa Nexys 2
-- INCLUIR

-- Otras
	signal reset: std_logic := '0';
	signal ar_btn: std_logic_vector (7 downto 0);
begin
RX <= '1';
PWD_aux <= "0000000" & PWD;
-- Componentes de la placa Nexys 2

-- El pulsador BTN3 es el reset global
reset <= BTN(3);

-- Instanciación del divisor de reloj
	Inst_frequency_divider: frequency_divider PORT MAP(
		clk50MHz => clk,
		reset => '0',
		clk2MHz => open,
		clk1MHz => open,
		clk1kHz => clk1kHz
	);

-- Instanciación del circuito de control del visualizador dinámico
-- CONECTAR LAS ENTRADAS vis3_D, vis2_D, vis1_D y vis0_D a los periféricos de salida
-- correspondientes a los dígitos del visualizador

-- Las señales gctr (habilitación del contador de refresco del visualizador),
-- gvis (habilitación global del visualizador de 7 segmentos) y
-- gvis3, gvis2, gvis1 y gvis0 (habilitación de cada dígito del visualizador de 7 segmentos)
-- deben estar a 1 para que el visualizador dinámico funcione

	Inst_control_visualizador_dinamico_Nexys_2_8_segmentos: control_visualizador_dinamico_Nexys_2_8_segmentos PORT MAP(
		reset => reset,
		vis3_D => a_vis_3_d,
		vis2_D => a_vis_2_d,
		vis1_D => a_vis_1_d,
		vis0_D => a_vis_0_d,
		gctr => '1',
		clk1kHz => clk1kHz,
		gvis => '1',
		gvis3 => '1',
		gvis2 => '1',
		gvis1 => '1',
		gvis0 => '1',
		an3 => an3,
		an2 => an2,
		an1 => an1,
		an0 => an0,
		A => A,
		B => B,
		C => C,
		D => D,
		E => E,
		F => F,
		G => G,
		DP => DP
	);


-- Instanciación del componente Picoblaze 3 empotrado
	Inst_picoblaze3_empotrado: picoblaze3_empotrado PORT MAP(
		clk => clk,				--
		reset => reset,			--
		in_port => in_port_gestor_perif_in,			--
		interrupt => interrupt_aux,   --
		port_id => port_id,					--
		write_strobe => write_strobe_gestor_perif_out,   --
		out_port => out_port_gestor_perif_out,			--
		read_strobe => read_strobe,  --
		interrupt_ack => interrupt_ack_gestor_pulsador    --
		
	);


-- Instanciación del componente de selección binaria de 8 periféricos de entrada con registro
interrupt_aux_gestor_perif_in <= "0000000" & interrupt_aux;
Inst_seleccion_binaria_8_perifericos_entrada_con_registro: seleccion_binaria_8_perifericos_entrada_con_registro PORT MAP(
		port_id => port_id,			--
		puerto_00_in => interrupt_aux_gestor_perif_in,		--
		puerto_01_in => "00000000",			--
		puerto_02_in => "00000000",			--
		puerto_03_in => "00000000",			--
		puerto_04_in => "00000000",			--
		puerto_05_in => "00000000",			--	
		puerto_06_in => PWD_out,			-- señal del periferico.
		puerto_07_in => "00000000",			--
		clk_micro => clk,  		--
		reset => reset,				--
		in_port => in_port_gestor_perif_in	);   --salida  

-- Instanciación del componente de selección binaria de 8 periféricos de salida con registro
Inst_seleccion_binaria_8_perifericos_salida_con_registro: seleccion_binaria_8_perifericos_salida_con_registro PORT MAP(
		out_port => out_port_gestor_perif_out,    --
		port_id => port_id,    --
		clk_micro => clk,				--
		reset => reset,      --
		write_strobe => write_strobe_gestor_perif_out,   --
		out_port_reg => out_port_reg_aux,			--
		sel_puerto_0_out => a_reg_LEDs,			--
		sel_puerto_1_out => a_reg_dig0,		--digito0 a conversor
		sel_puerto_2_out => a_reg_dig1,		--digito1 a conversor
		sel_puerto_3_out => a_reg_dig2,		--digito 2 a conversor
		sel_puerto_4_out => a_reg_dig3,		-- ESTE NO VA A CONVERSOR,LETRA d siempre
		sel_puerto_5_out => open,
		sel_puerto_6_out => open,
		sel_puerto_7_out => open
	);
-- ************************
-- Periféricos de entrada
-- ************************
-- INCLUIR LOS QUE SE USEN
-- Circuito antirrebotes para los pulsadores BTN2, BTN1 y BTN0
	BTN_AUX <= "0000000"& BTN(0);
Inst_d_flip_flop_2: flipflop_8bits PORT MAP(
		ce => '1',			-- señal innecesaria
		clk => clk1kHz,		--
		d => BTN_AUX,			--
		reset => reset,			--
		q => ar_btn_aux				-- se coje solo el ar_btn(0)
	);

-- Periférico 0 de entrada. Identificación de la interrupción
Inst_register_8_bits_btn0: register_8_bits PORT MAP(
		ce => '1',
		clk => clk,
		d => ar_btn_aux,
		reset => reset,
		q => ar_btn
	);


-- Periférico 1 de entrada. PWD

	Inst_register_8_bits_PWD: register_8_bits PORT MAP(
		d => PWD_aux,
		ce => '1',
		clk => clk,
		reset => reset,
		q => PWD_out
	);







-- ************************
-- Periféricos de salida
-- ************************
-- INCLUIR LOS QUE SE USEN

-- Periférico 0 de salida. Registro de LEDs
-- Instanciación del componente registro de 8 bits
Inst_register_8_bits_LEDs: register_8_bits PORT MAP(
		ce => a_reg_LEDs,
		clk => clk,
		d => out_port_reg_aux,
		reset => reset,
		q => LEDs
	);


-- Periférico 1 de salida. Dígito 0 visualizador de 7 segmentos
Inst_register_8_bits_dig0: register_8_bits PORT MAP(
		ce => a_reg_dig0,
		clk => clk,
		d => out_port_reg_aux,
		reset => reset,
		q => a_conv_0
	);



-- Periférico 2 de salida. Dígito 1 visualizador de 7 segmentos
Inst_register_8_bits_dig1: register_8_bits PORT MAP(
		ce => a_reg_dig1,
		clk => clk,
		d => out_port_reg_aux,
		reset => reset,
		q => a_conv_1
	);



-- Periférico 3 de salida. Dígito 2 visualizador de 7 segmentos
-- Instanciación del componente registro de 8 bits
Inst_register_8_bits_dig2: register_8_bits PORT MAP(
		ce => a_reg_dig2,
		clk => clk,
		d => out_port_reg_aux,
		reset => reset,
		q => a_conv_2
	);


-- Periférico 4 de salida. Dígito 3 visualizador de 7 segmentos
Inst_register_8_bits_dig3: register_8_bits PORT MAP(
		ce => a_reg_dig3,
		clk => clk,
		d => out_port_reg_aux,
		reset => reset,
		q => a_vis_3_d
	);

--Conversor digito 0 a la letra correspondiente
Inst_conversor_binario_a_letra_0: conversor_binario_a_letra PORT MAP(
		digito => a_conv_0,
		letra => a_vis_0_d
	);
--Conversor digito 1 a la letra correspondiente
Inst_conversor_binario_a_letra_1: conversor_binario_a_letra PORT MAP(
		digito => a_conv_1,
		letra => a_vis_1_d
	);
--Conversor digito 2 a la letra correspondiente
Inst_conversor_binario_a_letra_2: conversor_binario_a_letra PORT MAP(
		digito => a_conv_2,
		letra => a_vis_2_d
	);


-- ***************
-- Interrupciones
-- ***************

-- Instanciación del componente de gestión de una interrupción de un pulsador

-- Instanciación del componente de gestión de una interrupción de un pulsador
	Inst_gestion_2_interrupciones: gestion_2_interrupciones PORT MAP(
		clk_micro => clk,											--
		interrupt_ack => interrupt_ack_gestor_pulsador, --
		peticion_int_0 => ar_btn(0),							-- BTN(0)
		peticion_int_1 => '0',									--
		reset => reset,											--
		interrupt => interrupt_aux,							--
		origen_int => open
	);

	
end Behavioral;

