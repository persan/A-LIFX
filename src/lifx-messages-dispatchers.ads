with LIFX.Messages.Acknowledgement_Messages;
with LIFX.Messages.EchoRequest_Messages;
with LIFX.Messages.EchoResponse_Messages;
with LIFX.Messages.Lights.Get_Messages;
with LIFX.Messages.GetGroup_Messages;
with LIFX.Messages.GetHostFirmware_Messages;
with LIFX.Messages.GetHostInfo_Messages;
with LIFX.Messages.GetInfo_Messages;
with LIFX.Messages.GetLabel_Messages;
with LIFX.Messages.GetLocation_Messages;
with LIFX.Messages.GetPower_Messages;
with LIFX.Messages.Lights.GetPower_Messages;
with LIFX.Messages.GetService_Messages;
with LIFX.Messages.GetVersion_Messages;
with LIFX.Messages.GetWifiFirmware_Messages;
with LIFX.Messages.GetWifiInfo_Messages;
with LIFX.Messages.Lights.SetColor_Messages;
with LIFX.Messages.SetLabel_Messages;
with LIFX.Messages.Lights.SetPower_Messages;
with LIFX.Messages.SetPower_Messages;
with LIFX.Messages.Lights.State_Messages;
with LIFX.Messages.StateGroup_Messages;
with LIFX.Messages.StateHostFirmware_Messages;
with LIFX.Messages.StateHostInfo_Messages;
with LIFX.Messages.StateInfo_Messages;
with LIFX.Messages.StateLabel_Messages;
with LIFX.Messages.StateLocation_Messages;
with LIFX.Messages.Lights.StatePower_Messages;
with LIFX.Messages.StatePower_Messages;
with LIFX.Messages.StateService_Messages;
with LIFX.Messages.StateVersion_Messages;
with LIFX.Messages.StateWifiFirmware_Messages;
with LIFX.Messages.StateWifiInfo_Messages;
package LIFX.Messages.Dispatchers is
   type Message_Handler is limited interface;

   procedure On_Acknowledgement
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.Acknowledgement_Messages.Acknowledgement_Message) is null;

   procedure On_EchoRequest
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.EchoRequest_Messages.EchoRequest_Message) is null;

   procedure On_EchoResponse
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.EchoResponse_Messages.EchoResponse_Message) is null;

   procedure On_Get (Handler : in out Message_Handler; message : LIFX.Messages.Lights.Get_Messages.Get_Message) is null;

   procedure On_GetGroup
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetGroup_Messages.GetGroup_Message) is null;

   procedure On_GetHostFirmware
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetHostFirmware_Messages.GetHostFirmware_Message) is null;

   procedure On_GetHostInfo
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetHostInfo_Messages.GetHostInfo_Message) is null;

   procedure On_GetInfo (Handler : in out Message_Handler; message : LIFX.Messages.GetInfo_Messages.GetInfo_Message) is null;

   procedure On_GetLabel
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetLabel_Messages.GetLabel_Message) is null;

   procedure On_GetLocation
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetLocation_Messages.GetLocation_Message) is null;

   procedure On_GetPower
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetPower_Messages.GetPower_Message) is null;

   procedure On_GetPower
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.Lights.GetPower_Messages.GetPower_Message) is null;

   procedure On_GetService
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetService_Messages.GetService_Message) is null;

   procedure On_GetVersion
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetVersion_Messages.GetVersion_Message) is null;

   procedure On_GetWifiFirmware
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetWifiFirmware_Messages.GetWifiFirmware_Message) is null;

   procedure On_GetWifiInfo
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.GetWifiInfo_Messages.GetWifiInfo_Message) is null;

   procedure On_SetColor
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.Lights.SetColor_Messages.SetColor_Message) is null;

   procedure On_SetLabel
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.SetLabel_Messages.SetLabel_Message) is null;

   procedure On_SetPower
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.Lights.SetPower_Messages.SetPower_Message) is null;

   procedure On_SetPower
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.SetPower_Messages.SetPower_Message) is null;

   procedure On_State (Handler : in out Message_Handler; message : LIFX.Messages.Lights.State_Messages.State_Message) is null;

   procedure On_StateGroup
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateGroup_Messages.StateGroup_Message) is null;

   procedure On_StateHostFirmware
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message) is null;

   procedure On_StateHostInfo
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateHostInfo_Messages.StateHostInfo_Message) is null;

   procedure On_StateInfo
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateInfo_Messages.StateInfo_Message) is null;

   procedure On_StateLabel
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateLabel_Messages.StateLabel_Message) is null;

   procedure On_StateLocation
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateLocation_Messages.StateLocation_Message) is null;

   procedure On_StatePower
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.Lights.StatePower_Messages.StatePower_Message) is null;

   procedure On_StatePower
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StatePower_Messages.StatePower_Message) is null;

   procedure On_StateService
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateService_Messages.StateService_Message) is null;

   procedure On_StateVersion
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateVersion_Messages.StateVersion_Message) is null;

   procedure On_StateWifiFirmware
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message) is null;

   procedure On_StateWifiInfo
     (Handler : in out Message_Handler;
      message :        LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message) is null;

   procedure Dispatch_Message (Handler : in out Message_Handler'Class; Message : LIFX.Messages.Message'Class);
end LIFX.Messages.Dispatchers;
