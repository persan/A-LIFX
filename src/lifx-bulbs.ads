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

with Ada.Containers.Vectors;
with Ada.Finalization;
with Ada.Strings.Unbounded;
with GNAT.Sockets;
with LIFX.Messages;

package LIFX.Bulbs is
   type Bulb is tagged record
      Label    : Ada.Strings.Unbounded.Unbounded_String;
      Location : Ada.Strings.Unbounded.Unbounded_String;
      Color    : LIFX.Messages.HSBK_Type;
      Address  : GNAT.Sockets.Inet_Addr_Type;
   end record;

   package Bulb_Vectors is new Ada.Containers.Vectors (Natural, Bulb);

   type Bulbs_Record is tagged limited private;

   procedure Query_Network (Self : in out Bulbs_Record);
   function Image (Self : Bulbs_Record) return String;

private

   type Bulbs_Record is new Ada.Finalization.Limited_Controlled with record
      Bulbs : Bulb_Vectors.Vector;
   end record;

   procedure On_Message (Self : Bulbs_Record; Message : LIFX.Messages.Message'Class);
   --    procedure Initialize (Self : in out Bulbs_Record);
   overriding procedure Finalize (Self : in out Bulbs_Record);

end LIFX.Bulbs;
