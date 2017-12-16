library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flipflop_8bits is
Port ( ce : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           d : in  STD_LOGIC_VECTOR(7 downto 0);
           reset : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR(7 downto 0));
end flipflop_8bits;

architecture Behavioral of flipflop_8bits is

begin

process (clk, reset)
begin
   if reset='1' then   
      q <= "00000000";
   elsif (clk'event and clk='1') then 
      if ce = '1' then 
         q <= d;
      end if; 
   end if;
end process;
 




end Behavioral;


