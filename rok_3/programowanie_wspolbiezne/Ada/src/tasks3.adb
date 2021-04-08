with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Random_Seeds; use Random_Seeds;

procedure Tasks3 is
   Nr_Of_Tasks : constant Integer :=5; -- liczba tasków do uruchomienia
   Seeds : Seed_Array_Type(1..Nr_Of_Tasks) := Make_Seeds(Nr_Of_Tasks);
   
   task type SimpleTask_Type(Id: Integer; Seed: Integer );
   task body SimpleTask_Type is
      G : Generator;
   begin
      Reset(G, Seed); 
      loop
         delay 0.1+Duration(3.0*Random(G));
         Put_Line ("Task " & Integer'Image(Id));
      end loop;
   end SimpleTask_Type;

   type TasksArray_Type is array ( Positive range <>) of access SimpleTask_Type;
   type TA_Access_Type is access TasksArray_Type;

   function Init_TasksArray( Size: integer ) return TA_Access_Type is
      TA_Ptr: TA_Access_Type ;
   begin
      TA_Ptr := new TasksArray_Type( 1 .. Size);
      for I in TA_Ptr.all'Range loop
         TA_Ptr.all(I) := new SimpleTask_Type(I, Seeds(I));
      end loop;
      return TA_Ptr;
   end;

   TasksArray: TasksArray_Type := Init_TasksArray(Nr_Of_Tasks).all ;
   
   ---------$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$------------
   
   package Integer_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Natural,
      Element_Type => Natural);

   use Integer_Vectors;
   
   Nr_Of_Tasks : constant Integer := 5;
   Seeds : Seed_Array_Type(1..Nr_Of_Tasks) := Make_Seeds(Nr_Of_Tasks);
   
   type Neighbours_Array_Type is array (1..Nr_Of_Tasks) of Boolean;
      
   type Nodes_Access_Array_Type is array ( Positive range <>) of access Node_Type;
   type Graph_Type is access Nodes_Access_Array_Type;
   
      
   task type Node_Type(Id: Integer; Seed: Integer; Links: Neighbours_Array_Type) is
      entry ListenAndSend(N : Integer);
   end Node_Type;
   

   task body Node_Type is
      Empty : Boolean := True;
      Links : Vector;
      G : Generator;
   begin
      Reset(G, Seed);
      for E of Links loop
         Put_Line ("- " & Integer'Image (E));
      end loop;
      loop
         delay 0.1+Duration(3.0*Random(G));
         Put_Line ("Listening " & Integer'Image(Id));
        
         select
            when Empty = True or Empty = False =>
            accept ListenAndSend (N : in Integer) do
               Put_Line(Integer'Image(Id) & " Got");
               Empty := False;
            end ListenAndSend;
         or
            when Empty = True =>
               terminate;
         end select;
      end loop;
   end Node_Type;

   
   function Init_Graph(Size: Integer) return Graph_Type is
      Graph_Ptr: Graph_Type;
      N: Neighbours_Array_Type;
   begin
      Graph_Ptr := new Nodes_Access_Array_Type(1..Size);
      for I in Graph_Ptr.all'Range loop
         N := (others => False);
         Graph_Ptr.all(I) := new Node_Type(I, Seeds(I), N);
      end loop;
      return Graph_Ptr;
   end;

      
   Graph: Nodes_Access_Array_Type := Init_Graph(Nr_Of_Tasks).all;
   
   

begin
   null;
end Tasks3;
