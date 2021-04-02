LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Orand_tb IS
END Orand_tb;

ARCHITECTURE behavior OF Orand_tb IS
    COMPONENT Orand
        PORT (
            i0, i1, i2 : IN STD_LOGIC;
            s : IN STD_LOGIC;

            output : OUT STD_LOGIC
        );
    END COMPONENT;

    -- input
    SIGNAL i0, i1, i2 : STD_LOGIC := '0';

    SIGNAL input : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL input_copy : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');


    -- setting
    SIGNAL s : STD_LOGIC := '0';
    signal s_up : STD_LOGIC := '1';

    -- output
    SIGNAL output : STD_LOGIC;

    -- clock period
    CONSTANT period : TIME := 10 ns;

BEGIN

    uut : Orand PORT MAP(
        i0 => i0,
        i1 => i1,
        i2 => i2,

        s => s,
        output => output
    );

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 1 ns;

        FOR i IN 0 TO 2 ** 3 LOOP

            i0 <= input(0);
            i1 <= input(1);
            i2 <= input(2);

            s <= s;

            input <= STD_LOGIC_VECTOR(unsigned(input) + 1);

            WAIT FOR period;
        END LOOP;

        -- s <= s_up;

        FOR i IN 0 TO 2 ** 3 LOOP

            i0 <= input_copy(0);
            i1 <= input_copy(1);
            i2 <= input_copy(2);

            s <= s_up;

            input_copy <= STD_LOGIC_VECTOR(unsigned(input_copy) + 1);

            WAIT FOR period;
        END LOOP;

        WAIT;
    END PROCESS;
END behavior;