with Ada.Text_IO;

package body Poly with SPARK_Mode is
   function Horner ( X: Integer; A : Vector) return Integer
   is
      Result : Integer;
   begin
      for Index in reverse Integer range A'First .. A'Last loop
         Ada.Text_IO.Put_Line(Integer'Image(Index));
      end loop;
      return 0;
   end;
end Poly;
