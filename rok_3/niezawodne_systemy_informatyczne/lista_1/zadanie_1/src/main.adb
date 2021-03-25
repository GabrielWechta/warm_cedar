with Smallest_Factor;
with Ada.Text_IO;

procedure Main is
   X : Positive;
   F : Positive;
begin
   X := 6;
   Smallest_Factor(X, F);
   Ada.Text_IO.Put_Line(Positive'Image(F));
end Main;
