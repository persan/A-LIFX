package body LIFX.Messages.Dispatchers is

   use all type Ada.Tags.Tag;

   procedure Dispatch_Message
      (Handler : in out Message_Handler'Class;
       Message : LIFX.Messages.Message'Class) is
   begin
      if Message'Tag = LIFX.Messages.Acknowledgement_Messages.Acknowledgement_Message'Tag then
         Handler.On_Acknowledgement (LIFX.Messages.Acknowledgement_Messages.Acknowledgement_Message (Message));
      elsif Message'Tag = LIFX.Messages.EchoRequest_Messages.EchoRequest_Message'Tag then
         Handler.On_EchoRequest (LIFX.Messages.EchoRequest_Messages.EchoRequest_Message (Message));
      elsif Message'Tag = LIFX.Messages.EchoResponse_Messages.EchoResponse_Message'Tag then
         Handler.On_EchoResponse (LIFX.Messages.EchoResponse_Messages.EchoResponse_Message (Message));
      elsif Message'Tag = LIFX.Messages.Lights.Get_Messages.Get_Message'Tag then
         Handler.On_Get (LIFX.Messages.Lights.Get_Messages.Get_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetGroup_Messages.GetGroup_Message'Tag then
         Handler.On_GetGroup (LIFX.Messages.GetGroup_Messages.GetGroup_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetHostFirmware_Messages.GetHostFirmware_Message'Tag then
         Handler.On_GetHostFirmware (LIFX.Messages.GetHostFirmware_Messages.GetHostFirmware_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetHostInfo_Messages.GetHostInfo_Message'Tag then
         Handler.On_GetHostInfo (LIFX.Messages.GetHostInfo_Messages.GetHostInfo_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetInfo_Messages.GetInfo_Message'Tag then
         Handler.On_GetInfo (LIFX.Messages.GetInfo_Messages.GetInfo_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetLabel_Messages.GetLabel_Message'Tag then
         Handler.On_GetLabel (LIFX.Messages.GetLabel_Messages.GetLabel_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetLocation_Messages.GetLocation_Message'Tag then
         Handler.On_GetLocation (LIFX.Messages.GetLocation_Messages.GetLocation_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetPower_Messages.GetPower_Message'Tag then
         Handler.On_GetPower (LIFX.Messages.GetPower_Messages.GetPower_Message (Message));
      elsif Message'Tag = LIFX.Messages.Lights.GetPower_Messages.GetPower_Message'Tag then
         Handler.On_GetPower (LIFX.Messages.Lights.GetPower_Messages.GetPower_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetService_Messages.GetService_Message'Tag then
         Handler.On_GetService (LIFX.Messages.GetService_Messages.GetService_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetVersion_Messages.GetVersion_Message'Tag then
         Handler.On_GetVersion (LIFX.Messages.GetVersion_Messages.GetVersion_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetWifiFirmware_Messages.GetWifiFirmware_Message'Tag then
         Handler.On_GetWifiFirmware (LIFX.Messages.GetWifiFirmware_Messages.GetWifiFirmware_Message (Message));
      elsif Message'Tag = LIFX.Messages.GetWifiInfo_Messages.GetWifiInfo_Message'Tag then
         Handler.On_GetWifiInfo (LIFX.Messages.GetWifiInfo_Messages.GetWifiInfo_Message (Message));
      elsif Message'Tag = LIFX.Messages.Lights.SetColor_Messages.SetColor_Message'Tag then
         Handler.On_SetColor (LIFX.Messages.Lights.SetColor_Messages.SetColor_Message (Message));
      elsif Message'Tag = LIFX.Messages.SetLabel_Messages.SetLabel_Message'Tag then
         Handler.On_SetLabel (LIFX.Messages.SetLabel_Messages.SetLabel_Message (Message));
      elsif Message'Tag = LIFX.Messages.Lights.SetPower_Messages.SetPower_Message'Tag then
         Handler.On_SetPower (LIFX.Messages.Lights.SetPower_Messages.SetPower_Message (Message));
      elsif Message'Tag = LIFX.Messages.SetPower_Messages.SetPower_Message'Tag then
         Handler.On_SetPower (LIFX.Messages.SetPower_Messages.SetPower_Message (Message));
      elsif Message'Tag = LIFX.Messages.Lights.State_Messages.State_Message'Tag then
         Handler.On_State (LIFX.Messages.Lights.State_Messages.State_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateGroup_Messages.StateGroup_Message'Tag then
         Handler.On_StateGroup (LIFX.Messages.StateGroup_Messages.StateGroup_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message'Tag then
         Handler.On_StateHostFirmware (LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateHostInfo_Messages.StateHostInfo_Message'Tag then
         Handler.On_StateHostInfo (LIFX.Messages.StateHostInfo_Messages.StateHostInfo_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateInfo_Messages.StateInfo_Message'Tag then
         Handler.On_StateInfo (LIFX.Messages.StateInfo_Messages.StateInfo_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateLabel_Messages.StateLabel_Message'Tag then
         Handler.On_StateLabel (LIFX.Messages.StateLabel_Messages.StateLabel_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateLocation_Messages.StateLocation_Message'Tag then
         Handler.On_StateLocation (LIFX.Messages.StateLocation_Messages.StateLocation_Message (Message));
      elsif Message'Tag = LIFX.Messages.Lights.StatePower_Messages.StatePower_Message'Tag then
         Handler.On_StatePower (LIFX.Messages.Lights.StatePower_Messages.StatePower_Message (Message));
      elsif Message'Tag = LIFX.Messages.StatePower_Messages.StatePower_Message'Tag then
         Handler.On_StatePower (LIFX.Messages.StatePower_Messages.StatePower_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateService_Messages.StateService_Message'Tag then
         Handler.On_StateService (LIFX.Messages.StateService_Messages.StateService_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateVersion_Messages.StateVersion_Message'Tag then
         Handler.On_StateVersion (LIFX.Messages.StateVersion_Messages.StateVersion_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message'Tag then
         Handler.On_StateWifiFirmware (LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message (Message));
      elsif Message'Tag = LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message'Tag then
         Handler.On_StateWifiInfo (LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message (Message));
      elsif Message'Tag = LIFX.Messages.Unknown_Messages.Unknown_Message'Tag then
         Handler.On_Unknown (LIFX.Messages.Unknown_Messages.Unknown_Message (Message));
      else
         null;
      end if;
   end Dispatch_Message;
end LIFX.Messages.Dispatchers;
