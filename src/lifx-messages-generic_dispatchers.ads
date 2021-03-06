--  begin read only
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

--  ---------------------------------------------------------------
--  This package is automaticly generated do not edit by hand
--  ---------------------------------------------------------------

with LIFX.Messages.StateLocation_Messages;
with LIFX.Messages.Lights.Get_Messages;
with LIFX.Messages.GetVersion_Messages;
with LIFX.Messages.GetWifiInfo_Messages;
with LIFX.Messages.GetWifiFirmware_Messages;
with LIFX.Messages.StateLabel_Messages;
with LIFX.Messages.Lights.SetColor_Messages;
with LIFX.Messages.StateService_Messages;
with LIFX.Messages.GetLocation_Messages;
with LIFX.Messages.GetGroup_Messages;
with LIFX.Messages.GetHostInfo_Messages;
with LIFX.Messages.StatePower_Messages;
with LIFX.Messages.EchoRequest_Messages;
with LIFX.Messages.StateVersion_Messages;
with LIFX.Messages.Lights.State_Messages;
with LIFX.Messages.StateInfo_Messages;
with LIFX.Messages.StateGroup_Messages;
with LIFX.Messages.GetHostFirmware_Messages;
with LIFX.Messages.StateHostInfo_Messages;
with LIFX.Messages.Unknown_Messages;
with LIFX.Messages.Lights.SetPower_Messages;
with LIFX.Messages.StateHostFirmware_Messages;
with LIFX.Messages.EchoResponse_Messages;
with LIFX.Messages.SetPower_Messages;
with LIFX.Messages.StateWifiFirmware_Messages;
with LIFX.Messages.StateWifiInfo_Messages;
with LIFX.Messages.Acknowledgement_Messages;
with LIFX.Messages.Lights.StatePower_Messages;
with LIFX.Messages.GetService_Messages;
with LIFX.Messages.GetLabel_Messages;
with LIFX.Messages.GetPower_Messages;
with LIFX.Messages.SetLabel_Messages;
with LIFX.Messages.Lights.GetPower_Messages;
with LIFX.Messages.GetInfo_Messages;

generic
   type Parameter_Type is limited private;
package LIFX.Messages.Generic_Dispatchers is

   type Message_Handler is limited interface;

   procedure On_StateLocation
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateLocation_Messages.StateLocation_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_Get
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.Lights.Get_Messages.Get_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetVersion
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetVersion_Messages.GetVersion_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetWifiInfo
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetWifiInfo_Messages.GetWifiInfo_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetWifiFirmware
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetWifiFirmware_Messages.GetWifiFirmware_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StateLabel
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateLabel_Messages.StateLabel_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_SetColor
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.Lights.SetColor_Messages.SetColor_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StateService
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateService_Messages.StateService_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetLocation
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetLocation_Messages.GetLocation_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetGroup
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetGroup_Messages.GetGroup_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetHostInfo
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetHostInfo_Messages.GetHostInfo_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StatePower
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StatePower_Messages.StatePower_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_EchoRequest
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.EchoRequest_Messages.EchoRequest_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StateVersion
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateVersion_Messages.StateVersion_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_State
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.Lights.State_Messages.State_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StateInfo
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateInfo_Messages.StateInfo_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StateGroup
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetHostFirmware
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetHostFirmware_Messages.GetHostFirmware_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StateHostInfo
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateHostInfo_Messages.StateHostInfo_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_Unknown
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.Unknown_Messages.Unknown_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_SetPower
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.Lights.SetPower_Messages.SetPower_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StateHostFirmware
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_EchoResponse
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.EchoResponse_Messages.EchoResponse_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_SetPower
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.SetPower_Messages.SetPower_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StateWifiFirmware
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StateWifiInfo
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_Acknowledgement
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.Acknowledgement_Messages.Acknowledgement_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_StatePower
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.Lights.StatePower_Messages.StatePower_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetService
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetService_Messages.GetService_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetLabel
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetLabel_Messages.GetLabel_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetPower
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetPower_Messages.GetPower_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_SetLabel
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.SetLabel_Messages.SetLabel_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetPower
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.Lights.GetPower_Messages.GetPower_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure On_GetInfo
     (Handler : in out Message_Handler;
      Message : LIFX.Messages.GetInfo_Messages.GetInfo_Message;
      Parameter : not null access Parameter_Type) is null;

   procedure Dispatch_Message
      (Handler   : in out Message_Handler'Class;
       Message   : LIFX.Messages.Message'Class;
       Parameter : not null access Parameter_Type);

end LIFX.Messages.Generic_Dispatchers;
--  end read only
