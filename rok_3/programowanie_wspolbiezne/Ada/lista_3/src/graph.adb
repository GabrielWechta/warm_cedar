with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;
package body graph is

   procedure Simulate(N: in Integer; D: in Integer)
   is
      -- Random Generator Part
      subtype Random_Range is Integer range 1 .. 10e6;
      
      package R is new Ada.Numerics.Discrete_Random (Random_Range);
      use R;
      
      G : Generator;
      
      function Get_Task_Delay return Duration is
         Second_G      : Ada.Numerics.Float_Random.Generator;
         Result : Float;
      begin
         Ada.Numerics.Float_Random.Reset (Second_G);
         Result := Ada.Numerics.Float_Random.Random (Second_G);
         return Duration (Result);
      end Get_Task_Delay;
      --
      
      -- Connection Matrix Part
      type Boolean_Array is array(Integer range<>) of Boolean;
      type Matrix is array(Integer range <>) of Boolean_Array(0..N-1);
      Connections_Matrix : Matrix(0..N-1) := (others => (others => False));
      
      Good_Shortcuts_Number, Start, Target : Integer;
      
      procedure SetUpNeighbours(Task_Id: in Integer; Neighbours: in out Boolean_Array) is
      begin
         Neighbours := Connections_Matrix(Task_Id);
      end SetUpNeighbours;
      --
      
      -- Printer Part
      task Printer is
         entry Print(Node_Id: in Integer; Package_Id: in Integer);
         entry Join;
      end Printer;
      
      task body Printer is
         Node_Prim: Integer;
         Package_Prim: Integer;
      begin 
         loop
            begin 
               select
                  accept Print(Node_Id: in Integer; Package_Id: in Integer) do
                     Node_Prim := Node_Id;
                     Package_Prim := Package_Id;
                  end Print;
                  Put_Line("pakiet" & Integer'Image(Package_Prim) & " jest w wierzcholku" & Integer'Image(Node_Prim));
                  accept Join;
               or 
                  terminate;
               end select;
            end;
         end loop;
      end Printer;
      --
      
      -- Routing Table Part
      type Routing is record
         Next_Hop : Integer;
         Cost : Integer;
         Changed : Boolean;
      end record;
      
      type Routing_Table_Type is array (Natural range <>) of Routing;
      type Routing_Matrix_Type is array (Natural range <>) of Routing_Table_Type(0..N-1);
      Routing_Matrix : Routing_Matrix_Type(0..N-1) := (others => (others => (-1, -1, False)));
      
      procedure Routing_Table_Print(RT: in Routing_Table_Type) is
      begin
         for I in RT'First..RT'Last loop
            Put("(");
            Put(Integer'Image(RT(I).Next_Hop) & ", ");
            PuT(Integer'Image(RT(I).Cost) & ", ");
            Put(Boolean'Image(RT(I).Changed));
            Put("), ");
         end loop;
      end Routing_Table_Print;
      --
      
      -- Pack/Pair Part 
      type Pair is record
         Id : Integer;
         Cost: Integer;
      end record;
      
      type Pack_Type is array (Natural range <>) of Pair;
      
      procedure Pack_Print(Pack: in Pack_Type) is
      begin
         for I in Pack'First..Pack'Last loop
            if Pack(I).Cost /= -1 then
               Put("(" & Integer'Image(Pack(I).Id) & ", ");
               Put(Integer'Image(Pack(I).Cost) & "), ");
            end if;
         end loop;
         New_Line;
      end Pack_Print;
      --
      
      -- Observer Part
      protected type Observer_Type is
         procedure Init(Id: Integer);
         entry ReadChangedPackage(Pack: out Pack_Type);
         entry ReadCost(Id: in Integer; Cost: out Integer);
         entry WriteNewRouting(Id: in Integer; New_Cost: in Integer; Next_Hop: in Integer);
      private
         Busy : Boolean := False;
         Node_Id : Integer;
         --  Changed_Pack : Pack_Type(0..N-1) := (others => (-1, -1));
      end Observer_Type;
      
      protected body Observer_Type is 
         procedure Init(Id: Integer) is
         begin
            Node_Id := Id;
         end Init;
         
         entry ReadChangedPackage(Pack: out Pack_Type)
           when not Busy is
         begin
            Busy := True;
            Put_Line("reading");
            for J in 0..N-1 loop
               if Routing_Matrix(Node_Id)(J).Changed = True then
                  Pack(J).Id := J;
                  Pack(J).Cost := Routing_Matrix(Node_Id)(J).Cost;
                  Routing_Matrix(Node_Id)(J).Changed := False;
               else 
                  Pack(J).Id := -1;
                  Pack(J).Cost := -1;
               end if;
               
            end loop;
            Busy := False;
         end ReadChangedPackage;
         
         entry ReadCost(Id: in Integer; Cost: out Integer) 
           when not Busy is 
         begin
            Busy := True;
            Cost := Routing_Matrix(Node_Id)(Id).Cost;
            Busy := False;
         end ReadCost;
         
         entry WriteNewRouting(Id: in Integer; New_Cost: in Integer; Next_Hop: in Integer)
           when not Busy is
         begin
            Busy := True;
            Routing_Matrix(Node_Id)(Id).Cost := New_Cost;
            Routing_Matrix(Node_Id)(Id).Next_Hop := Next_Hop;
            Routing_Matrix(Node_Id)(Id).Changed := True;
            Busy := False;
         end WriteNewRouting;
      end Observer_Type;
      
      type Observer_Array_Type is array (Integer range <>) of Observer_Type;
      Observer_Array : Observer_Array_Type(0..N-1);
      
      -- Writer Part
      task type Writer_Thread(Id: Integer) is
         entry StartBaby;
         entry Join;
         entry ReceiveAndWrite(Pack: in Pack_Type; From_Who: in Integer);
      end Writer_Thread;
      
      type WTAR_Type is array (Integer range <>) of access Writer_Thread;
      WTAR : WTAR_Type(0..N-1);
      
      task body Writer_Thread is
         My_Pack: Pack_Type(0..N-1);
         Old_Cost : Integer;
         New_Cost : Integer;
         From_Who_Prim : Integer;
      begin
         accept StartBaby;
         loop 
            begin 
               select
                  accept ReceiveAndWrite (Pack: in Pack_Type; From_Who: in Integer) do
                     My_Pack := Pack;
                     From_Who_Prim := From_Who;
                  end ReceiveAndWrite;
                  
                  for J in My_Pack'Range loop
                     Observer_Array(Id).ReadCost(J, Old_Cost);
                     New_Cost := My_Pack(J).Cost + 1;
                     if New_Cost < Old_Cost then
                        Observer_Array(Id).WriteNewRouting(Id       => J,
                                                           New_Cost => New_Cost,
                                                           Next_Hop => From_Who_Prim);
                     end if;
                     
                  end loop;
               or
                  accept Join;
               or
                  terminate;
               end select;
            end;
         end loop;
      end Writer_Thread;
      --
      
      -- Sender Part
      function IsfPackageEmpty (Pack: Pack_Type) return Boolean is
      begin
         for I in Pack'First..Pack'Last loop
            if Pack(I).Id /= -1 then
               return False;
            end if;
         end loop;
         return True;
      end IsfPackageEmpty;
      
      task type Sender_Thread(Id: Integer) is
         entry StartBaby;
         entry Join;
      end Sender_Thread;
      
      type STAR_Type is array (Integer range <>) of access Sender_Thread;
      STAR : STAR_Type(0..N-1);
      
      task body Sender_Thread is
         Neighbours : Boolean_Array(0..N-1) := (others => False);
         Pack: Pack_Type(0..N-1) := (others => (-1, -1));
      begin
         accept StartBaby;
         SetUpNeighbours(Id, Neighbours);
         loop
            begin
               select
                  accept Join;
                  exit;
               or
                  delay Get_Task_Delay * 2;
                  Observer_Array(Id).ReadChangedPackage(Pack);
                  if IsfPackageEmpty(Pack) = False then
                     for I in Neighbours'Range loop
                        if Neighbours(I) = True then
                           WTAR(I).ReceiveAndWrite(Pack, Id);
                        end if;
                     end loop;
                  end if;
               end select;
            end;
         end loop;
      end Sender_Thread;
      --
      
      Obs: Observer_Type;
      Changed_Pack : Pack_Type(0..N-1) := (others => (-1, -1));
      
   begin
      
      -- Initial connections
      for R in 0 .. N-1 loop
         Connections_Matrix(R)((R + 1) mod N) := True;
         Connections_Matrix(R)((R - 1) mod N) := True;
      end loop;
      
      -- Adding shortcuts
      Reset(G);
      Good_Shortcuts_Number := 0;
      while Good_Shortcuts_Number < D loop
         Start := Random(G) mod N;
         Target := Random(G) mod N;
         
         if Start /= Target and Connections_Matrix(Start)(Target) = False then
            Good_Shortcuts_Number := Good_Shortcuts_Number + 1;
            Connections_Matrix(Start)(Target) := True;
            Connections_Matrix(Target)(Start) := True;
         end if;
      end loop;
      
            
      -- Printing Connection_Matrix
      for R in 0 .. N-1 loop
         Put(Integer'Image(R) & " ->");
         for C in 0 .. N-1 loop
            if Connections_Matrix(R)(C) = True then
               Put(Integer'Image(C) & ",");
            end if;
         end loop;
         Put_Line("");
      end loop;
      
      -- Initial routings
      for R in 0..N-1 loop
         for C in 0..N-1 loop
            if R = C then
               Routing_Matrix(R)(C).Cost := -1;
               Routing_Matrix(R)(C).Next_Hop := -1;
               goto Continue; -- where is continue??
            end if;
            
            if Connections_Matrix(R)(C) = True then
               Routing_Matrix(R)(C).Next_Hop := C;
               Routing_Matrix(R)(C).Cost := 1;
            else
               Routing_Matrix(R)(C).Cost := abs(R - C);
               if  R < C then
                  Routing_Matrix(R)(C).Next_Hop := R + 1;
               end if;
               if R > C then
                  Routing_Matrix(R)(C).Next_Hop := R - 1;
               end if;
            end if;
            
            Routing_Matrix(R)(C).Changed := True;
            <<Continue>> -- please don't judge me
         end loop;
      end loop;
      
      -- Printing Routing_Matrix
      for R in 0 .. N-1 loop
         Put(Integer'Image(R) & " ->");
         Routing_Table_Print(Routing_Matrix(R));
         Put_Line("");
      end loop;
      
      Obs.Init(0);
      Obs.WriteNewRouting(1,420,432);

      Obs.ReadChangedPackage(Changed_Pack);
      Pack_Print(Changed_Pack);
      
   end Simulate;
      
end graph;
