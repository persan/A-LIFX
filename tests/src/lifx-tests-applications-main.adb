------------------------------------------------------------------------------
--                                                                          --
--                   A-LIFX An Ada interface to the LIFX-BULBS              --
--                                                                          --
--                                                                          --
--                                                                          --
--                     Copyright (C) 2016 Per Sandberg                      --
--                                                                          --
--  This library is free software;  you can redistribute it and/or modify   --
--  it under terms of the  GNU General Public License  as published by the  --
--  Free Software  Foundation;  either version 3,  or (at your  option) any --
--  later version. This library is distributed in the hope that it will be  --
--  useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                    --
--                                                                          --
--  As a special exception under Section 7 of GPL version 3, you are        --
--  granted additional permissions described in the GCC Runtime Library     --
--  Exception, version 3.1, as published by the Free Software Foundation.   --
--                                                                          --
--  You should have received a copy of the GNU General Public License and   --
--  a copy of the GCC Runtime Library Exception along with this program;    --
--  see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see   --
--  <http://www.gnu.org/licenses/>.                                         --
--                                                                          --
--  As a special exception, if other files instantiate generics from this   --
--  unit, or you link this unit with other files to produce an executable,  --
--  this  unit  does not  by itself cause  the resulting executable to be   --
--  covered by the GNU General Public License. This exception does not      --
--  however invalidate any other reasons why the executable file  might be  --
--  covered by the  GNU Public License.                                     --
--                                                                          --
--                                                                          --
------------------------------------------------------------------------------

with GNAT.Sockets;

with LIFX.Messages.Dispatchers;
with LIFX.Messages.GetService_Messages;
with LIFX.Messages.Send_Socket;
with LIFX.Bulbs;
with Stream_Tools.Memory_Streams;
with GNAT.Traceback.Symbolic;
with GNAT.Exception_Traces;
with Ada.Text_IO; use Ada.Text_IO;

procedure LIFX.Tests.Applications.Main is
   use  GNAT.Sockets;
   Server            : GNAT.Sockets.Socket_Type;
   Buffer            : Ada.Streams.Stream_Element_Array (1 .. 1024);
   S                 : aliased Stream_Tools.Memory_Streams.Memory_Stream;
   Last              : Ada.Streams.Stream_Element_Offset;
   Addr              : GNAT.Sockets.Sock_Addr_Type;

   Count             : Natural := 0;
   Store             : LIFX.Bulbs.Map;
begin
   S.Set_Address (Buffer'Address);
   S.Set_Length (Buffer'Length);
   Store.From := GNAT.Sockets.No_Sock_Addr;
   Addr.Addr := Any_Inet_Addr;
   Addr.Port := LIFX_Port;
      --        Self.Addr.Port := Any_Port;
   Create_Socket (Server, Family_Inet, Socket_Datagram);
   Set_Socket_Option (Server, Option => (Reuse_Address, Enabled => True));
   Set_Socket_Option (Server, Option => (Broadcast, Enabled => True));
   Set_Socket_Option (Server, Option => (Receive_Timeout, Timeout => 2.0));
   Bind_Socket (Server, Addr);

   GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
   GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback'Access);
   LIFX.Messages.Send_Socket
     (Server,
      Item => Messages.GetService_Messages.Create,
      To => LIFX_Broadcast_Address'Access);

   loop
      begin
         S.Reset;
         GNAT.Sockets.Receive_Socket (Server, Buffer, Last, Store.From);
         S.Set_Length (Last);
         LIFX.Messages.Dispatchers.Dispatch_Message (Store, LIFX.Messages.Message'Class'Input (S'Access));
         Count := Count + 1;
         if Count > 100 then
            Count := 0;
--              Put_Line (Item => Bulb_Store.Images.Image (Store));
         end if;
      exception
         when GNAT.Sockets.Socket_Error =>
            LIFX.Messages.Send_Socket (Server, Item => Messages.GetService_Messages.Create, To => LIFX_Broadcast_Address'Access);
            Put_Line ("===========================================================================");
            --  Put_Line (Item => Bulb_Store.Images.Image (Bulb_Store.Store));
      end;
   end loop;

end LIFX.Tests.Applications.Main;
