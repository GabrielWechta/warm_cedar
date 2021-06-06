LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL;

ENTITY n_clock_div IS GENERIC (n : NATURAL);
PORT (
    clk_in : IN STD_LOGIC;
    clks_out : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0) := (OTHERS => '0')
);
END n_clock_div;

ARCHITECTURE Behavioral OF n_clock_div IS
BEGIN
    PROCESS (clk_in)
        VARIABLE x : UNSIGNED(n - 1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE dir : STD_LOGIC := '0';
    BEGIN
        IF (clk_in'event AND clk_in = '1') THEN
            x := x + 1;
            IF x = 2 ** n THEN
                x := (OTHERS => '0');
            END IF;
        END IF;
        clks_out <= STD_LOGIC_VECTOR(x);
    END PROCESS;
END Behavioral;