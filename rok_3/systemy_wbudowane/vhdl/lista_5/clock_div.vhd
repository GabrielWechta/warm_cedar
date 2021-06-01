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
        VARIABLE wait_number : NATURAL := tacts_number;
    BEGIN
        IF (clk_in'event AND clk_in = '1') THEN
            IF wait_number = tacts_number THEN
                clk_out <= '1';
                wait_number := 0;
            END IF;
            wait_number := wait_number + 1;
        ELSE
            clk_out <= '0';
        END IF;
    END PROCESS;
END Behavioral;