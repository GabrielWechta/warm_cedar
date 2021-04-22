with Sqrt_test; use Sqrt_test;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
begin
   Put_Line(Float'Image(Sqrt(4.0, 0.001)));
   Put_Line(Float'Image(Sqrt(9.0, 0.00001)));
   Put_Line(Float'Image(Sqrt(7.0, 0.00001)));

end Main;
