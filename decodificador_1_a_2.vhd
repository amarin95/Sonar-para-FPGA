----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:59:03 09/17/2015 
-- Design Name: 
-- Module Name:    decodificador_1_a_2 - Behavioral 
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

entity decodificador_1_a_2 is
    Port ( dec_in : in  STD_LOGIC;
           en : in  STD_LOGIC;
           out_0 : out  STD_LOGIC;
           out_1 : out  STD_LOGIC);
end decodificador_1_a_2;

architecture Behavioral of decodificador_1_a_2 is
signal entradas : std_logic_vector(1 downto 0);
signal salidas : std_logic_vector(1 downto 0);
begin
entradas<=en & dec_in;
	with entradas select
	salidas <= "01" when "10",
				  "10" when "11",
				  "00" when others;
	out_0<=salidas(0);
	out_1<=salidas(1);
end Behavioral;

