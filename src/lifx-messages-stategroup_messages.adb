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
package body LIFX.Messages.StateGroup_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Image (Item : StateGroup_Message) return String is
   begin
      return Image (Message (Item)) &  ASCII.LF &
        "group      => " & Image (Item.Group) & "," & ASCII.LF &
        "Label      => " & Image (Item.Label) & "," & ASCII.LF &
        "updated_at => " & Image (Item.Updated_At);
   end Image;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateGroup_Message is
   begin
      return Ret : StateGroup_Message do
         String'Read (Params, Ret.Group);
         String'Read (Params, Ret.Label);
         Time_Type'Read (Params, Ret.Updated_At);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateGroup_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateGroup;
      Msg.Header.Frame.Size               := StateGroup_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   function Create
     (Src        : Message'Class;
      Group      : String;
      Label      : String;
      Updated_At : Time_Type) return StateGroup_Message is
   begin
      return Ret : StateGroup_Message do
         Ret.Header.Frame_Address.Sequence :=  Src.Header.Frame_Address.Sequence;
         Ret.Group := Group;
         Ret.Label := Label;
         Ret.Updated_At := Updated_At;
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateGroup, Object_Tag => StateGroup_Message'Tag);
end LIFX.Messages.StateGroup_Messages;
