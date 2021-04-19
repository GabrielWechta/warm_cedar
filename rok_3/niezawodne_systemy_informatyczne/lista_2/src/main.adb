with primeTest; use primeTest;
with Ada.Text_IO; use Ada.Text_IO;


procedure Main is
   P : Integer := 7;
   N : Integer := 12;
begin
   Put_Line(Boolean'Image(IsPrime(P)));

   Put_Line(Boolean'Image(IsPrime(N)));

end Main;
