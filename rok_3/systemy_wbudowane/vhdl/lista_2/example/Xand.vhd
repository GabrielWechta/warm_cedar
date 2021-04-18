LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std;
ENTITY Xand IS
	GENERIC (width : INTEGER := 8);
	PORT (
		clk : IN STD_LOGIC;
		A, B : IN STD_LOGIC_VECTOR(width - 1 DOWNTO 0);
		C : OUT STD_LOGIC_VECTOR(width - 1 DOWNTO 0)
	);
END Xand;

ARCHITECTURE Behavioral OF Xand IS
BEGIN
	C <= A AND B;
END Behavioral;