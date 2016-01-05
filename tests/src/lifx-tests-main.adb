with Ada.Exceptions;
with GNAT.IO; use GNAT.IO;
with GNAT.Sockets;
with GNAT.Time_Stamp;
with GNAT.Traceback.Symbolic;
with LIFX.Messages.GetService_Messages;
with LIFX.Messages.Dispatchers;
with Stream_Tools.Memory_Streams;
with GNAT.Memory_Dump;
with LIFX.Tests.Applications;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with LIFX.Messages.Send_Socket;
procedure LIFX.Tests.Main is

   App : LIFX.Tests.Applications.Test_App;

   task Reader is
      entry Start;
      entry Stop;
   end Reader;

   task body Reader is
   begin
      accept Start;
      LIFX.Messages.Send_Socket
        (App.Server, Item => Messages.GetService_Messages.create, To => LIFX_Broadcast_Address'Access);

      begin
         loop
            begin
               App.S.Reset;
               GNAT.Sockets.Receive_Socket (App.Server, App.Buffer, App.Last, App.From);
               App.S.Set_Length (App.Last);
               LIFX.Messages.Dispatchers.Dispatch_Message (App, LIFX.Messages.Message'Class'Input (App.S'Access));
            exception
               when GNAT.Sockets.Socket_Error =>
                  LIFX.Messages.Send_Socket (App.Server, Item => Messages.GetService_Messages.create, To => LIFX_Broadcast_Address'Access);
               when E : others =>
                  Put_Line (80 * '=');
                  Put_Line (GNAT.Time_Stamp.Current_Time & " : " & GNAT.Sockets.Image (App.From) & " : " & Ada.Exceptions.Exception_Information (E) &
                              GNAT.Traceback.Symbolic.Symbolic_Traceback (E));
                  GNAT.Memory_Dump.Dump (App.S.Get_Address, Integer (App.S.Get_Length), Prefix => GNAT.Memory_Dump.Offset);
                  Put_Line (80 * "-");
            end;
         end loop;
      exception
         when others =>
            null;
      end;
      accept Stop;
   end;

begin
--     GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
--     GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback'Access);
   App.Initialize;
   Reader.Start;
   Reader.Stop;
end LIFX.Tests.Main;
