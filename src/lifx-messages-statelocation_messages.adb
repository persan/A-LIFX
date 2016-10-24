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

with LIFX.Messages.Constants;
with Ada.Strings.Fixed;
package body LIFX.Messages.StateLocation_Messages is

   -----------------
   -- Constructor --
   -----------------
   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateLocation_Message is
   begin
      return Ret : StateLocation_Message do
         String'Read (Params, Ret.Location);
         String'Read (Params, Ret.Label);
         Time_Type'Read (Params, Ret.Updated_At);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateLocation_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateLocation;
      Msg.Header.Frame.Size               := StateLocation_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   overriding function Image (Item : StateLocation_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        " Location   => " & Image (Item.Location) &  "," &  ASCII.LF &
        " Label      => " & Image (Item.Label) &   "," & ASCII.LF &
        " Updated_At => " & Image (Item.Updated_At) &
        "";
   end Image;

   function Create
     (Src        : Message'Class;
      Location   : String;
      Label      : String;
      Updated_At : Time_Type)
      return StateLocation_Message is
   begin
      return Ret : StateLocation_Message do
         Ret.Header.Frame_Address.Sequence := Src.Header.Frame_Address.Sequence;
         Ada.Strings.Fixed.Move (Source => Location, Target => Ret.Location, Drop => Ada.Strings.Right);
         Ada.Strings.Fixed.Move (Source => Label, Target => Ret.Label, Drop => Ada.Strings.Right);
         Ret.Updated_At := Updated_At;
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateLocation, Object_Tag => StateLocation_Message'Tag);
end LIFX.Messages.StateLocation_Messages;
