package body mult_6502 with SPARK_Mode is

   function Mult (A : Natural; B : Natural) return Natural
   is 
      AB : Natural := 0;
      AA : Natural := A;
      B1 : Natural := B;
   begin
      while B1 > 0 loop
         if B1 mod 2 = 1 then
            AB := AB + AA;
         end if;
         AA := 2 * AA;
         B1 := B1 / 2;
         pragma Loop_Invariant (A * B = AA * B1 + AB);

      end loop;
      return AB;
   end Mult;

end mult_6502;
