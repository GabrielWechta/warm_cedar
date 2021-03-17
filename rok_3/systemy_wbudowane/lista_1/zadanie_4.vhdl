entity logical_layout is 
	-- input: a, b, c.
	-- output: x, y.
	port (a, b, c : in bit; x, y : out bit);
end logical_layout;
	
architecture rtl of logical_layout is
	begin
	x <= (a or b) nor ( b nor c );
	y <= ( b nor c ) and ( a xor c );
end rtl;
