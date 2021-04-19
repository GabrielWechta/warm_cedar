package body primeTest with SPARK_Mode is
   function IsPrime (N: in Positive) return Boolean
   is
   begin
      for Divisor in 2 .. N - 1 loop
         pragma Loop_Invariant(for all E in 2 .. Divisor - 1 => N rem E /= 0);
         if N rem Divisor = 0 then
            return False;
         end if;
      end loop;
      
      return true;
      
   end IsPrime;
end primeTest;
