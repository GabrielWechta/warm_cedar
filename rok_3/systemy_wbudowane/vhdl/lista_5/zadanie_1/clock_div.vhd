LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY clock_div IS GENERIC (target_freq : NATURAL);
PORT (
    clk_in : IN STD_LOGIC;
    clk_out : OUT STD_LOGIC
);
END clock_div;

ARCHITECTURE Behavioral OF clock_div IS
BEGIN
    PROCESS (clk_in)
        VARIABLE tacts_number : NATURAL := 125000000 / target_freq; -- 125 MHz / x
        VARIABLE wait_number : NATURAL := 0;
    BEGIN
        IF (clk_in'event AND clk_in = '1') THEN
            wait_number := wait_number + 1;
            IF (wait_number <= tacts_number) THEN
                clk_out <= '0';
            ELSE
                clk_out <= '1';
            END IF;
            wait_number := wait_number MOD (2 * tacts_number);
        END IF;
    END PROCESS;
END Behavioral;