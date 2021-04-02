package body Poly with SPARK_Mode is
   function Horner (X : Integer; A : Vector) return Integer is
      Y : Integer := 0;
      Z : Integer := 0 with Ghost;
   begin
      for I in reverse A'Range loop
         Z := Z + A(I) * (X ** (I - A'First));
         Y := Y * X + A(I);

         pragma Assert (X*X**(I-A'First) = X**(1+I-A'First)); -- really good idea by B. Krolikowski.
         pragma Loop_Invariant (Z = (X ** (I - A'First)) * Y);
      end loop;

      pragma Assert (Y = Z);

      return Y;
   end Horner;
end Poly;
