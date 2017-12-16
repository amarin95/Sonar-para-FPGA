----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:34:12 11/21/2015 
-- Design Name: 
-- Module Name:    conversor_binario_a_letra - Behavioral 
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

entity conversor_binario_a_letra is
    Port ( digito : in  STD_LOGIC_VECTOR (7 downto 0);
           letra : out  STD_LOGIC_VECTOR (7 downto 0));
end conversor_binario_a_letra;

architecture Behavioral of conversor_binario_a_letra is

begin
process(digito)
begin
case digito is
when "00000000" => letra <= "11111100" ;
when "00000001" => letra <= "01100000";
when "00000010" => letra <= "11011010";
when "00000011" => letra <= "11110010";
when "00000100" => letra <= "01100110";
when "00000101" => letra <= "10110110";
when "00000110" => letra <= "10111110";
when "00000111" => letra <= "11100000";
when "00001000" => letra <= "11111110";
when "00001001" => letra <= "11110110";
when "00111010" => letra <= "00111010";
when "11100010" => letra <= "10001110";
when "11111111" => letra <= "00000000";
when others => letra <= "00000000";
end case;
end process;


end Behavioral;

