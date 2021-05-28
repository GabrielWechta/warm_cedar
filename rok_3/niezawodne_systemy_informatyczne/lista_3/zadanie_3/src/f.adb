with Interfaces; use Interfaces;
with Ada.Text_IO; use Ada.Text_IO;

-- Collatz shortcut
function F (X : Unsigned_64) return Unsigned_64 with SPARK_Mode is
   Y       : Unsigned_64 := X;
   Bin_Rep : Unsigned_64 := X with Ghost;
begin
   while Y mod 2 /= 0 loop
      pragma Assert (if Bin_Rep mod 2 /= 0 then Y mod 2 /= 0);

      pragma Loop_Invariant (3 * Y + 1 <= Unsigned_64'Last * 2);

      pragma Loop_Variant (Decreases => Bin_Rep); -- Y - (Y and (Y + 1)), (not Y) and (Y + 1)

      Y := (3 * Y + 1) / 2;
      Bin_Rep := Bin_Rep / 2;

   end loop;
   return Y / 2;
end F;
