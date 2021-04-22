package Sqrt_test with SPARK_Mode is

   function Sqrt (X : Float; Tolerance : Float) return Float 
     with SPARK_Mode,
     Pre => X >= 0.0 
     and X <= 1.8E19 
     and Tolerance > Float'Model_Epsilon 
     and Tolerance <= 1.0,
     Post => abs (X - Sqrt'Result ** 2) <= X * Tolerance;

end Sqrt_test;
