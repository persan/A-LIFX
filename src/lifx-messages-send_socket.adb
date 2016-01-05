with Stream_Tools.Memory_Streams.Send_Socket;
procedure LIFX.Messages.Send_Socket
  (Socket : Socket_Type;
   Item   : LIFX.Messages.Message'Class;
   To     : access Sock_Addr_Type;
   Flags  : Request_Flag_Type := No_Request_Flag)
is
   Buffer            : Ada.Streams.Stream_Element_Array (1 .. 1024);
   S                 : aliased Stream_Tools.Memory_Streams.Memory_Stream;
   Last              : Ada.Streams.Stream_Element_Offset with Unreferenced;
begin
   S.Set_Address (To => Buffer'Address);
   S.Set_Length (To => Buffer'Length);
   LIFX.Messages.Message'Class'Output (S'Access, Item);
   Stream_Tools.Memory_Streams.Send_Socket (Socket, Item => S, Last => Last, To => To, Flags =>  Flags);
end LIFX.Messages.Send_Socket;
