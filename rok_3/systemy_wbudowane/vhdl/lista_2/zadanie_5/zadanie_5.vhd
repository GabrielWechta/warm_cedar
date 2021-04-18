LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std;

ENTITY Orand IS
    PORT (
        i0, i1, i2 : IN STD_LOGIC;
        s : IN STD_LOGIC;

        output : OUT STD_LOGIC
    );
END Orand;

ARCHITECTURE Behavioral OF Orand IS
    COMPONENT gateAndThree
        PORT (
            a, b, c : IN STD_LOGIC;
            z : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT gateOrThree
        PORT (
            a, b, c : IN STD_LOGIC;
            z : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT mux
        PORT (
            a, b, s : IN STD_LOGIC;
            z : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL after_or, after_and : STD_LOGIC;

BEGIN
    GL : gateOrThree PORT MAP(i0, i1, i2, after_or);
    GR : gateAndThree PORT MAP(i0, i1, i2, after_and);

    GO : mux PORT MAP(after_or, after_and, s, output);
END Behavioral;