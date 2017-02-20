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

with Ada.Finalization;
with Ada.Streams;

with GNAT.Sockets;
with GNAT.Source_Info;

with LIFX.Messages.Dispatchers;
with LIFX.Messages.Lights.State_Messages;
with LIFX.Messages.StateGroup_Messages;
with LIFX.Messages.StateHostFirmware_Messages;
with LIFX.Messages.StateLocation_Messages;
with LIFX.Messages.StatePower_Messages;
with LIFX.Messages.StateService_Messages;
with LIFX.Messages.StateWifiFirmware_Messages;
with LIFX.Messages.StateWifiInfo_Messages;
with LIFX.Messages.Unknown_Messages;

with Stream_Tools.Memory_Streams;

package LIFX.Tests.Applications is
   type Test_App is limited new Ada.Finalization.Limited_Controlled and LIFX.Messages.Dispatchers.Message_Handler with record
      Server            : GNAT.Sockets.Socket_Type;
      Buffer            : Ada.Streams.Stream_Element_Array (1 .. 1024);
      S                 : aliased Stream_Tools.Memory_Streams.Memory_Stream;
      Last              : Ada.Streams.Stream_Element_Offset;
      From              : GNAT.Sockets.Sock_Addr_Type;
      Addr              : GNAT.Sockets.Sock_Addr_Type;
   end record;

   overriding procedure Initialize (Self : in  out Test_App);

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
      Message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message);

   overriding procedure On_StateWifiFirmware
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message);

   overriding procedure On_StateWifiInfo
     (Handler : in out Test_App;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message);

   not overriding procedure Log
     (Handler  : in out Test_App;
      Message  : LIFX.Messages.Message'Class;
      Location : String := GNAT.Source_Info.Enclosing_Entity);

   overriding procedure On_Unknown
     (Handler : in out Test_App;
      Message : LIFX.Messages.Unknown_Messages.Unknown_Message);

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
