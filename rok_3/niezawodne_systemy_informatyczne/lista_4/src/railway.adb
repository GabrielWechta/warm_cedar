package body Railway with SPARK_Mode is
-- 0 - entry left; 1 - left; 2 - middle; 3 - right; 4 - entry right
   
   procedure Open_Route (Route : in Route_Type; Success : out Boolean)
   is
   begin
      -- 0 ^~^ 1
      if Route = Route_Enter_Left and Segment_State.Left = Free then
         Segment_State.Left := Reserved_Moving_From_Left;
         Success := True;
         
         -- 1 ^~^ 2
      elsif Route = Route_Left_Middle and Segment_State.Left = Occupied_Standing and Segment_State.Middle = Free then
         Segment_State.Left := Occupied_Moving_Right;
         Segment_State.Middle := Reserved_Moving_From_Left;
         Signal_State.Left_Middle := Green;
         Success := True;
         
         -- 2 ^~^ 3
      elsif Route = Route_Middle_Right and Segment_State.Middle = Occupied_Standing and Segment_State.Right = Free then
         Segment_State.Middle := Occupied_Moving_Right;
         Segment_State.Right := Reserved_Moving_From_Left;
         Signal_State.Middle_Right := Green;
         Success := True;
         
         -- 3 ^~^ 4
      elsif Route = Route_Leave_Right and Segment_State.Right = Occupied_Standing then
         Segment_State.Right := Occupied_Moving_Right;
         Success := True;
         
         -- 4 ^~^ 3
      elsif Route = Route_Enter_Right and Segment_State.Right = Free then
         Segment_State.Right := Reserved_Moving_From_Right;
         Success := True;
         
         -- 3 ^~^ 2
      elsif Route = Route_Right_Middle and Segment_State.Right = Occupied_Standing and Segment_State.Middle = Free then
         Segment_State.Right := Occupied_Moving_Left;
         Segment_State.Middle := Reserved_Moving_From_Right;
         Signal_State.Right_Middle := Green;
         Success := True;
         
         -- 2 ^~^ 1
      elsif Route = Route_Middle_Left and Segment_State.Middle = Occupied_Standing and Segment_State.Left = Free then
         Segment_State.Middle := Occupied_Moving_Left;
         Segment_State.Left := Reserved_Moving_From_Right;
         Signal_State.Middle_Left := Green;
         Success := True;
         
         -- 1 ^~^ 0
      elsif Route = Route_Leave_Left and Segment_State.Left = Occupied_Standing then
         Segment_State.Left := Occupied_Moving_Left;
         Success := True;
        
      else
         Success := False;
      end if;   
   end Open_Route;
   
   procedure Move_Train (Route : in Route_Type; Success : out Boolean)
   is
   begin
      -- 0 -> 1
      if Route = Route_Enter_Left and Segment_State.Left = Reserved_Moving_From_Left then
         Segment_State.Left := Occupied_Standing;
         Success := True;
         
         -- 1 -> 2
      elsif Route = Route_Left_Middle and Segment_State.Left = Occupied_Moving_Right and Segment_State.Middle = Reserved_Moving_From_Left then  
         Signal_State.Left_Middle := Red;
         Segment_State.Left := Free;
         Segment_State.Middle := Occupied_Standing;
         Success := True;
         
         -- 2 -> 3
      elsif Route = Route_Middle_Right and Segment_State.Middle = Occupied_Moving_Right and Segment_State.Right = Reserved_Moving_From_Left then
         Signal_State.Middle_Right := Red;
         Segment_State.Middle := Free;
         Segment_State.Right := Occupied_Standing;
         Success := True;
         
         -- 3 -> 4
      elsif Route = Route_Leave_Right and 
      Segment_State.Right = Occupied_Moving_Right then
         
         Segment_State.Right := Free;
         Success := True;
         
         -- 4 -> 3
      elsif Route = Route_Enter_Right and Segment_State.Right = Reserved_Moving_From_Right then
         Segment_State.Right := Occupied_Standing;
         Success := True;
         
         -- 3 -> 2
      elsif Route = Route_Right_Middle and Segment_State.Right = Occupied_Moving_Left and Segment_State.Middle = Reserved_Moving_From_Right then
         Signal_State.Right_Middle := Red;
         Segment_State.Right := Free;
         Segment_State.Middle := Occupied_Standing;
         Success := True;
         
         -- 2 -> 1
      elsif Route = Route_Middle_Left and Segment_State.Middle = Occupied_Moving_Left and Segment_State.Left = Reserved_Moving_From_Right then
         Signal_State.Middle_Left := Red;
         Segment_State.Middle := Free;
         Segment_State.Left := Occupied_Standing;
         Success := True;
         
         -- 1 -> 0
      elsif Route = Route_Leave_Left and Segment_State.Left = Occupied_Moving_Left then
         Segment_State.Left := Free;
         Success := True;
         
      else
         Success := False;
      end if; 
   end Move_Train;
end Railway;
