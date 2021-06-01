LIBRARY STD;
USE STD.textio.ALL;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY n_clock_div_tb IS
END n_clock_div_tb;

ARCHITECTURE behavior OF n_clock_div_tb IS
    COMPONENT n_clock_div
    GENERIC (n: NATURAL);
        PORT (
            clk_in : IN STD_LOGIC;
            clks_out : OUT STD_LOGIC_VECTOR
        );
    END COMPONENT;

    constant N : NATURAL := 8;

    -- clocks
    SIGNAL clk_in : STD_LOGIC := '0';
    SIGNAL clks_out: STD_LOGIC_VECTOR (N-1 DOWNTO 0) := (others => '0');
    
    -- clock period 
    CONSTANT clk_period : TIME := 8 ns; -- 125 MHz equals 8 ns
BEGIN
    uut : n_clock_div
    GENERIC MAP(n => N)
    PORT MAP(
        clk_in => clk_in,
        clks_out => clks_out
    );

    clk_process : PROCESS
    BEGIN
        clk_in <= '0';
        WAIT FOR clk_period/2;
        clk_in <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;
END;