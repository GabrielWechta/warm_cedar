with Poly;

procedure Main is
   Var : Integer;
   Arr : Poly.Vector := (3,2,-5,1);
begin
   --  Arr := (3,2,-5,1);
   Var := Poly.Horner(2,Arr);
end Main;
