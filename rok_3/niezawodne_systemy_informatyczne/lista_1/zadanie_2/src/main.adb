with Ada.Text_IO;
with Poly;

procedure Main is
   Var : Integer;
   Arr : Poly.Vector := (0 => 0);
begin
   --  Arr := (3,2,-5,1);
   Var := Poly.Horner(-1,Arr);
   Ada.Text_IO.Put_Line(Integer'Image(Var));
end Main;
