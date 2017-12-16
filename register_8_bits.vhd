----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:59:13 09/17/2015 
-- Design Name: 
-- Module Name:    register_8_bits - Behavioral 
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

entity register_8_bits is
    Port ( d : in  STD_LOGIC_VECTOR (7 downto 0);
           ce : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (7 downto 0));
end register_8_bits;

architecture Behavioral of register_8_bits is
signal q_interna: STD_LOGIC_VECTOR (7 downto 0);
begin

process(clk,reset,ce,d)
begin
	if(reset='1') then
		q<="00000000";
	elsif(clk'event and clk='1') then
		if (ce='1') then
			q<=d;
		end if;
	end if;
end process;
end Behavioral;

