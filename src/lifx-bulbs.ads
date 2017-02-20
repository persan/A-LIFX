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

with GNAT.Sockets;
with LIFX.Messages;
with LIFX.Messages.Dispatchers;
with Ada.Calendar;
with Ada.Containers.Ordered_Maps;
with LIFX.Messages.Acknowledgement_Messages;
with LIFX.Messages.EchoResponse_Messages;
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

package LIFX.Bulbs is

   type Bulb;
   type Map;

   type Handler_Interface is limited interface;
   procedure  Handle_Update (Self : Handler_Interface; Item : not null access Bulb'Class) is null;

   type Null_Handler_Type is new Handler_Interface with null record;
   Null_Handler : aliased Null_Handler_Type;

   type Bulb is new LIFX.Messages.Dispatchers.Message_Handler with record
      Label    : String (1 .. 32) := (others => ' ');
      Label2   : String (1 .. 32) := (others => ' ');
      Group    : String (1 .. 16) := (others => ' ');
      Location : String (1 .. 32) := (others => ' ');
      Location2 : String (1 .. 16) := (others => ' ');
      Color    : LIFX.Messages.HSBK_Type;
      Power_On    : Boolean;
      Power_Level : Float;
      Addr     : GNAT.Sockets.Sock_Addr_Type;
      Time     : Ada.Calendar.Time;
      Version  : LIFX.Messages.StateVersion_Messages.StateVersion_Message;
   end record;

   overriding procedure On_Acknowledgement
     (Handler : in out Bulb;
      Message : LIFX.Messages.Acknowledgement_Messages.Acknowledgement_Message);

   overriding procedure On_EchoResponse
     (Handler : in out Bulb;
      Message : LIFX.Messages.EchoResponse_Messages.EchoResponse_Message);

   overriding procedure On_State
     (Handler : in out Bulb;
      Message : LIFX.Messages.Lights.State_Messages.State_Message);

   overriding procedure On_StateGroup
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message);

   overriding procedure On_StateHostFirmware
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message);

   overriding procedure On_StateHostInfo
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateHostInfo_Messages.StateHostInfo_Message);

   overriding procedure On_StateInfo
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateInfo_Messages.StateInfo_Message);

   overriding procedure On_StateLabel
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateLabel_Messages.StateLabel_Message);

   overriding procedure On_StateLocation
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateLocation_Messages.StateLocation_Message);

   overriding procedure On_StatePower
     (Handler : in out Bulb;
      Message : LIFX.Messages.Lights.StatePower_Messages.StatePower_Message);

   overriding procedure On_StatePower
     (Handler : in out Bulb;
      Message : LIFX.Messages.StatePower_Messages.StatePower_Message);

   overriding procedure On_StateService
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateService_Messages.StateService_Message);

   overriding procedure On_StateVersion
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateVersion_Messages.StateVersion_Message);

   overriding procedure On_StateWifiFirmware
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message);

   overriding procedure On_StateWifiInfo
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message);

   overriding
   function "=" (L, R : Bulb) return Boolean is
     (GNAT.Sockets."=" (L.Addr, R.Addr));

   Null_Bulb_Info : constant Bulb := Bulb'(Label => (others => ' '),
                                           Label2 => (others => ' '),
                                           Group => (others   => ' '),
                                           Location => (others    => ' '),
                                           Location2 => (others      => ' '),
                                           Color => (0.0, 0, 0, 2500),
                                           Power_On => False,
                                           Power_Level => 0.0,
                                           Addr  => GNAT.Sockets.No_Sock_Addr,
                                           Time  => Ada.Calendar.Clock,
                                           Version => Messages.StateVersion_Messages.Null_StateVersion_Message);

   function "<" (L, R : GNAT.Sockets.Sock_Addr_Type) return Boolean is
     (GNAT.Sockets.Image (L) < GNAT.Sockets.Image (R));

   package Bulb_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type        => GNAT.Sockets.Sock_Addr_Type,
      Element_Type    => Bulb,
      "<"             => "<",
      "="             => "=");

   type Map is new Bulb_Maps.Map and LIFX.Messages.Dispatchers.Message_Handler with record
      From : GNAT.Sockets.Sock_Addr_Type;
   end record;

   overriding
   function Copy (Source : Map) return Map;

   overriding procedure On_Acknowledgement
     (Handler : in out Map;
      Message : LIFX.Messages.Acknowledgement_Messages.Acknowledgement_Message);

   overriding procedure On_EchoResponse
     (Handler : in out Map;
      Message : LIFX.Messages.EchoResponse_Messages.EchoResponse_Message);

   overriding procedure On_State
     (Handler : in out Map;
      Message : LIFX.Messages.Lights.State_Messages.State_Message);

   overriding procedure On_StateGroup
     (Handler : in out Map;
      Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message);

   overriding procedure On_StateHostFirmware
     (Handler : in out Map;
      Message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message);

   overriding procedure On_StateHostInfo
     (Handler : in out Map;
      Message : LIFX.Messages.StateHostInfo_Messages.StateHostInfo_Message);

   overriding procedure On_StateInfo
     (Handler : in out Map;
      Message : LIFX.Messages.StateInfo_Messages.StateInfo_Message);

   overriding procedure On_StateLabel
     (Handler : in out Map;
      Message : LIFX.Messages.StateLabel_Messages.StateLabel_Message);

   overriding procedure On_StateLocation
     (Handler : in out Map;
      Message : LIFX.Messages.StateLocation_Messages.StateLocation_Message);

   overriding procedure On_StatePower
     (Handler : in out Map;
      Message : LIFX.Messages.Lights.StatePower_Messages.StatePower_Message);

   overriding procedure On_StatePower
     (Handler : in out Map;
      Message : LIFX.Messages.StatePower_Messages.StatePower_Message);

   overriding procedure On_StateService
     (Handler : in out Map;
      Message : LIFX.Messages.StateService_Messages.StateService_Message);

   overriding procedure On_StateVersion
     (Handler : in out Map;
      Message : LIFX.Messages.StateVersion_Messages.StateVersion_Message);

   overriding procedure On_StateWifiFirmware
     (Handler : in out Map;
      Message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message);

   overriding procedure On_StateWifiInfo
     (Handler : in out Map;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message);
private
   procedure AppendNode
     (Self : in out Map;
      Node : GNAT.Sockets.Sock_Addr_Type);

end LIFX.Bulbs;
