package primeTest with SPARK_Mode is

   function IsPrime (N: in Positive) return Boolean with 
     SPARK_Mode,
     Pre => N >= 2,
     Post => (if IsPrime'Result then (for all I in 2 .. N - 1 => N rem I /= 0)
                  else 
                (for some I in 2 .. N - 1 => N rem I = 0));
end primeTest;
