with Graph;
use Graph;
with Ada.Command_line; use Ada.Command_Line;
with Ada.Text_IO;



procedure Main is
   N, D, B, K, H : Integer;
begin
   N := Integer'Value((Argument(1)));
   D := Integer'Value((Argument(2)));
   B := Integer'Value((Argument(3)));
   K := Integer'Value((Argument(4)));
   H := Integer'Value((Argument(5)));
   --  N:= 10;
   --  D:= 5;
   --  B:= 7;
   --  K:= 8;
   --  H:= 5;

   Graph.Simulate(N, D, B, K, H);
   Ada.Text_IO.New_Line;
end Main;

