LIBRARY STD;
USE STD.textio.ALL;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY crc8_tb IS
END crc8_tb;

ARCHITECTURE behavior OF crc8_tb IS
	-- main component counting CRC sums
	COMPONENT crc8
		PORT (
			clk : IN STD_LOGIC;
			data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			crc_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	-- component delcaration for ROM look-up 
	COMPONENT rom_for_crc8
		PORT (
			address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	END COMPONENT;

	-- clock stuff
	SIGNAL clk : STD_LOGIC := '0';
	-- clock period 
	CONSTANT clk_period : TIME := 20 ns;

	-- CRC generator data
	-- input
	SIGNAL data_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	-- output 
	SIGNAL crc_out : STD_LOGIC_VECTOR(7 DOWNTO 0);

	-- ROM
	-- output data 
	SIGNAL data_out_a0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL data_out_66 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	-- access address
	SIGNAL address : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');

	SIGNAL ok_a0 : STD_LOGIC := '0';
	SIGNAL ok_66 : STD_LOGIC := '0';

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : crc8 PORT MAP(
		clk => clk,
		data_in => data_in,
		crc_out => crc_out
	);

	-- instance of ROM lookup for constant X"a0" input
	rom_a0 : ENTITY work.rom_for_crc8(const_a0)
		PORT MAP(
			address => address,
			data_out => data_out_a0
		);
	-- instance of ROM lookup for constant X"66" input
	rom_66 : ENTITY work.rom_for_crc8(const_66)
		PORT MAP(
			address => address,
			data_out => data_out_66
		);

	-- Clock process definitions
	clk_process : PROCESS
		VARIABLE wait_done : NATURAL := 0;
	BEGIN
		IF wait_done = 0
			THEN
			WAIT FOR clk_period * 0.2;
			wait_done := 1;
		END IF;
		clk <= '1';
		WAIT FOR clk_period/2;
		clk <= '0';
		WAIT FOR clk_period/2;
	END PROCESS;
	-- Stimulus process
	stim_proc : PROCESS
		VARIABLE Xa0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := ('1', '0', '1', '0', '0', '0', '0', '0');
		VARIABLE X66 : STD_LOGIC_VECTOR(7 DOWNTO 0) := ('0', '1', '1', '0', '0', '1', '1', '0');

		VARIABLE zero : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
		VARIABLE address_holder : STD_LOGIC_VECTOR(2 DOWNTO 0) := ('0', '0', '1');
		VARIABLE address_zero : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');

	BEGIN
		data_in <= Xa0;
		WAIT ON clk;

		FOR I IN 0 TO 7 LOOP
			WAIT FOR clk_period;

			address <= address_holder;
			address_holder := STD_LOGIC_VECTOR(unsigned(address_holder) + 1);

		END LOOP;

		--restarting
		data_in <= crc_out;
		WAIT FOR clk_period;

		address_holder := address_zero;
		address <= address_holder;

		data_in <= X66;

		FOR I IN 0 TO 7 LOOP
			address <= address_holder;
			address_holder := STD_LOGIC_VECTOR(unsigned(address_holder) + 1);
			WAIT FOR clk_period;

		END LOOP;

		-- graph flating 
		LOOP
			data_in <= crc_out;
			WAIT FOR clk_period;
		END LOOP;

		WAIT;
	END PROCESS;

	-- Clock process definitions
	ok_process : PROCESS
		VARIABLE ok_a0_v : STD_LOGIC := '0';
		VARIABLE ok_66_v : STD_LOGIC := '0';
		VARIABLE zero : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

		VARIABLE my_line : line;
	BEGIN
		WAIT FOR 100 ps;

		IF crc_out = data_out_a0
			THEN
			ok_a0_v := '1';
		ELSE
			ok_a0_v := '0';
		END IF;

		IF crc_out = data_out_66
			THEN
			ok_66_v := '1';
		ELSE
			ok_66_v := '0';
		END IF;

		ok_a0 <= ok_a0_v;
		ok_66 <= ok_66_v;

		IF crc_out /= zero AND (ok_a0_v /= '1' OR ok_66_v /= '1') and THEN
			write(my_line, STRING'("Hello World")); -- formatting
			writeline(output, my_line);
		END IF;
	END PROCESS;

END;