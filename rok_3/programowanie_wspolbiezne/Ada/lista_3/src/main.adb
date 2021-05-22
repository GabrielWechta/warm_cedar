with Graph;
use Graph;
with Ada.Command_line; use Ada.Command_Line;
with Ada.Text_IO;

procedure Main is
   N, D: Integer;

begin
   N := Integer'Value((Argument(1)));
   D := Integer'Value((Argument(2)));

   --  N:= 6;
   --  D:= 2;

   Graph.Simulate(N, D);
   Ada.Text_IO.New_Line;
end Main;
