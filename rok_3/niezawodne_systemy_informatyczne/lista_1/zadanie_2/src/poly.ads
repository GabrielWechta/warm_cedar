package Poly with SPARK_Mode is

   type Vector is array (Natural range<>) of Integer;

   function Horner( X: Integer; A : Vector) return Integer with
     Pre => (for all I in A'Range => A(I) /= 0) and --?
     A'Length > 1;

end Poly;
