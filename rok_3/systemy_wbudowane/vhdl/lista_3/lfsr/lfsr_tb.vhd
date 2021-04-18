LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY lfsr_tb IS
END lfsr_tb;

ARCHITECTURE behavior OF lfsr_tb IS
    COMPONENT lfsr
        PORT (
            clk : IN STD_LOGIC;
            q : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';

    SIGNAL qq : STD_LOGIC_VECTOR(15 DOWNTO 0) := (0 => '1', OTHERS => '0');

    CONSTANT clk_period : TIME := 20 ns;

BEGIN

    uut : lfsr PORT MAP(
        clk => clk,
        q => qq
    );

    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;
END;