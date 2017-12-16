----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:01:32 09/17/2015 
-- Design Name: 
-- Module Name:    rs_flip_flop - Behavioral 
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

entity rs_flip_flop is
    Port ( clk : in  STD_LOGIC;
           r : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           s : in  STD_LOGIC;
           q : out  STD_LOGIC);
end rs_flip_flop;

architecture Behavioral of rs_flip_flop is
signal q_int : std_logic;
begin

	PROCESS(clk,reset,q_int)
	begin
		if (reset='1') then
			q_int<='0';
		elsif(clk'event and clk='1') then
			if(s='0' and r='0')then
				q_int<=q_int;
			elsif(s='1' and r='1')then
				q_int<='1';
			elsif(s='0' and r='1')then
				q_int<='0';
			else
				q_int<='1';
			end if;
		end if;
		q<=q_int;
	end PROCESS;
end Behavioral;

