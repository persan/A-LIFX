with GNAT.Sockets;
package LIFX is
   LIFX_Port : constant := 56700;
   LIFX_Broadcast_Address : aliased -- constant
   GNAT.Sockets.Sock_Addr_Type :=
     (Family => GNAT.Sockets.Family_Inet, Addr => GNAT.Sockets.Broadcast_Inet_Addr, Port => LIFX_Port);

end LIFX;
