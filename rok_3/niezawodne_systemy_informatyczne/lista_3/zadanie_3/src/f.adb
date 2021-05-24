with Interfaces; use Interfaces;
-- Collatz
function F (X : Unsigned_64) return Unsigned_64 with SPARK_Mode is
   Y : Unsigned_64 := X;
begin
   while Y mod 2 /= 0 loop
      Y := (3 * Y + 1) / 2;
      pragma Loop_Invariant (3 * Y + 1 <= Unsigned_64'Last * 2);
      pragma Loop_Variant (Decreases => Unsigned_64'Last - (3 * Y + 1) / 2);
   end loop;
   return Y / 2;
end F;
