with Graph;
use Graph;
with Ada.Command_line; use Ada.Command_Line;
with Ada.Text_IO;



procedure Main is
   N,D,K : Integer;
begin
   N := Integer'Value((Argument(1)));
   D := Integer'Value((Argument(2)));
   K := Integer'Value((Argument(3)));
   Graph.Simulate(N, D, K);
   Ada.Text_IO.New_Line;
end Main;

