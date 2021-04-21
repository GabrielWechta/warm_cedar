package body Max2 with SPARK_Mode is
   function FindMax2 (V : Vector) return Integer
   is
      Max : Integer := 0;
      Second : Integer := 0;
   begin
      for I in V'Range loop
         if V(I) > Max then
            Second := Max;
            Max := V(I);
         elsif V(I) > Second and V(I) < Max then
            Second := V(I);
         end if;
         pragma Loop_Invariant (Second < Max); -- simple
         pragma Loop_Invariant (Second >= 0); -- simple also
         pragma Loop_Invariant (for some J in V'First .. I => V(J) = Max); -- even when V'Length = 1

         pragma Loop_Invariant (if Second /= 0 then (for some J in V'First .. I => V(J) > Second)); -- if Second /= 0 then also Max /= 0, which means that program was in if at least two times
         
         -- this monster means: A OR B
         -- A: Second = V(J) for some J AND for every J if Second < V(J) then for every K V(K) < V(J), which means that if Second was changed 
         -- then every value E in V is smaller or equal to V(J).
         -- B: if Second = 0 then all values in V are equal.
         pragma Loop_Invariant (((for some J in V'First .. I => V(J) = Second) and
                                  (for all J in V'First .. I => (if V(J) > Second then
                                                                   (for all K in V'First .. I => V(K) <= V(J)))))
                                or
                                  (Second = 0 and (for all J in V'First .. I => V(J) = Max)));
         
      end loop;
      return Second;
   end FindMax2;
end Max2;
