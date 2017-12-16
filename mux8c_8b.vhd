----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:48:44 09/17/2015 
-- Design Name: 
-- Module Name:    mux8c_8b - Behavioral 
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

entity mux8c_8b is
    Port ( canal_0_entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           canal_1_entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           canal_2_entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           canal_3_entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           canal_4_entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           canal_5_entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           canal_6_entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           canal_7_entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (7 downto 0));
end mux8c_8b;

architecture Behavioral of mux8c_8b is

begin
process (sel)
begin
	case sel is 
		when "000" => mux_out<=canal_0_entrada;
		when "001" => mux_out<=canal_1_entrada;
		when "010" => mux_out<=canal_2_entrada;
		when "011" => mux_out<=canal_3_entrada;
		when "100" => mux_out<=canal_4_entrada;
		when "101" => mux_out<=canal_5_entrada;
		when "110" => mux_out<=canal_6_entrada;
		when "111" => mux_out<=canal_7_entrada;
		when others => mux_out<="00000000";
	end case;
end process;
end Behavioral;

