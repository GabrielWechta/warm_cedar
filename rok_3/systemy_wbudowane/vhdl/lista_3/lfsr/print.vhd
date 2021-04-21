LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_textio.ALL;
USE std.textio.ALL;

PACKAGE P IS
    FUNCTION to_hstring (SLV : STD_LOGIC_VECTOR) RETURN STRING;
    PROCEDURE print (str : IN STRING);
END PACKAGE P;
PACKAGE BODY P IS

    ----------------------------------------
    FUNCTION to_hstring (SLV : STD_LOGIC_VECTOR) RETURN STRING IS
        VARIABLE L : LINE;
    BEGIN
        hwrite(L, SLV);
        -- writeline(output, L);
        RETURN L.ALL;
    END FUNCTION to_hstring;
    ----------------------------------------

    PROCEDURE print(str : IN STRING) IS
        VARIABLE oline : line;
    BEGIN
        write(oline, str);
        writeline(output, oline);
    END PROCEDURE;

END PACKAGE BODY P;