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

with Ada.Calendar;

with Interfaces;

with LIFX.Bulb;
with LIFX.Messages.GetGroup_Messages;
with LIFX.Messages.GetHostFirmware_Messages;
with LIFX.Messages.GetLocation_Messages;
with LIFX.Messages.GetWifiFirmware_Messages;
with LIFX.Messages.GetWifiInfo_Messages;
with LIFX.Messages.Lights.Get_Messages;
with LIFX.Messages.Lights.SetPower_Messages;
with LIFX.Messages.Send_Socket;
with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Time_Stamp;

package body LIFX.Tests.Applications is
   use Interfaces;
   use GNAT.Sockets;
   use LIFX.Messages;
   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in  out Test_App) is
   begin
      Self.From := GNAT.Sockets.No_Sock_Addr;
      Self.Addr.Addr := Any_Inet_Addr;
      Self.Addr.Port := LIFX_Port;
      --        Self.Addr.Port := Any_Port;
      Create_Socket (Self.Server, Family_Inet, Socket_Datagram);
      Set_Socket_Option (Self.Server, Option => (Reuse_Address, Enabled => True));
      Set_Socket_Option (Self.Server, Option => (Broadcast, Enabled => True));
      Set_Socket_Option (Self.Server, Option => (Receive_Timeout, Timeout => 2.0));
      Bind_Socket (Self.Server, Self.Addr);
      Self.S.Set_Address (Self.Buffer'Address);
      Self.S.Set_Length (Self.Buffer'Length);
   end Initialize;

   procedure Log
     (Handler  : in out Test_App;
      Message  : LIFX.Messages.Message'Class;
      Location : String := GNAT.Source_Info.Enclosing_Entity) is
      pragma Unreferenced (Message);
   begin
      null;
      --  New_Line;
      Put_Line (GNAT.Time_Stamp.Current_Time & " : " & Image (Handler.From) & ":" & Location);
      --  Put_Line (Message.Image);
   end;

   procedure Send (Handler  : in out Test_App;
                   Message  : LIFX.Messages.Message'Class) is
      From : aliased GNAT.Sockets.Sock_Addr_Type;
   begin
      From := Handler.From;
      LIFX.Messages.Send_Socket (Handler.Server, Item => Message, To => From'Access);
   end;

   procedure AppendNode (Node : GNAT.Sockets.Sock_Addr_Type) is
   begin
      if not Bulb_Store.Store.Contains (Node) then
         Bulb_Store.Store.Insert (Node, Bulb_Store.Null_Bulb_Info);
         Bulb_Store.Store (Node).Addr := Node;
      end if;
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
      AppendNode (Handler.From);
      declare
         Item : Bulb_Store.Bulb_Info renames Bulb_Store.Store (Handler.From);
      begin
         Item.Time := Ada.Calendar.Clock;
         Item.Label := Message.Label;
         Item.Color := Message.Color;
         Item.Power := Float (Message.Power) / 255.0;
      end;
      if LIFX.Messages.Image (Message.Label) = "Moa:s Rum" then
         delay 0.2;
         Handler.Send (LIFX.Messages.Lights.SetPower_Messages.Create
                       (Level => (if Message.Power > 40000 then 000.0 else 1.0), Set_Time =>  15.0));
         delay 0.2;

      end if;
      Handler.Send (Messages.GetGroup_Messages.Create);
   end On_State;

   ---------------------
   -- On_StateService --
   ---------------------

   overriding procedure On_StateService
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateService_Messages.StateService_Message)
   is
   begin
      AppendNode (Handler.From);
      Handler.Log (Message);
      Handler.Send (Messages.Lights.Get_Messages.Create);
   end On_StateService;

   overriding procedure On_StatePower
     (Handler : in out Test_App;
      Message : LIFX.Messages.StatePower_Messages.StatePower_Message) is
   begin
      AppendNode (Handler.From);
      Handler.Log (Message);
      Handler.Send (Messages.GetWifiFirmware_Messages.Create);
   end;

   overriding procedure On_StateGroup
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message) is
   begin
      AppendNode (Handler.From);
      Bulb_Store.Store (Handler.From).Location := Message.Location;
      Bulb_Store.Store (Handler.From).Group := Message.Group;
      Handler.Log (Message);
      Handler.Send (Messages.GetLocation_Messages.Create);
   end On_StateGroup;

   overriding procedure On_StateLocation
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateLocation_Messages.StateLocation_Message) is
   begin
      AppendNode (Handler.From);
      Bulb_Store.Store (Handler.From).Label2 := Message.Label;
      Bulb_Store.Store (Handler.From).Location2 := Message.Location;
      Handler.Log (Message);
      Handler.Send (Messages.GetHostFirmware_Messages.Create);
   end On_StateLocation;

   overriding procedure On_StateHostFirmware
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetWifiFirmware_Messages.Create);
   end On_StateHostFirmware;

   overriding procedure On_StateWifiFirmware
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message) is
   begin
      Handler.Log (Message);
      Handler.Send (Messages.GetWifiInfo_Messages.Create);
   end;

   overriding procedure On_StateWifiInfo
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message) is
   begin
      Handler.Log (Message);
   end;
   overriding procedure On_Unknown
     (Handler : in out Test_App;
      Message : LIFX.Messages.Unknown_Messages.Unknown_Message) is
   begin
      Handler.Log (Message);
   end;

end LIFX.Tests.Applications;
