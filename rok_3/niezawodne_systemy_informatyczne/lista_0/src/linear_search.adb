package body Linear_Search
with SPARK_Mode
is

   function Search (A : Ar; I : Integer) return T is
      Point : U;
      Right : U;
   begin
      Point := Ar'First;
      Right := Ar'Last;

      while Point <= Right loop
         pragma Loop_Invariant
           (for all Index in A'First .. Point - 1 => A (Index) /= I);

         if A (Point) = I then
            return Point;
         elsif Point = Right then
            return 0;
         else
            Point := Point + 1;
         end if;

      end loop;

      return 0;
   end Search;

end Linear_Search;
