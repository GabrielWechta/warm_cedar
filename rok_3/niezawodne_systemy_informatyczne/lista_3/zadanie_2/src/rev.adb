with Ada.Text_IO; use Ada.Text_IO;

procedure Rev (S : in out String)
with SPARK_Mode,
Pre => S'First < Positive'Last / 2 and S'Last < Positive'Last / 2,
Post => (for all I in S'Range => S (I) = S'Old (S'First + S'Last - I))
is 
   Holder : String (S'Range) := S;
begin
   for I in S'Range loop
      Holder (I) := S (S'First + S'Last - I);
      pragma Loop_Invariant (for all J in S'First .. I => Holder (J) = S (S'First + S'Last - J));
   end loop;
   
   S := Holder;
end Rev;
