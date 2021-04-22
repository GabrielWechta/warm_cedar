package body Sqrt_test with SPARK_Mode is

   function Sqrt (X : Float; Tolerance : Float) return Float 
   is
      R: Float := 1.0;
      H: Float := X;
   begin
      
      while abs(X - R * R) > X * Tolerance loop
         R := (R + H) / 2.0;
         if R >= Float'Model_Epsilon then
            H := X / R;
         end if;
      end loop;
             
      return R;
   end Sqrt;
end Sqrt_test;
