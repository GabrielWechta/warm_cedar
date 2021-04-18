LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- jesli mozliwe, nie uzywac std_logic_unsigned -- nie wspiera standardow
--USE ieee.std_logic_unsigned.ALL;
-- numeric_std i owszem
USE ieee.numeric_std.ALL;
ENTITY example_tb IS
END example_tb;

ARCHITECTURE behavior OF example_tb IS

   -- deklaracja komponentu Unit Under Test (UUT)

   COMPONENT example
      PORT (
         a : IN STD_LOGIC;
         b : IN STD_LOGIC;
         c : IN STD_LOGIC;
         x : OUT STD_LOGIC
      );
   END COMPONENT;

   -- inputs
   SIGNAL a : STD_LOGIC := '0';
   SIGNAL b : STD_LOGIC := '0';
   SIGNAL c : STD_LOGIC := '0';

   -- sprawdz dzialanie obu ponizszych, alternatywnych deklaracji
   SIGNAL abc : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
   --SIGNAL abc : unsigned(2 DOWNTO 0) := (OTHERS => '0');

   --Outputs
   SIGNAL x : STD_LOGIC;

   -- okres zegara
   CONSTANT period : TIME := 10 ns;

BEGIN

   -- instantiate the Unit Under Test (UUT)
   uut : example PORT MAP(
      a => a,
      b => b,
      c => c,
      x => x
   );

   -- Stimulus process
   stim_proc : PROCESS
   BEGIN
      -- hold reset state for 100 ns.
      WAIT FOR 100 ns;

      -- another way to do this... 
      FOR i IN 0 TO 6 LOOP
         -- w zaleznosci od tego, jak zadeklarowano sygnal 'abc',
         --     mozna go zwiekszyc na rozne sposoby
         -- sprawdz, ktory pasuje do ktorej deklaracji
         --  ten:
         abc <= STD_LOGIC_VECTOR(unsigned(abc) + 1);
         --  i ten:
         --abc <= abc + 1;
         a <= abc(2);
         b <= abc(1);
         c <= abc(0);
         WAIT FOR period;
      END LOOP;
      WAIT;
   END PROCESS;

END;