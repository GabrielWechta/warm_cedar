use std.textio.all;

entity welcome_world is
end welcome_world;

architecture behaviour of welcome_world is
begin
	process
		variable l : line;
	begin
		readline(input, l);
		writeline(output, l);
		wait;
	end process;
end;
