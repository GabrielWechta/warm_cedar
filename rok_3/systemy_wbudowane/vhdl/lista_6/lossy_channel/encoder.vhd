LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
LIBRARY STD;
USE STD.textio.ALL;
USE IEEE.std_logic_textio.ALL;

ENTITY encoder IS
    PORT (
        clk : IN STD_LOGIC;
        wordIn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        hamOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0')
    );
END encoder;

ARCHITECTURE Behavioral OF encoder IS
BEGIN
    PROCESS (clk) IS
        VARIABLE hamming : STD_LOGIC_VECTOR(0 TO 15) := (OTHERS => '0'); -- thank God for this realization 
    BEGIN
        hamming(7) := wordIn(7);
        hamming(9 TO 15) := wordIn(6 DOWNTO 0);
        hamming(1) := hamming(3) XOR hamming(5) XOR hamming(7) XOR hamming(9) XOR hamming(11) XOR hamming(13) XOR hamming(15);
        hamming(2) := hamming(3) XOR hamming(6) XOR hamming(7) XOR hamming(10) XOR hamming(11) XOR hamming(14) XOR hamming(15);
        hamming(4) := hamming(5) XOR hamming(6) XOR hamming(7) XOR hamming(12) XOR hamming(13) XOR hamming(14) XOR hamming(15);
        hamming(8) := hamming(9) XOR hamming(10) XOR hamming(11) XOR hamming(12) XOR hamming(13) XOR hamming(14) XOR hamming(15);
        hamming(0) := hamming(1) XOR hamming(2) XOR hamming(3) XOR hamming(4) XOR hamming(5) XOR hamming(6) XOR hamming(7) XOR hamming(8) XOR hamming(9) XOR hamming(10) XOR hamming(11) XOR hamming(12) XOR hamming(13) XOR hamming(14) XOR hamming(15);
        hamOut <= hamming;
    END PROCESS;

END Behavioral;