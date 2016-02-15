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
package body LIFX.Messages.Lights.SetPower_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return SetPower_Message is
      pragma Unreferenced (Params);
   begin
      return Ret : SetPower_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;

   overriding
   procedure Initialize (Msg : in out SetPower_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Light_Messages.SetPower;
      Msg.Header.Frame.Size               := Msg.Header'Size / 8;
   end Initialize;

   overriding
   function Image (Item : SetPower_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "Level    => " & Image (Item.Level) & "," & ASCII.LF &
        "Duration => " & Image (Item.Duration);
   end Image;

   function Create (Level : Float; Set_Time : Duration) return SetPower_Message is
   begin
      return Ret : SetPower_Message do
         Ret.Level                             := Interfaces.Unsigned_16 (Float (Interfaces.Unsigned_16'Last) * Level);
         Ret.Duration                          := Interfaces.Unsigned_32 (Set_Time * 1_000.0);
         Ret.Header.Frame_Address.Sequence     := Sequence;
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Light_Messages.SetPower, Object_Tag => SetPower_Message'Tag);
end LIFX.Messages.Lights.SetPower_Messages;
