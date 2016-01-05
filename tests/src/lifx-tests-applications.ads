with LIFX.Messages.Dispatchers;
with LIFX.Messages.Lights.State_Messages;
with LIFX.Messages.StateService_Messages;
with Ada.Streams;
with Stream_Tools.Memory_Streams;
with GNAT.Sockets;
with LIFX.Messages.StateGroup_Messages;
with LIFX.Messages.StateLocation_Messages;
with LIFX.Messages.StateHostFirmware_Messages;
with GNAT.Source_Info;
with LIFX.Messages.StatePower_Messages;
with LIFX.Messages.StateWifiFirmware_Messages;
with LIFX.Messages.StateWifiInfo_Messages;
package LIFX.Tests.Applications is
   type Test_App is limited new LIFX.Messages.Dispatchers.Message_Handler with record
      Server            : GNAT.Sockets.Socket_Type;
      Buffer            : Ada.Streams.Stream_Element_Array (1 .. 1024);
      S                 : aliased Stream_Tools.Memory_Streams.Memory_Stream;
      Last              : Ada.Streams.Stream_Element_Offset;
      From              : aliased GNAT.Sockets.Sock_Addr_Type;
      Addr              : GNAT.Sockets.Sock_Addr_Type;
   end record;

   not overriding procedure Initialize (Self : in  out Test_App);

   not overriding procedure Send (Handler  : in out Test_App;
                   Message  : LIFX.Messages.Message'Class);
   overriding procedure On_State
     (Handler : in out Test_App;
      Message : LIFX.Messages.Lights.State_Messages.State_Message);

   overriding procedure On_StateService
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateService_Messages.StateService_Message);

   overriding procedure On_StateGroup
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message);

   overriding procedure On_StateLocation
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateLocation_Messages.StateLocation_Message);

   overriding procedure On_StatePower
     (Handler : in out Test_App;
      Message : LIFX.Messages.StatePower_Messages.StatePower_Message);

   overriding procedure On_StateHostFirmware
     (Handler : in out Test_App;
      message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message);

   overriding procedure On_StateWifiFirmware
     (Handler : in out Test_App;
      message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message);

   overriding procedure On_StateWifiInfo
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message);

   not overriding procedure Log
     (Handler  : in out Test_App;
      Message  : LIFX.Messages.Message'Class;
      Location : String := GNAT.Source_Info.Enclosing_Entity);

--     task type App is new LIFX.Messages.Dispatchers.Message_Handler with
--        entry On_State
--          (Message : LIFX.Messages.Lights.State_Messages.State_Message);
--
--        entry On_StateService
--          (Message : LIFX.Messages.StateService_Messages.StateService_Message);
--
--        entry On_StateGroup
--          (Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message);
--     end App;
end LIFX.Tests.Applications;
