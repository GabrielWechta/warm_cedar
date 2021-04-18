LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY simple_tb IS
END simple_tb;

ARCHITECTURE behavior OF simple_tb IS

   -- UUT (Unit Under Test)
   COMPONENT simple
      PORT (
         clk : IN STD_LOGIC;
         rst : IN STD_LOGIC;
         q : INOUT unsigned(7 DOWNTO 0)
      );
   END COMPONENT;

   -- input signals
   SIGNAL clk : STD_LOGIC := '0';
   SIGNAL rst : STD_LOGIC := '0';

   -- input/output signal
   SIGNAL qq : unsigned(7 DOWNTO 0);

   -- set clock period 
   CONSTANT clk_period : TIME := 20 ns;

BEGIN
   -- instantiate UUT
   uut : simple PORT MAP(
      clk => clk,
      rst => rst,
      q => qq
   );

   -- clock management process
   -- no sensitivity list, but uses 'wait'
   clk_process : PROCESS
   BEGIN
      clk <= '0';
      WAIT FOR clk_period/2;
      clk <= '1';
      WAIT FOR clk_period/2;
   END PROCESS;

   -- -- stimulating process
   stim_proc : PROCESS
   BEGIN
      rst <= '1';
      WAIT FOR 700 ns;

      rst <= '0';
      WAIT FOR 50 ns;

      rst <= '1';
      WAIT FOR 440 ns;

      rst <= '0';
      WAIT;
   END PROCESS;
END;