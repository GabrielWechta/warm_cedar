entity logical_layout_tb is 
end logical_layout_tb;

architecture behav of logical_layout_tb is
	component logical_layout port (a, b, c : in bit; x, y : out bit);
	end component;
	
	for logical_layout_0: logical_layout use entity work.logical_layout;
	signal a, b, c, x, y : bit;
	
begin
	logical_layout_0: logical_layout port map (a => a, b => b, c => c, x => x, y => y);
	
	process
		type pattern_type is record
			a, b, c : bit;
			x, y : bit; -- is it necesery? 
		end record;
		type pattern_array is array (natural range <>) of pattern_type;
		
    constant patterns : pattern_array :=
      (('0', '0', '0', '0', '0'),
       ('0', '0', '1', '1', '0'),
       ('0', '1', '0', '0', '0'),
       ('0', '1', '1', '0', '0'),
       ('1', '0', '0', '0', '1'),
       ('1', '0', '1', '0', '0'),
       ('1', '1', '0', '0', '0'),
       ('1', '1', '1', '0', '0'));
    begin
    for i in patterns'range loop
		  a <= patterns(i).a;
		  b <= patterns(i).b;
		  c <= patterns(i).c;
		  wait for 1 ns;
    
      assert x = patterns(i).x
        report "Bad X value" severity error;
      assert y = patterns(i).y
        report "Bad Y value" severity error;
    end loop;
    assert false report "end of test" severity note;
    --  Wait forever; this will finish the simulation.
    wait;
  end process;

end behav;
