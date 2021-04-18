entity logical_layout is 
	-- input: a, b, c.
	-- output: x, y.
	port (a, b, c : in bit; x, y : out bit);
end logical_layout;
	
architecture rtl of logical_layout is
	begin
	x <= not (a or b) nor not ( b nor c );
	y <= not ( b nor c ) and not ( a xor c );
end rtl;
