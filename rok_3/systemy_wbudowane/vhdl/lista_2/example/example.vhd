LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY example IS
  PORT (
    a, b, c : IN STD_LOGIC;
    x : OUT STD_LOGIC
  );
END example;

ARCHITECTURE Synthetic OF example IS
  COMPONENT gateNOT
    PORT (
      X : IN STD_LOGIC;
      Z : OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateOR
    PORT (
      X, Y : IN STD_LOGIC;
      Z : OUT STD_LOGIC);
  END COMPONENT;

  SIGNAL NOT_OR, OR_OR, OR_NOT : STD_LOGIC;

BEGIN
  G1 : gateNOT PORT MAP(a, NOT_OR);
  G2 : gateOR PORT MAP(b, c, OR_OR);
  -- alternatywne sposoby opisu mapowania portow
  --G3: gateOR  port map (NOT_OR,OR_OR,OR_NOT);
  G3 : gateOR PORT MAP(X => NOT_OR, Y => OR_OR, Z => OR_NOT);
  G4 : gateNOT PORT MAP(OR_NOT, x);
END Synthetic;