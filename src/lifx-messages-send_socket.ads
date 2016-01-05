with GNAT.Sockets;
use GNAT.Sockets;
procedure LIFX.Messages.Send_Socket
  (Socket : Socket_Type;
   Item : LIFX.Messages.Message'Class;
   To : access Sock_Addr_Type;
   Flags : Request_Flag_Type := No_Request_Flag);
