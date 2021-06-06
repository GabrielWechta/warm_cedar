LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY lfsr IS
  PORT (
    clk : IN STD_LOGIC;
    q : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0')
  );
END lfsr;

ARCHITECTURE Behavioral OF lfsr IS
  SIGNAL qq : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
BEGIN

  -- cyclic register with taps
  PROCESS
  BEGIN
    qq(15 DOWNTO 1) <= qq(14 DOWNTO 0);
    qq(0) <= NOT(qq(15) XOR qq(14) XOR qq(13) XOR qq(4));
    WAIT UNTIL clk'event AND clk = '1';
  END PROCESS;

  -- buffer collecting random bits
  PROCESS
  BEGIN
    q(15 DOWNTO 1) <= q(14 DOWNTO 0);
    q(0) <= qq(0);
    WAIT UNTIL clk'event AND clk = '1';
  END PROCESS;

END Behavioral;