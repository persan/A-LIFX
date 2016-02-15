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
