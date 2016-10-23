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

with Ada.Tags.Generic_Dispatching_Constructor;
with GNAT.Calendar.Time_IO;
with GNAT.Calendar;
with Stream_Tools.Memory_Streams;
with Ada.Strings.Unbounded;
with LIFX.Messages.Unknown_Messages;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
package body LIFX.Messages is

   use all type Ada.Streams.Stream_Element_Offset;
   use all type Ada.Tags.Tag;
   use all type Ada.Calendar.Time;
   use all type Interfaces.Unsigned_8;
   -----------
   -- Input --
   -----------

   function Input (S : not null access Ada.Streams.Root_Stream_Type'Class) return Message'Class is
      function Dispatching_Constructor is new Ada.Tags.Generic_Dispatching_Constructor
        (T           => Message,
         Parameters  => Ada.Streams.Root_Stream_Type'Class,
         Constructor => Constructor);
      Name : Header_Type;

   begin
      Header_Type'Read (S, Name);
      if Name_To_Tag (Name.Protocol_Header.Msg_Type) = Ada.Tags.No_Tag then
         return Ret : Message'Class := Dispatching_Constructor (Unknown_Messages.Unknown_Message'Tag, S) do
            Ret.Header := Name;
         end return;
      end if;
      return Ret : Message'Class := Dispatching_Constructor (Name_To_Tag (Name.Protocol_Header.Msg_Type), S) do
         Ret.Header := Name;
      end return;
   end Input;

   ------------
   -- Output --
   ------------

   procedure Output (S : not null access Ada.Streams.Root_Stream_Type'Class; Msg : Message'Class) is
      use Stream_Tools.Memory_Streams;
      Buffer : aliased Dynamic_Memory_Stream (1024, Add_Initial_Size);

   begin
      Message'Class'Write (Buffer'Access, Msg);
      Buffer.Seek (-1);
      Dynamic_Memory_Stream'Write (S, Buffer);
   end Output;

   function Image (Item : Unsigned_16_Array) return String is
      Ret : Ada.Strings.Unbounded.Unbounded_String;
   begin
      for I of Item loop
         Ada.Strings.Unbounded.Append (Ret, " " & I'Img);
      end loop;
      return Ada.Strings.Unbounded.To_String (Ret);
   end Image;

   -------------------
   -- Register_Name --
   -------------------

   procedure Register_Name (Name : Msg_Kind; Object_Tag : Ada.Tags.Tag) is
   begin
      if Name_To_Tag (Name) /= Ada.Tags.No_Tag then
         raise Constraint_Error with "id" & Name'Img & " defined twice: " &
           Ada.Tags.External_Tag (Object_Tag) & " & " &
           Ada.Tags.External_Tag (Name_To_Tag (Name));
      else
         Name_To_Tag (Name) := Object_Tag;
      end if;

   end Register_Name;

   procedure Write (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : Frame_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Frame_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import  => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Write (S, Buffer);
   end Write;

   procedure Read (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : out Frame_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Frame_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import  => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Read (S, Buffer);
   end Read;

   procedure Write (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : Frame_Address_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Frame_Address_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import  => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Write (S, Buffer);
   end Write;

   procedure Read (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : out Frame_Address_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Frame_Address_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import  => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Read (S, Buffer);
   end Read;

   procedure Write (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : Protocol_Header_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Protocol_Header_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import  => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Write (S, Buffer);
   end Write;

   procedure Read (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : out Protocol_Header_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Protocol_Header_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import  => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Read (S, Buffer);
   end Read;

   function Image (Item : Boolean_Array) return String is
   begin
      return Ret : String (Item'Range) do
         for I in Item'Range loop
            Ret (I) := (if Item (I) then '1' else '_');
         end loop;
      end return;
   end Image;

   function Image (Item : String; Width : Natural := 0) return String is
   begin
      for I in Item'Range loop
         if Item (I) < ' ' or else Item (I) > ASCII.DEL then
            return Item (Item'First .. I - 1) & (if Width = 0 then "" else Natural'Max (0, Width - I)  * ' ');
         end if;
      end loop;
      return Item;
   end Image;

   function Image (Item : Frame_Type) return String is
   begin
      return
        "    Size        => " & Image (Item.Size) & ", " & ASCII.LF &
        "    Origin      => " & Image (Item.Origin) & ", " & ASCII.LF &
        "    Is_Tagged   => " & Image (Item.Is_Tagged) & ", " & ASCII.LF &
        "    Addressable => " & Image (Item.Addressable) & ", " & ASCII.LF &
        "    Protocol    => " & Image (Item.Protocol) & ", " & ASCII.LF &
        "    Source      => " & Image (Item.Source);
   end Image;

   function Image (Item : Frame_Address_Type) return String is
   begin
      return
        "    Target       => " & Image (Item.Target) & ", " & ASCII.LF &
        "    Ack_Required => " & Image (Item.Ack_Required) & ", " & ASCII.LF &
        "    Res_Required => " & Image (Item.Res_Required) & ", " & ASCII.LF &
        "    Sequence     => " & Image (Item.Sequence);
   end Image;

   function Image (Item : Protocol_Header_Type) return String is
   begin
      return
        "    Msg_Type => " & Image (Item.Msg_Type);
   end Image;

   function Image (Item : Header_Type; With_Header : Boolean := False) return String is
   begin
      return
        (if  With_Header then
           ASCII.LF &  "  Frame           => (" & ASCII.LF & Image (Item.Frame) & ")," & ASCII.LF &
           "  Frame_Address   => (" & ASCII.LF & Image (Item.Frame_Address) & ")," & ASCII.LF &
           "  Protocol_Header => (" & ASCII.LF & Image (Item.Protocol_Header) & ")"
         else "");
   end Image;

   function Image (Item : Message) return String is
   begin
      return "Header => (" & Image (Item.Header) & ")";
   end Image;

   function Image (Item : HSBK_Type) return String is
   begin
      return "      Hue               => " & Image (Item.Hue) & ASCII.LF &
        "      Saturation        => " & Image (Item.Saturation) & ASCII.LF &
        "      Brightness        => " & Image (Item.Brightness) & ASCII.LF &
        "      color_temperature => " & Image (Item.Color_Temperature);
   end Image;

   function Image (Item : Ada.Streams.Stream_Element_Array) return String is
      Ret    : String (1 .. Item'Length * 3);
      Cursor : Natural := Ret'First;
      Map    : constant array (Ada.Streams.Stream_Element (0) .. Ada.Streams.Stream_Element (15)) of Character
        := "0123456789ABCDEF";
      use type Ada.Streams.Stream_Element;
   begin
      for I of Item loop
         Ret (Cursor) := Map (I / 16);
         Cursor       := Cursor + 1;
         Ret (Cursor) := Map (I mod 16);
         Cursor       := Cursor + 1;
         Ret (Cursor) := ' ';
         Cursor       := Cursor + 1;
      end loop;
      return Ret (Ret'First .. Ret'Last - 1);
   end Image;

   EPOC : constant Ada.Calendar.Time := Ada.Calendar.Time_Of (1970, 01, 01, 0.0);

   function To_Calendar_Time (T : Time_Type) return Ada.Calendar.Time is
   begin
      return EPOC + Duration (T / 1_000_000_000);
   end To_Calendar_Time;

   function To_Time_Type (T : Ada.Calendar.Time) return Time_Type is
   begin
      return Time_Type (Duration'(T - EPOC) * 1_000_000_000);
   end To_Time_Type;

   function Image (Item : Time_Type) return String is
   begin
      return GNAT.Calendar.Time_IO.Image (To_Calendar_Time (Item), "%Y-%m-%d %T");
   end Image;
   function Image (Item : Msg_Kind) return String is
      T : constant String := Ada.Tags.External_Tag (Name_To_Tag (Item));

   begin
      for I in reverse T'Range loop
         if T (I) = '.' then
            for L in I + 1 .. T'Last loop
               if T (L) not in 'A' .. 'Z' | '0' .. '9' then
                  return T (I + 1 .. L - 1);
               end if;
            end loop;
         end if;
      end loop;
      return T;
   end;
   Sequence_Store : Interfaces.Unsigned_8 := 0;

   function Sequence return Interfaces.Unsigned_8 is
   begin
      Sequence_Store := Sequence_Store + 1;
      return Sequence_Store;
   end Sequence;

end LIFX.Messages;
