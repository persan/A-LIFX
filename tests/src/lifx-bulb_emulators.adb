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

with Ada.Text_IO;

with GNAT.Time_Stamp;
with Interfaces;
with LIFX.Messages.GetGroup_Messages;
with LIFX.Messages.GetHostFirmware_Messages;
with LIFX.Messages.GetLocation_Messages;
with LIFX.Messages.GetWifiFirmware_Messages;
with LIFX.Messages.GetWifiInfo_Messages;
with LIFX.Messages.Lights.Get_Messages;
with LIFX.Messages.Lights.SetPower_Messages;
with LIFX.Messages.Send_Socket;

package body LIFX.Bulb_Emulators is
   use GNAT.Sockets;
   use LIFX.Messages;
   use Ada.Text_IO;
   use type Interfaces.Unsigned_16;
   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in  out Bulb_Emulator) is
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
     (Handler  : in out Bulb_Emulator;
      Message  : LIFX.Messages.Message'Class;
      Location : String := GNAT.Source_Info.Enclosing_Entity) is
   begin
      New_Line;
      Put_Line (GNAT.Time_Stamp.Current_Time & " : " & Image (Handler.From) & ":" & Location);
      Put_Line (Message.Image);

   end;

   procedure Send (Handler  : in out Bulb_Emulator;
                   Message  : LIFX.Messages.Message'Class) is
   begin
      LIFX.Messages.Send_Socket (Handler.Server, Item => Message, To => Handler.From'Access);
   end;

   --------------
   -- On_State --
   --------------

   overriding procedure On_State
     (Handler : in out Bulb_Emulator;
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
      Handler.Send (Messages.GetGroup_Messages.Create);
   end On_State;

   overriding procedure On_GetService
     (Handler : in out Bulb_Emulator;
      Message : LIFX.Messages.GetService_Messages.GetService_Message) is
   --  MSg : LIFX.Messages.StateService_Messages.StateService_Message := LIFX.Messages.StateService_Messages;
   begin
      --        Handler.Send (LIFX.Messages.Lights.Create
      --                      (Level => (if Message.Power > 40000 then 000.0 else 1.0), Set_Time =>  15.0));
      null;
   end;

   ---------------------
   -- On_StateService --
   ---------------------

   overriding procedure On_StateService
     (Handler : in out Bulb_Emulator;
      Message : LIFX.Messages.StateService_Messages.StateService_Message)
   is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.Lights.Get_Messages.Create);
   end On_StateService;

   overriding procedure On_StatePower
     (Handler : in out Bulb_Emulator;
      Message : LIFX.Messages.StatePower_Messages.StatePower_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetWifiFirmware_Messages.Create);
   end;

   overriding procedure On_StateGroup
     (Handler : in out Bulb_Emulator;
      Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetLocation_Messages.Create);
   end On_StateGroup;

   overriding procedure On_StateLocation
     (Handler : in out Bulb_Emulator;
      Message : LIFX.Messages.StateLocation_Messages.StateLocation_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetHostFirmware_Messages.Create);
   end On_StateLocation;

   overriding procedure On_StateHostFirmware
     (Handler : in out Bulb_Emulator;
      Message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetWifiFirmware_Messages.Create);
   end On_StateHostFirmware;

   overriding procedure On_StateWifiFirmware
     (Handler : in out Bulb_Emulator;
      Message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetWifiInfo_Messages.Create);
   end;

   overriding procedure On_StateWifiInfo
     (Handler : in out Bulb_Emulator;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message) is
   begin
      Handler.Log (Message);
   end;

end LIFX.Bulb_Emulators;
