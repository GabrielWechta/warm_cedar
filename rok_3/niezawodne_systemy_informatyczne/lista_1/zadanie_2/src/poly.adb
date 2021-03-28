package body Poly with SPARK_Mode is
   function Horner (X : Integer; A : Vector) return Integer is
      Y : Integer := 0;
      Z : Integer := 0 with Ghost;
   begin
      for I in reverse A'Range loop
         Z := Z + A(I) * (X ** (I - A'First));
         Y := Y * X + A(I);

         pragma Loop_Invariant (Z = (X ** (I - A'First)) * Y);
      end loop;

      pragma Assert (Y = Z);

      return Y;
   end Horner;
end Poly;
