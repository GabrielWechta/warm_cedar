LIBRARY STD;
USE STD.textio.ALL;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY clock_div_tb IS
END clock_div_tb;

ARCHITECTURE behavior OF clock_div_tb IS
    COMPONENT clock_div
    GENERIC (target_freq: NATURAL);
        PORT (
            clk_in : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC
        );
    END COMPONENT;

    -- clocks
    SIGNAL clk_in : STD_LOGIC := '0';
    SIGNAL clk_out_1 : STD_LOGIC := '0';
    SIGNAL clk_out_2 : STD_LOGIC := '0';
    SIGNAL clk_out_3 : STD_LOGIC := '0';
    
    -- clock period 
    CONSTANT clk_period : TIME := 8 ns; -- 125 MHz equals 8 ns
BEGIN
    uut_1 : clock_div
    GENERIC MAP(target_freq => 100)
    PORT MAP(
        clk_in => clk_in,
        clk_out => clk_out_1
    );

    uut_2 : clock_div
    GENERIC MAP(target_freq => 1100)
    PORT MAP(
        clk_in => clk_in,
        clk_out => clk_out_2
    );

    uut_3 : clock_div
    GENERIC MAP(target_freq => 50000000)
    PORT MAP(
        clk_in => clk_in,
        clk_out => clk_out_3
    );

    clk_process : PROCESS
    BEGIN
        clk_in <= '0';
        WAIT FOR clk_period/2;
        clk_in <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;
END;