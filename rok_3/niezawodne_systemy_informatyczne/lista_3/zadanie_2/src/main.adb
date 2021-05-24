with Rev;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   S : String := "Ada ma kota";
begin
   Put_Line (S);
   Rev (S);
   Put_Line (S);
end Main;
