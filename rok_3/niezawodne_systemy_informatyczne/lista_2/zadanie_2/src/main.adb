with Max2; use Max2;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   My_Vector : Vector(0..10) := (0 => 2, others => 1);
begin
   Put_Line(Integer'Image(FindMax2(My_Vector)));
end Main;
