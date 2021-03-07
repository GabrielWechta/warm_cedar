with Linear_Search; use Linear_Search;
with Ada.Text_IO;   use Ada.Text_IO;

procedure Main is
   A   : constant Ar := (0, 0, 1, 1, 3, 4, 5, 8, 8, others => 10);
   B   : constant Ar := (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
   Res : T;
begin
   Res := Search (A, 1);
   Put_Line (T'Image(Res));
   Res := Search (B, 2);
   Put_Line (T'Image(Res));
   Res := Search (A, 6);
   Put_Line (T'Image(Res));
   Res := Search (B, 10);
   Put_Line (T'Image(Res));



end Main;
