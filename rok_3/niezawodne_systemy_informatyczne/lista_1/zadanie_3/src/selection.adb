package body Selection with SPARK_Mode is
   procedure Sort (A : in out Arr) is
      Min : Integer;
      Temp : Integer;

   begin
      for I in A'First .. A'Last - 1 loop
         Min := I;

         for J in I .. A'Last loop
            pragma Loop_Invariant(Min in I .. A'Last);
            pragma Loop_Invariant(for all K in I .. J - 1 => A(Min) <= A(K));

            if A(Min) > A(J) then
               Min := J;
            end if;

         end loop;

         if Min /= I then
            Temp := A(I);
            A(I) := A(Min);
            A(Min) := Temp;
         end if;

         pragma Loop_Invariant(for all E in A'First .. I  => (for all L in E + 1 .. A'Last => A(E) <= A(L)));
      end loop;
   end Sort;
end Selection;
