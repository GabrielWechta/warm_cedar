with Selection;
with Ada.Text_IO;

procedure Main is
   A : Selection.Arr := (5,2,3,1,5);
begin
   Selection.Sort(A);
   for I in A'Range loop
      Ada.Text_IO.Put (Integer'Image (A (I)) & " ");
   end loop;
end Main;
