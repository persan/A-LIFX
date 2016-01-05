procedure Stream_Tools.Memory_Streams.Send_Socket
  (Socket :     Socket_Type;
   Item   :     Memory_Stream;
   Last   : out Ada.Streams.Stream_Element_Offset;
   To     :     access Sock_Addr_Type;
   Flags  :     Request_Flag_Type := No_Request_Flag) is
   use type Ada.Streams.Stream_Element_Offset;
begin
   GNAT.Sockets.Send_Socket
     (Socket => Socket,
      Item   => Item.Buffer.As_Pointer.all (Item.Buffer.As_Pointer.all'First .. Item.Cursor - 1),
      Last   => Last,
      To     => To,
      Flags  => Flags);
end Stream_Tools.Memory_Streams.Send_Socket;
