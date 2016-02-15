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
with LIFX.Messages.GetService_Messages;
with LIFX.Messages.Dispatchers;
with Stream_Tools.Memory_Streams;
with LIFX.Messages.Send_Socket;
procedure LIFX.Tests.Applications.Main is

   App : LIFX.Tests.Applications.Test_App;

begin
   LIFX.Messages.Send_Socket
     (App.Server,
      Item => Messages.GetService_Messages.create,
      To => LIFX_Broadcast_Address'Access);

   loop
      begin
         App.S.Reset;
         GNAT.Sockets.Receive_Socket (App.Server, App.Buffer, App.Last, App.From);
         App.S.Set_Length (App.Last);
         LIFX.Messages.Dispatchers.Dispatch_Message (App, LIFX.Messages.Message'Class'Input (App.S'Access));
      exception
         when GNAT.Sockets.Socket_Error =>
            LIFX.Messages.Send_Socket (App.Server, Item => Messages.GetService_Messages.create, To => LIFX_Broadcast_Address'Access);
      end;
   end loop;

end LIFX.Tests.Applications.Main;