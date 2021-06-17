LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;
USE IEEE.std_logic_textio.ALL;

ENTITY decoder IS
    PORT (
        clk : IN STD_LOGIC;
        lossied_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        decoded : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
        debugger : OUT STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
        hands_are_spreading : OUT STD_LOGIC := '0'
    );
END decoder;

ARCHITECTURE Behavioral OF decoder IS
BEGIN
    PROCESS (clk) IS
        VARIABLE dec : STD_LOGIC_VECTOR(0 TO 15) := (OTHERS => '0');
        VARIABLE holder : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
        VARIABLE empty : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
        VARIABLE index_vector : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
        VARIABLE index : INTEGER := 0;
        VARIABLE deb : STD_LOGIC_VECTOR(0 TO 4) := (OTHERS => '0');
        VARIABLE first : STD_LOGIC := '1';
        VARIABLE something_wrong : STD_LOGIC := '0';
    BEGIN
        dec := lossied_in;
        deb(0) := (dec(0)) XOR dec(1) XOR dec(2) XOR dec(3) XOR dec(4) XOR dec(5) XOR dec(6) XOR dec(7) XOR dec(8) XOR dec(9) XOR dec(10) XOR dec(11) XOR dec(12) XOR dec(13) XOR dec(14) XOR dec(15);
        deb(1) := (dec(1)) XOR dec(3) XOR dec(5) XOR dec(7) XOR dec(9) XOR dec(11) XOR dec(13) XOR dec(15);
        deb(2) := (dec(2)) XOR dec(3) XOR dec(6) XOR dec(7) XOR dec(10) XOR dec(11) XOR dec(14) XOR dec(15);
        deb(3) := (dec(4)) XOR dec(5) XOR dec(6) XOR dec(7) XOR dec(12) XOR dec(13) XOR dec(14) XOR dec(15);
        deb(4) := (dec(8)) XOR dec(9) XOR dec(10) XOR dec(11) XOR dec(12) XOR dec(13) XOR dec(14) XOR dec(15);
        something_wrong := deb(1) OR deb(2) OR deb(3) OR deb(4);
        IF something_wrong = '0' AND deb(0) = '0' THEN
            hands_are_spreading <= '0';

            holder(7) := dec(7);
            holder(6 DOWNTO 0) := dec(9 TO 15);
        ELSIF something_wrong = '1' AND deb(0) = '0' THEN
            hands_are_spreading <= '1';
            holder := empty;
        ELSE
            hands_are_spreading <= '0';
            --
            index_vector(3) := deb(1);
            index_vector(2) := deb(2);
            index_vector(1) := deb(3);
            index_vector(0) := deb(4);

            index := to_integer(unsigned(index_vector));
            dec(index) := NOT dec(index);
            --
            holder(7) := dec(7);
            holder(6 DOWNTO 0) := dec(9 TO 15);
        END IF;
        debugger <= deb;
        decoded <= holder;
    END PROCESS;

END Behavioral;