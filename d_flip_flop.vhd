----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:02:04 09/17/2015 
-- Design Name: 
-- Module Name:    d_flip_flop - Behavioral 
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

entity d_flip_flop is
    Port ( ce : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           d : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           q : out  STD_LOGIC);
end d_flip_flop;

architecture Behavioral of d_flip_flop is

begin

process (clk, reset)
begin
   if reset='1' then   
      q <= '0';
   elsif (clk'event and clk='1') then 
      if ce = '1' then 
         q <= d;
      end if; 
   end if;
end process;
 




end Behavioral;

