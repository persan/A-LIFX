with Stream_Tools.Memory_Streams.Send_Socket;
with GNAT.Source_Info;
with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Time_Stamp;
procedure LIFX.Messages.Send_Socket
  (Socket : Socket_Type;
   Item   : LIFX.Messages.Message'Class;
   To     : access Sock_Addr_Type;
   Flags  : Request_Flag_Type := No_Request_Flag) is
   Buffer : Ada.Streams.Stream_Element_Array (1 .. 1024);
   S      : aliased Stream_Tools.Memory_Streams.Memory_Stream;
   Last   : Ada.Streams.Stream_Element_Offset with
      Unreferenced;
   procedure Log
     (Message  : LIFX.Messages.Message'Class;
      Location : String := GNAT.Source_Info.Enclosing_Entity) is
   begin
      New_Line;
      Put_Line (GNAT.Time_Stamp.Current_Time & " : " & GNAT.Sockets.Image (To.Addr) & ":" & To.Port'Img & ":" & Location);
      Put_Line (Message.Image);
   end;

begin
   Log (Item, GNAT.Source_Info.Enclosing_Entity);
   S.Set_Address (To => Buffer'Address);
   S.Set_Length (To => Buffer'Length);
   LIFX.Messages.Message'Class'Output (S'Access, Item);
   Stream_Tools.Memory_Streams.Send_Socket (Socket, Item => S, Last => Last, To => To, Flags => Flags);
end LIFX.Messages.Send_Socket;
