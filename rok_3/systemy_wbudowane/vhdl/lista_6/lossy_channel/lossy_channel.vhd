-- experimental implementation of a lossy transmission channel
-- channel transports N-bit vectors and determines at random
-- if/which bit(s) should be flipped 
-- there is no transmission delay implemented

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY lossy_channel IS
	GENERIC (N : POSITIVE := 8);
	PORT (
		data_in : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
		clk : IN STD_LOGIC;
		data_out : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0));
END lossy_channel;

ARCHITECTURE Behavioral OF lossy_channel IS

	SIGNAL q_rand : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL decision : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL place1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL place2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	COMPONENT lfsr
		PORT (
			clk : IN STD_LOGIC;
			q : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;

BEGIN

	randomizer : lfsr PORT MAP
	(
		clk => clk,
		q => q_rand);

	-- three bits determine if bit is filpped
	decision <= q_rand(1) & q_rand(4) & q_rand(13);
	-- four bits determine which bit is flipped
	place1 <= q_rand(0) & q_rand(5) & q_rand(10) & q_rand(14);
	place2 <= q_rand(2) & q_rand(7) & q_rand(8) & q_rand(12);

	p1 : PROCESS (clk)
	BEGIN
		IF decision = "110" -- decision to flip one bit
			THEN
			FOR I IN data_in'RANGE LOOP
				IF I = to_integer(unsigned(place1))
					THEN
					data_out(I) <= NOT data_in(I);
				ELSE
					data_out(I) <= data_in(I);
				END IF;
			END LOOP;
		ELSIF decision = "010" -- decision to flip two bits
			THEN
			FOR I IN data_in'RANGE LOOP
				IF I = to_integer(unsigned(place1))
					OR
					I = to_integer(unsigned(place2))
					THEN
					data_out(I) <= NOT data_in(I);
				ELSE
					data_out(I) <= data_in(I);
				END IF;
			END LOOP;
		ELSE
			data_out <= data_in;
		END IF;
	END PROCESS;

END Behavioral;