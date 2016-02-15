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
package body LIFX.Messages.StateWifiInfo_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Image (Item : StateWifiInfo_Message) return String is
   begin
      return Image (Message (Item)) & "," & ASCII.LF &
        "Signal => " & Item.Signal'Img & "," &  ASCII.LF &
        "Tx     => " & Image (Item.Tx) & "," &  ASCII.LF &
        "Rx     => " & Image (Item.Rx);
   end Image;

   overriding function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateWifiInfo_Message is
   begin
      return Ret : StateWifiInfo_Message do
         Float'Read (Params, Ret.Signal);
         Interfaces.Unsigned_32'Read (Params, Ret.Tx);
         Interfaces.Unsigned_32'Read (Params, Ret.Rx);
         Short_Integer'Read (Params, Ret.Reserved);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateWifiInfo_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateWifiInfo;
      Msg.Header.Frame.Size               := StateWifiInfo_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   function Create
     (Src      : Message'Class;
      Signal   : Float;
      Tx       : Interfaces.Unsigned_32;
      Rx       : Interfaces.Unsigned_32)
      return StateWifiInfo_Message is
   begin
      return Ret : StateWifiInfo_Message do
         Ret.Header.Frame_Address.Sequence :=  Src.Header.Frame_Address.Sequence;
         Ret.Signal := Signal;
         Ret.Tx := Tx;
         Ret.Rx := Rx;
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateWifiInfo, Object_Tag => StateWifiInfo_Message'Tag);
end LIFX.Messages.StateWifiInfo_Messages;
