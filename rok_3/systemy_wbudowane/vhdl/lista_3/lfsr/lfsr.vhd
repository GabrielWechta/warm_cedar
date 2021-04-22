LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.P.ALL;

ENTITY lfsr IS
  PORT (
    clk : IN STD_LOGIC;
    q : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0) := ('0', '0', '0', '0', '0', '0', '0', '0', '1', '1', '1', '1', '1', '1', '1', '1')
  );
END lfsr;

ARCHITECTURE Behavioral OF lfsr IS
BEGIN
  PROCESS
  BEGIN
    q(15 DOWNTO 1) <= q(14 DOWNTO 0); -- shift
    q(0) <= NOT(q(15) XOR q(14) XOR q(13) XOR q(4)); -- linear feedback function
    print(to_hstring(q));

    WAIT UNTIL clk'event AND clk = '1';
  END PROCESS;
END Behavioral;