with Ada.Text_IO; use Ada.Text_IO;
with LIFX.Messages.Lights.Get_Messages;
with LIFX.Messages.GetGroup_Messages;
with GNAT.Time_Stamp;
with LIFX.Messages.GetLocation_Messages;
with LIFX.Messages.GetHostFirmware_Messages;
with LIFX.Messages.Send_Socket;
with LIFX.Messages.Lights.SetPower_Messages;
with LIFX.Messages.GetWifiFirmware_Messages;
with LIFX.Messages.GetWifiInfo_Messages;

package body LIFX.Tests.Applications is
   use GNAT.Sockets;
   use LIFX.Messages;
   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in  out Test_App) is
   begin
      Self.From := GNAT.Sockets.No_Sock_Addr;
      Self.Addr.Addr := Any_Inet_Addr;
      Self.Addr.Port := LIFX.LIFX_Port;
      Create_Socket (Self.Server, Family_Inet, Socket_Datagram);
      Set_Socket_Option (Self.Server, Option => (Reuse_Address, Enabled => True));
      Set_Socket_Option (Self.Server, Option => (Broadcast, Enabled => True));
      Set_Socket_Option (Self.Server, Option => (Receive_Timeout, Timeout => 20.0));
      Bind_Socket (Self.Server, Self.Addr);
      Self.S.Set_Address (Self.Buffer'Address);
      Self.S.Set_Length (Self.Buffer'Length);
   end Initialize;

   procedure Log
     (Handler  : in out Test_App;
      Message  : LIFX.Messages.Message'Class;
      Location : String := GNAT.Source_Info.Enclosing_Entity) is
   begin
      New_Line;
      Put_Line (GNAT.Time_Stamp.Current_Time & " : " & Image (Handler.From) & ":" & Location);
      Put_Line (Message.Image);

   end;

   procedure Send (Handler  : in out Test_App;
                   Message  : LIFX.Messages.Message'Class) is
   begin
      LIFX.Messages.Send_Socket (Handler.Server, Item => Message, To => Handler.From'Access);
   end;

   --------------
   -- On_State --
   --------------

   overriding procedure On_State
     (Handler : in out Test_App;
      Message : LIFX.Messages.Lights.State_Messages.State_Message)
   is
   begin
      Handler.Log (Message);
      if LIFX.Messages.Image (Message.Label) = "Moa:s Rum" then
         Put_Line ("---->");
         delay 0.2;
         Handler.Send (LIFX.Messages.Lights.SetPower_Messages.Create
                       (Level => (if Message.Power > 40000 then 000.0 else 1.0), Set_Time =>  15.0));
         delay 0.2;

      end if;
      Handler.Send (Messages.GetGroup_Messages.create);
   end On_State;

   ---------------------
   -- On_StateService --
   ---------------------

   overriding procedure On_StateService
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateService_Messages.StateService_Message)
   is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.Lights.Get_Messages.Create);
   end On_StateService;

   overriding procedure On_StatePower
     (Handler : in out Test_App;
      Message : LIFX.Messages.StatePower_Messages.StatePower_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetWifiFirmware_Messages.create);
   end;

   overriding procedure On_StateGroup
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetLocation_Messages.Create);
   end On_StateGroup;

   overriding procedure On_StateLocation
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateLocation_Messages.StateLocation_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetHostFirmware_Messages.create);
   end On_StateLocation;

   overriding procedure On_StateHostFirmware
     (Handler : in out Test_App;
      message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message) is
   begin
      Handler.Log (message);
      Handler.Send (Messages.GetWifiFirmware_Messages.create);
   end On_StateHostFirmware;

   overriding procedure On_StateWifiFirmware
     (Handler : in out Test_App;
      message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message) is
   begin
      Handler.Log (message);
      Handler.Send (Messages.GetWifiInfo_Messages.create);
   end;

   overriding procedure On_StateWifiInfo
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message) is
   begin
      Handler.Log (Message);
   end;

end LIFX.Tests.Applications;
