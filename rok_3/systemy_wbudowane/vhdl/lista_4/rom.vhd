LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom_for_crc8 IS
	PORT (
		address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END rom_for_crc8;

--
-- ROM in this architecture stores CRC sums 
-- for constant input vector X"a0"
-- n-th generated CRC sum is stored under n-th address
--
ARCHITECTURE const_a0 OF rom_for_crc8 IS
	CONSTANT ADDRESS_WIDTH : INTEGER := 3;
	CONSTANT DATA_WIDTH : INTEGER := 8;
	TYPE rom_t IS ARRAY (0 TO 2 ** ADDRESS_WIDTH - 1)
	OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
	CONSTANT output_after_rom : rom_t := (
		X"69",
		X"71",
		X"39",
		X"c6",
		X"35",
		X"e2",
		X"c9",
		X"18"
	);
BEGIN
	data_out <= output_after_rom(to_integer(unsigned(address)));
END const_a0;

--
-- ROM in this architecture stores CRC sums 
-- for constant input vector X"66"
-- n-th generated CRC sum is stored under n-th address
--
ARCHITECTURE const_66 OF rom_for_crc8 IS
	CONSTANT ADDRESS_WIDTH : INTEGER := 3;
	CONSTANT DATA_WIDTH : INTEGER := 8;
	TYPE rom_t IS ARRAY (0 TO 2 ** ADDRESS_WIDTH - 1)
	OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
	CONSTANT output_after_rom : rom_t := (
		X"35",
		X"be",
		X"06",
		X"27",
		X"c0",
		X"7b",
		X"53",
		X"8b"
	);
BEGIN
	data_out <= output_after_rom(to_integer(unsigned(address)));
END const_66;