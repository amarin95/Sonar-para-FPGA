--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:02:00 11/22/2015
-- Design Name:   
-- Module Name:   C:/Users/Alberto/Desktop/TELECO/CEP/Practica6/test_top.vhd
-- Project Name:  Practica6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_template_picoblaze_3_placa_Nexys_2
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_top IS
END test_top;
 
ARCHITECTURE behavior OF test_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_template_picoblaze_3_placa_Nexys_2
    PORT(
         clk : IN  std_logic;
         SW : IN  std_logic_vector(7 downto 0);
         BTN : IN  std_logic_vector(3 downto 0);
         PWD : IN  std_logic;
         LEDs : OUT  std_logic_vector(7 downto 0);
         an0 : OUT  std_logic;
         an1 : OUT  std_logic;
         an2 : OUT  std_logic;
         an3 : OUT  std_logic;
         A : OUT  std_logic;
         B : OUT  std_logic;
         C : OUT  std_logic;
         D : OUT  std_logic;
         E : OUT  std_logic;
         F : OUT  std_logic;
         G : OUT  std_logic;
         DP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal SW : std_logic_vector(7 downto 0) := (others => '0');
   signal BTN : std_logic_vector(3 downto 0) := (others => '0');
   signal PWD : std_logic := '0';

 	--Outputs
   signal LEDs : std_logic_vector(7 downto 0);
   signal an0 : std_logic;
   signal an1 : std_logic;
   signal an2 : std_logic;
   signal an3 : std_logic;
   signal A : std_logic;
   signal B : std_logic;
   signal C : std_logic;
   signal D : std_logic;
   signal E : std_logic;
   signal F : std_logic;
   signal G : std_logic;
   signal DP : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_template_picoblaze_3_placa_Nexys_2 PORT MAP (
          clk => clk,
          SW => SW,
          BTN => BTN,
          PWD => PWD,
          LEDs => LEDs,
          an0 => an0,
          an1 => an1,
          an2 => an2,
          an3 => an3,
          A => A,
          B => B,
          C => C,
          D => D,
          E => E,
          F => F,
          G => G,
          DP => DP
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
  begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		BTN(3) <= '1';
      wait for clk_period*100;
		BTN(3) <= '0';
		BTN(0) <= '1';
		
		wait for clk_period*100;
		
		BTN(0) <= '0';
		
		wait for clk_period*2;
		
		PWD <= '1';
		
		wait for 1470 us;
		
		PWD <= '0';
		
		wait for clk_period*10;


      -- insert stimulus here 

      wait;
   
   end process;

END;
