LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.pack.ALL;

ENTITY crc8 IS
  PORT (
    clk : IN STD_LOGIC;
    data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    crc_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END crc8;

ARCHITECTURE Behavioral OF crc8 IS
  SIGNAL newCRC : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN

  PROCESS (clk, data_in, newCRC)
  BEGIN
    IF clk = '1' AND rising_edge(clk)
      THEN
      newCRC <= nextCRC(data_in, newCRC);
    ELSE
      NULL;
    END IF;
  END PROCESS;

  crc_out <= newCRC;

END Behavioral;