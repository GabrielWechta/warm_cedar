
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;
USE IEEE.std_logic_textio.ALL;

ENTITY lossy_channel_tb IS
END lossy_channel_tb;

ARCHITECTURE behavior OF lossy_channel_tb IS

   COMPONENT lossy_channel
      GENERIC (N : POSITIVE);
      PORT (
         data_in : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
         clk : IN STD_LOGIC;
         data_out : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
      );
   END COMPONENT;

   COMPONENT encoder
      PORT (
         clk : IN STD_LOGIC;
         wordIn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         hamOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0')
      );
   END COMPONENT;

   COMPONENT decoder
      PORT (
         clk : IN STD_LOGIC;
         lossied_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         decoded : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
         debugger : OUT STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
         hands_are_spreading : OUT STD_LOGIC := '0'
      );
   END COMPONENT;

   CONSTANT WIDTH : POSITIVE := 16;
   CONSTANT ASCII_WIDTH : POSITIVE := 8;
   SIGNAL clk : STD_LOGIC := '0';

   SIGNAL data_in : STD_LOGIC_VECTOR(ASCII_WIDTH - 1 DOWNTO 0) := (OTHERS => '0');

   SIGNAL coded_in : STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
   SIGNAL coded_out : STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
   SIGNAL lossied_out : STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
   SIGNAL lossied_in : STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
   SIGNAL debugger : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
   SIGNAL panic : STD_LOGIC := '0';

   SIGNAL data_out : STD_LOGIC_VECTOR(7 DOWNTO 0);

   CONSTANT clk_period : TIME := 10 ns;

BEGIN

   uut_encoder : encoder
   PORT MAP(
      clk => clk,
      wordIn => data_in,
      hamOut => coded_out
   );

   uut : lossy_channel
   GENERIC MAP(N => WIDTH)
   PORT MAP(
      data_in => coded_in,
      clk => clk,
      data_out => lossied_out
   );

   uut_decoder : decoder
   PORT MAP(
      clk => clk,
      lossied_in => lossied_in,
      decoded => data_out,
      debugger => debugger,
      hands_are_spreading => panic
   );

   clk_process : PROCESS
   BEGIN
      clk <= '0';
      WAIT FOR clk_period/2;
      clk <= '1';
      WAIT FOR clk_period/2;
   END PROCESS;

   stim_proc : PROCESS IS
      VARIABLE my_line : line;
   BEGIN
      WAIT FOR 100 ns;

      FOR i IN 0 TO 255
         LOOP
            write(my_line, i);
            writeline(output, my_line);

            write(my_line, STD_LOGIC_VECTOR(to_unsigned(i, data_in'length)));
            writeline(output, my_line);

            data_in <= STD_LOGIC_VECTOR(to_unsigned(i, data_in'length));

            WAIT FOR clk_period;

            write(my_line, coded_out);
            writeline(output, my_line);

            coded_in <= coded_out;

            WAIT FOR clk_period;

            write(my_line, lossied_out);
            writeline(output, my_line);

            lossied_in <= lossied_out;

            WAIT FOR clk_period;

            write(my_line, data_out);
            writeline(output, my_line);

            write(my_line, STRING'("debugger:"));
            writeline(output, my_line);
            write(my_line, debugger);
            writeline(output, my_line);

            write(my_line, STRING'("hands are spreading:"));
            writeline(output, my_line);
            write(my_line, panic);
            writeline(output, my_line);
            ASSERT data_in = data_out REPORT "failed, sir!";

            write(my_line, STRING'(""));
            writeline(output, my_line);
         END LOOP;
         WAIT;
      END PROCESS;

   END;