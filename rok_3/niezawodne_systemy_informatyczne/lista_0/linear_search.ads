package Linear_Search
   with SPARK_Mode
is
   type T is range 0..10;
   subtype U is T range 1..10;

   type Ar is array (U) of Integer;

   function Search (My_Array : Ar; My_Index : Integer) return T with
     Post => (if Search'Result in My_Array'Range
                then A (Search'Result) = I
              else (for all Index in My_Array'Range => A (Index) /= I));

end Linear_Search;
