LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- AND
ENTITY gateAndThree IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        C : IN STD_LOGIC;
        Z : OUT STD_LOGIC
    );
END gateAndThree;

ARCHITECTURE Behavioral OF gateAndThree IS
BEGIN
    Z <= A AND B AND C AFTER 1 ns;
END Behavioral;
----------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- OR
ENTITY gateOrThree IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        C : IN STD_LOGIC;
        Z : OUT STD_LOGIC
    );
END gateOrThree;

ARCHITECTURE Behavioral OF gateOrThree IS
BEGIN
    Z <= A OR B OR C AFTER 1 ns;
END Behavioral;
----------------------------------------------------

-- MUX
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux IS
    PORT (
        a, b : IN STD_LOGIC;
        s : IN STD_LOGIC;
        z : OUT STD_LOGIC
    );
END mux;

ARCHITECTURE Behavioral OF mux IS
BEGIN
    PROCESS (a, b, s)
        VARIABLE sel : INTEGER;
    BEGIN
        IF s = '0' THEN
            z <= a;
        ELSE
            z <= b;
        END IF;
    END PROCESS;
END Behavioral;