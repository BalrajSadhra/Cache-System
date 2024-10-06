--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:19:12 10/23/2023
-- Design Name:   
-- Module Name:   /home/student1/bsadhra/COE 758/Lab 1/cachecontroller/cachetest.vhd
-- Project Name:  cachecontroller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cacheController
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
 
ENTITY cachetest IS
END cachetest;
 
ARCHITECTURE behavior OF cachetest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cacheController
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         trig : IN  std_logic;
		   osdramAddr : out std_logic_vector(15 downto 0);
		   osramAddr :  out std_logic_vector(7 downto 0);
		   osramWEN : out std_logic;
		   osdramWrRd : out std_logic;
		   oRDY			: out std_logic;
         MSTRB : OUT  std_logic;
         currentVbit : OUT  std_logic;
         currentDbit : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal trig : std_logic := '0';

 	--Outputs
	signal osdramAddr :  std_logic_vector(15 downto 0);
	signal osramAddr :   std_logic_vector(7 downto 0);
	signal osramWEN :  std_logic;
	signal osdramWrRd :  std_logic;
	signal oRDY			:  std_logic;
   signal MSTRB : std_logic;
   signal currentVbit : std_logic;
   signal currentDbit : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cacheController PORT MAP (
          clk => clk,
          rst => rst,
          trig => trig,
			 osdramAddr  => osdramAddr,
			 osramAddr   => osramAddr,
			 osramWEN    => osramWEN,
			 osdramWrRd  => osdramWrRd,
			 oRDY		  => oRDY,
          MSTRB => MSTRB,
          currentVbit => currentVbit,
          currentDbit => currentDbit
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

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;