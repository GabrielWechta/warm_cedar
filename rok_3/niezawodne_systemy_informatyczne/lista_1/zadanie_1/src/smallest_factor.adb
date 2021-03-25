procedure Smallest_Factor (N: in out Positive; Factor : out Positive)
  with
    SPARK_Mode,
    Pre => N > 1,
    Post => (Factor > 1) and
  (N'Old / Factor = N) and
  (N'Old rem Factor = 0) and
  (for all J in 2 .. Factor - 1 => N'Old rem J /= 0)
is

begin
   Factor := 1;
   for Index in Positive range 2 .. N loop
      pragma Loop_Invariant (for all J in 2 .. Index - 1 => N rem J /= 0);
      if N rem Index = 0 then
         Factor := Index;
         N := N / Factor;
         exit;
      end if;
   end loop;
end Smallest_Factor;
