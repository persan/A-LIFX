procedure LIFX.Bulb_Emulators.Main is
   App : Bulb_Emulator;

begin
   loop
      App.S.Reset;
      GNAT.Sockets.Receive_Socket (App.Server, App.Buffer, App.Last, App.From);
      App.S.Set_Length (App.Last);
      LIFX.Messages.Dispatchers.Dispatch_Message (App, LIFX.Messages.Message'Class'Input (App.S'Access));
   end loop;
end LIFX.Bulb_Emulators.Main;
