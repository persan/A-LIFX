with GNAT.Sockets;use GNAT.Sockets;
procedure Stream_Tools.Memory_Streams.Send_Socket
     (Socket : Socket_Type;
      Item   : Memory_stream;
      Last   : out Ada.Streams.Stream_Element_Offset;
      To     : access Sock_Addr_Type;
      Flags  : Request_Flag_Type := No_Request_Flag);
