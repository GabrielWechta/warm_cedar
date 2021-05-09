with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;

package body Graph is
   
   procedure Simulate(N: in Integer; D: in Integer; B: in Integer; K: in Integer; H: in Integer) is
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
      
      Good_Shortcuts_Number, Good_Reverse_Shorcuts_Number, Start, Target : Integer;
      
      procedure SetUpNeighbours(Task_Id: in Integer; Neighbours: in out Boolean_Array) is
      begin
         Neighbours := Connections_Matrix(Task_Id);
      end SetUpNeighbours;
      
      function GetNeighbourId(Neighbours: Boolean_Array) return Integer is
         Target_Id: Integer;
         Skips_Counter: Integer := Random(G) mod (N-1) + 1;
         I: Integer := 0;
      begin
         while Skips_Counter > 0 loop 
            if Neighbours(I) = True then
               Skips_Counter := Skips_Counter - 1;
               Target_Id := I;
            end if;
            I := (I + 1) mod N;
         end loop;
         return Target_Id;
      end GetNeighbourId; 
      --
      
      -- Printer Part
      task Printer is
         entry Print(Node_Id: in Integer; Package_Id: in Integer);
         entry Final_Print(Package_Id: in Integer);
         entry Death_Print(Node_Id: in Integer; Package_Id: in Integer);
         entry Trap_Print(Node_Id: in Integer; Package_Id: in Integer);
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
               or accept Final_Print (Package_Id : in Integer) do
                     Package_Prim := Package_Id;
                  end Final_Print;
                  Put_Line("pakiet" & Integer'Image(Package_Prim) & " zostal odebrany");
               or accept Death_Print (Node_Id: in Integer; Package_Id : in Integer) do
                     Node_Prim := Node_Id;
                     Package_Prim := Package_Id;
                  end Death_Print;
                  Put_Line("pakiet" & Integer'Image(Package_Prim) & " zmarl w wierzcholku" & Integer'Image(Node_Prim));
               or accept Trap_Print (Node_Id: in Integer; Package_Id : in Integer) do
                     Node_Prim := Node_Id;
                     Package_Prim := Package_Id;
                  end Trap_Print;
                  Put_Line("pakiet" & Integer'Image(Package_Prim) & " zostal zlapany w" & Integer'Image(Node_Prim));
               or 
                  accept Join;
               or 
                  terminate;
               end select;
            end;
         end loop;
      end Printer;
      --
      
      -- Keepers Part
      type Integer_Array is array (Integer range <>) of Integer;
      
      type Node_Keeper_Type is array (Integer range <>) of Integer_Array(0..K-1);
      Node_Keeper : Node_Keeper_Type(0..N-1) := (others => (others => -1));
      
      type Package_Keeper_Type is array (Integer range <>) of Integer_Array(0..N-1);
      Package_Keeper : Package_Keeper_Type(1..K) := (others => (others => -1));
      
      Package_Live_Array : Integer_Array(1..K) := (others => H); 
      
      procedure AddNodeToPackageRoute(Package_Id: in Integer; Node_Id: in Integer) is 
      begin
         for I in 0..N-1 loop
            if Package_Keeper(Package_Id)(I) = -1 then
               Package_Keeper(Package_Id)(I) := Node_Id;
               exit;
            end if;
         end loop;
      end AddNodeToPackageRoute;
      
      function TakeLiveFromPackage (Package_Id: in Integer) return Boolean is 
         -- returns True if package is still alive, False if it has died
      begin
         Package_Live_Array(Package_Id) := Package_Live_Array(Package_Id) - 1;
         
         if Package_Live_Array(Package_Id) <= 0 then
            return False; 
         end if;
         
         return True;
      end TakeLiveFromPackage;
      --
     
      -- Node Tasks Part
      task type Node_Thread(Id: Integer) is 
         entry StartBaby;
         entry ReceiveAndSend(P: in Integer);
         entry SetUpTrap;
         entry Join;
      end Node_Thread;
      
      type NTAR_Type is array (Integer range <>) of access Node_Thread;
      NTAR : NTAR_Type(0..N-1);
      
      task body Node_Thread is
         Neighbours : Boolean_Array(0..N-1) := (others => False);
         P_Prim : Integer;
         Visited_Packages_Number : Integer := 0;
         Trapped : Boolean := False;
      begin 
         accept StartBaby;
         SetUpNeighbours(Id, Neighbours);
         loop
            begin
               select
                  accept ReceiveAndSend(P : in Integer) do
                     P_Prim := P;
                  end ReceiveAndSend;
                  
                  Node_Keeper(Id)(Visited_Packages_Number) := P_Prim;
                  Visited_Packages_Number := Visited_Packages_Number + 1;
                  AddNodeToPackageRoute(P_Prim, Id);
                  
                  if Trapped = False then
                     if TakeLiveFromPackage(P_Prim) = False then
                        Printer.Death_Print(Id, P_Prim);
                     else
                        if Id = N - 1 then
                           Printer.Final_Print(P_Prim);
                        else
                           delay Get_Task_Delay;
                           Printer.Print(Id, P_Prim);

                           NTAR(GetNeighbourId(Neighbours)).ReceiveAndSend(P_Prim);
                        end if;
                     end if;
                  else
                     Printer.Trap_Print(Id, P_Prim);
                     Trapped := False;
                  end if;
               or 
                  accept SetUpTrap do
                     Trapped := True;
                  end SetUpTrap;
               or 
                  accept Join;
               or 
                  terminate;
               end select;
            end;
         end loop;
      end Node_Thread;
      
      -- Poacher Part
      task type Poacher_Thread is
         entry BeginHunt;
         entry Join;
      end Poacher_Thread;
      
      task body Poacher_Thread is 
         Target : Integer := 0;
      begin
         accept BeginHunt;
         Reset(G);
         loop
            begin
               select
                  accept Join;
                  exit;
               or 
                  delay Get_Task_Delay * 2;

                  Target := Random(G) mod (N-2) + 1;
                  NTAR(Target).SetUpTrap;
                  
               end select;
            end;
         end loop;
      end Poacher_Thread;
      
      Poacher : Poacher_Thread; -- Poacher will wait for BeginHunt
      --
      
   begin
      -- Initial connections
      for R in 0 .. N-2 loop
         Connections_Matrix(R)(R + 1) := True;
      end loop;
      
      -- Adding shortcuts
      Reset(G);
      Good_Shortcuts_Number := 0;
      while Good_Shortcuts_Number < D loop
         Start := Random(G) mod (N-2);
         Target := Random(G) mod N;
         
         if Start < Target and Connections_Matrix(Start)(Target) = False then
            Good_Shortcuts_Number := Good_Shortcuts_Number + 1;
            Connections_Matrix(Start)(Target) := True;
         end if;
      end loop;
      
      -- Adding reverse shorcuts
      Reset(G);
      Good_Reverse_Shorcuts_Number := 0;
      while Good_Reverse_Shorcuts_Number < B loop
         Start := Random(G) mod (N-2) + 1;
         Target := Random(G) mod (N-2) + 1;
         
         if Start < Target and Connections_Matrix(Target)(Start) = False then
            Good_Reverse_Shorcuts_Number := Good_Reverse_Shorcuts_Number + 1;
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

      
      -- Initializing, but tasks keep waiting
      for I in 0..N-1 loop
         NTAR(I):= new Node_Thread(I);
      end loop;

      -- Starting Node Tasks
      for I in 0..N-1 loop
         NTAR(I).all.StartBaby;
      end loop;
      
      -- Starting Poacher
      Poacher.BeginHunt;

      -- Sending to Source
      for I in 1..K loop
         delay Get_Task_Delay;
         NTAR(0).all.ReceiveAndSend(I);
      end loop;
      
      -- Joining Nodes Tasks
      for I in 0..N-1 loop
         NTAR(I).all.Join;
      end loop;
      
      -- Joining Printer and Poacher
      Printer.Join;
      Poacher.Join;
      
      -- Printing Node_Keeper
      New_Line;
      for R in 0 .. N-1 loop
         Put("W" & Integer'Image(R) & " byly");
         for C in 0 .. K-1 loop
            if Node_Keeper(R)(C) /= -1 then
               Put(Integer'Image(Node_Keeper(R)(C)) & ",");
            end if;
         end loop;
         Put_Line("");
      end loop;
      
      -- Printing Package_Keeper
      New_Line;
      for R in 1 .. K loop
         Put(Integer'Image(R) & " byl w");
         for C in 0 .. N-1 loop
            if Package_Keeper(R)(C) /= -1 then
               Put(Integer'Image(Package_Keeper(R)(C)) & ",");
            end if;
         end loop;
         Put_Line("");
      end loop;
      
   end Simulate;
      
end Graph; 
