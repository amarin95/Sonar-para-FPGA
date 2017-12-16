-- Circuito de control dinamico de los 4 visualizadores de 7 segmentos
-- de anodo comun, de la placa Nexys 2

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_visualizador_dinamico_Nexys_2_8_segmentos is
    Port (
           -- ENTRADAS
           -- puesta en estado inicial de todo el circuito
           reset : in std_logic;
			  -- Valores de los segmentos, activos a nivel uno en orden A,B,C,D,E,F,G,DP
           vis3_D : in std_logic_vector(7 downto 0);
           vis2_D : in std_logic_vector(7 downto 0);
           vis1_D : in std_logic_vector(7 downto 0);
           vis0_D : in std_logic_vector(7 downto 0);
			  -- contador de seleccion de visualizador
			  gctr : in std_logic;
           clk1kHz : in std_logic;
			  -- habilitacion de los visualizadores
           gvis : in std_logic;
           gvis3 : in std_logic;
           gvis2 : in std_logic;
           gvis1 : in std_logic;
           gvis0 : in std_logic;

			  -- SALIDAS
			  -- ánodos de los visualizadores, activos a nivel cero
           an3 : out std_logic;
           an2 : out std_logic;
           an1 : out std_logic;
           an0 : out std_logic;
			  -- cátodos (segmentos) comunes a los visualizadores de anodo comun, activos a nivel cero
           A : out std_logic;
           B : out std_logic;
           C : out std_logic;
           D : out std_logic;
           E : out std_logic;
           F : out std_logic;
           G : out std_logic;
           DP : out std_logic);
end control_visualizador_dinamico_Nexys_2_8_segmentos;

architecture Behavioral of control_visualizador_dinamico_Nexys_2_8_segmentos is

-- Declaracion de senhales internas
signal contador_vis: std_logic_vector (1 downto 0);
signal segmentos: std_logic_vector (7 downto 0);

begin

process (reset,clk1kHz,gvis,gvis3,gvis2,gvis1,gvis0,gctr,contador_vis,vis0_D,vis1_D,vis2_D,vis3_D)
begin
-- Contador de 2 bits para seleccion del visualizador
	If reset ='1' then contador_vis <= "00";
	elsif clk1kHz ='1' and clk1kHz'event then
		if gctr ='1' then contador_vis <= contador_vis + 1;
		end if;
	end if;

-- Decodificador 1 entre 4 para seleccion del visualizador
-- con inhibicion de cada visualizador e inhibicion global
-- Los ánodos son activos a nivel 0
	an3 <= not (gvis and gvis3 and contador_vis(1) and contador_vis(0)); -- Visualizador de mayor peso
	an2 <= not (gvis and gvis2 and contador_vis(1) and not contador_vis(0));
	an1 <= not (gvis and gvis1 and not contador_vis(1) and contador_vis(0));
	an0 <= not (gvis and gvis0 and not contador_vis(1) and not contador_vis(0)); -- Visualizador de menor peso

-- Multiplexor de cuatro canales de 8 bits para la seleccion del
-- dato a visualizar, correspondiente al visualizador seleccionado
-- en ese momento por el contador
	Case contador_vis is
		when "00" => segmentos <= vis0_D;
		when "01" => segmentos <= vis1_D;
		when "10" => segmentos <= vis2_D;
		when "11" => segmentos <= vis3_D;
		when others => segmentos <= "00000000";
	end case;

end process;

A <= not segmentos(7);
B <= not segmentos(6);
C <= not segmentos(5);
D <= not segmentos(4);
E <= not segmentos(3);
F <= not segmentos(2);
G <= not segmentos(1);
DP <= not segmentos(0);

end Behavioral;
