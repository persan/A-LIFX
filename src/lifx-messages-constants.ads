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

package LIFX.Messages.Constants is

   package Device_Messages is
      GetService    : constant := 02;
      StateService  : constant := 03;
      GetHostInfo   : constant := 12;
      StateHostInfo : constant := 13;

      GetHostFirmware   : constant := 14;
      StateHostFirmware : constant := 15;

      GetWifiInfo   : constant := 16;
      StateWifiInfo : constant := 17;

      GetWifiFirmware   : constant := 18;
      StateWifiFirmware : constant := 19;

      GetPower   : constant := 20;
      SetPower   : constant := 21;
      StatePower : constant := 22;

      GetLabel   : constant := 23;
      SetLabel   : constant := 24;
      StateLabel : constant := 25;

      GetVersion   : constant := 32;
      StateVersion : constant := 33;

      GetInfo   : constant := 34;
      StateInfo : constant := 35;

      Acknowledgement : constant := 45;

      GetLocation   : constant := 48;
      StateLocation : constant := 50;

      GetGroup     : constant := 51;
      StateGroup   : constant := 53;
      EchoRequest  : constant := 58;
      EchoResponse : constant := 59;
   end Device_Messages;

   package Light_Messages is
      Get        : constant := 101;
      SetColor   : constant := 102;
      State      : constant := 107;
      GetPower   : constant := 116;
      SetPower   : constant := 117;
      StatePower : constant := 118;
   end Light_Messages;

end LIFX.Messages.Constants;
