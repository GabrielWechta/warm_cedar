with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;

package body Graph is
   
   procedure Simulate(N: in Integer; D: in Integer; K: in Integer) is
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
      
      -- Tasks Part
      task type Node_Thread(Id: Integer) is 
         entry ReceiveAndSend(P: in Integer);
      end Node_Thread;
      
      type NTAR_Type is array (Integer range <>) of access Node_Thread;
      NTAR : NTAR_Type(0..N-1);
      
      task body Node_Thread is
         Empty : Boolean := True;
         Neighbours : Boolean_Array(0..N-1) := (others => False);
      begin
         SetUpNeighbours(Id, Neighbours);
         loop
            begin
               select
                  --  when Empty = True =>
                  accept ReceiveAndSend(P : in Integer) do
                     if Id = N - 1 then
                        Put_Line("pakiet" & Integer'Image(P) & " jest w wierzcholku" & Integer'Image(Id));
                     else
                        delay Get_Task_Delay;
                        Empty := False;
                        Put_Line("pakiet" & Integer'Image(P) & " jest w wierzcholku" & Integer'Image(Id));
                        NTAR(GetNeighbourId(Neighbours)).ReceiveAndSend(P);
                        
                        Empty := True;
                     end if;
                  end ReceiveAndSend;
               or terminate;
               end select;
            end;
         end loop;
         --  end StartBaby;


      end Node_Thread;
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
    
      
      -- Printing array, maybe new package?
      for R in 0 .. N-1 loop
         for C in 0 .. N-1 loop
            Put(Boolean'Image(Connections_Matrix(R)(C)) & " ");
         end loop;
         Put_Line("");
      end loop;
      
      for I in 0..N-1 loop
         NTAR(I):= new Node_Thread(I);
      end loop;

      for I in 1..K loop
         delay Get_Task_Delay;
         NTAR(0).all.ReceiveAndSend(I);
      end loop;
   end Simulate;
end Graph; 
