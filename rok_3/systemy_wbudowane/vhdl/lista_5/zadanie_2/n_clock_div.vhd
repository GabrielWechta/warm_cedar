LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL;

ENTITY n_clock_div IS GENERIC (n : NATURAL);
PORT (
    clk_in : IN STD_LOGIC;
    clks_out : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0)
);
END n_clock_div;

ARCHITECTURE Behavioral OF n_clock_div IS
    TYPE t_Natural_Array IS ARRAY (NATURAL RANGE <>) OF NATURAL;

    FUNCTION init RETURN t_Natural_Array IS
        VARIABLE tacts : t_Natural_Array (n - 1 DOWNTO 0) := (OTHERS => 0);
    BEGIN
        FOR I IN 0 TO n - 1 LOOP
            tacts(i) := 2 ** (i + 1);
        END LOOP;
        RETURN tacts;
    END FUNCTION init;

    SIGNAL tacts_numbers : t_Natural_Array (n - 1 DOWNTO 0) := init;
BEGIN
    PROCESS (clk_in)
        VARIABLE counter : NATURAL := 0;
    BEGIN
        IF (clk_in'event AND clk_in = '1') THEN
            counter := counter + 1;
            counter := counter MOD 2 ** n;
            FOR i IN 0 TO n - 1 LOOP
                IF counter MOD tacts_numbers(i) = 0 THEN
                    clks_out(i) <= '1';
                END IF;
            END LOOP;
        ELSE
            FOR i IN 0 TO n - 1 LOOP
                clks_out(i) <= '0';
            END LOOP;
        END IF;
    END PROCESS;
END Behavioral;