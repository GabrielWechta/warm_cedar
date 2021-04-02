LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Xand_tb IS
END Xand_tb;

ARCHITECTURE behavior OF Xand_tb IS

    COMPONENT Xand IS
        GENERIC (width : INTEGER);
        PORT (
            clk : IN STD_LOGIC;
            A, B : IN STD_LOGIC_VECTOR(width - 1 DOWNTO 0);
            C : OUT STD_LOGIC_VECTOR(width - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- clock 
    SIGNAL clk : STD_LOGIC := '0';

    -- inputs
    SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

    -- signal out  
    SIGNAL C : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- clock period
    CONSTANT period : TIME := 10 ns;

    -- test input
    SIGNAL A_v : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL B_v : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL B_zeros : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

BEGIN

    uut : Xand GENERIC MAP(width => 4)
    PORT MAP(
        clk => clk,
        A => A,
        B => B,
        C => C
    );

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 1 ns;

        FOR i IN 0 TO 2 ** 4 LOOP
            FOR j IN 0 TO 2 ** 4 LOOP
                A <= A_v;
                B <= B_v;
                B_v <= STD_LOGIC_VECTOR(unsigned(B_v) + 1);
                WAIT FOR period;
            END LOOP;

            B_v <= B_zeros;
            A_v <= STD_LOGIC_VECTOR(unsigned(A_v) + 1);

            WAIT FOR 1 ns;
        END LOOP;
        WAIT;
    END PROCESS;

END;