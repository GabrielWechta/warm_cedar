LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;
USE IEEE.std_logic_textio.ALL;

ENTITY decoder IS
    PORT (
        clk : IN STD_LOGIC;
        lossiedIn : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        decoded : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0')
    );
END decoder;

ARCHITECTURE Behavioral OF decoder IS
BEGIN
    PROCESS (clk) IS
        VARIABLE dec : STD_LOGIC_VECTOR(0 TO 15) := (OTHERS => '0');
        VARIABLE holder : STD_LOGIC_VECTOR(0 TO 15) := (OTHERS => '0');
        VARIABLE index : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
        VARIABLE first : STD_LOGIC := '1';
    BEGIN
        dec := lossiedIn;
        FOR i IN 0 TO 15 LOOP
            IF dec(i) = '1' THEN
                index := STD_LOGIC_VECTOR(to_unsigned(i, index'length));
                IF first = '1' THEN
                    holder := index;
                    first := '0';
                ELSE
                    holder := holder XOR index;
                END IF;
            END IF;
        END LOOP;
        decoded <= index;
    END PROCESS;

END Behavioral;