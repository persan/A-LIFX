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

--  http://lan.developer.lifx.com/docs

with Ada.Finalization;
with System;
with Ada.Streams;
with Ada.Tags;
with Ada.Calendar;
with Interfaces;
package LIFX.Messages is
   use type Interfaces.Unsigned_16;
   type Origin_Type is mod 2**2;
   type Protocoll_Type is mod 2**12;
   type Time_Type is new Interfaces.Unsigned_64;
   type Unsigned_16_Array is array (Natural range <>) of Interfaces.Unsigned_16;

   type Hue_Type is delta 360.0 / (2**15) range 0.0 .. 360.0 - (360.0 / (2**16)) with
        Size => 16;

   function To_Calendar_Time (T : Time_Type) return Ada.Calendar.Time;
   function To_Time_Type (T : Ada.Calendar.Time) return Time_Type;

   type Temperature_Type is new Interfaces.Unsigned_16 range 2500 .. 9000;
   function Image (Item : Temperature_Type) return String is (Item'Img);

   type Saturation_Type is new Interfaces.Unsigned_16;
--     type Saturation_Type is delta 100.0 / (2 ** 16) range 0.0 .. 100.0 - (100.0 / (2 ** 16));
   function Image (Item : Saturation_Type) return String is (Item'Img);

   type HSBK_Type is record
      Hue               : Hue_Type;
      Saturation        : Saturation_Type;
      Brightness        : Interfaces.Unsigned_16;
      Color_Temperature : Temperature_Type;
   end record with
      Bit_Order            => System.Low_Order_First,
      Scalar_Storage_Order => System.Low_Order_First,
      Alignment            => 1;
   for HSBK_Type use record
      Hue               at 0 range 0 .. 15;
      Saturation        at 2 range 0 .. 15;
      Brightness        at 4 range 0 .. 15;
      Color_Temperature at 6 range 0 .. 15;
   end record;

   type Boolean_Array is array (Natural range <>) of Boolean with
     Pack,
     Scalar_Storage_Order => System.Low_Order_First;

   type Frame_Type is record
      Size        : Interfaces.Unsigned_16  := 0;      --  Size of entire message in bytes including this field
      Protocol    : Protocoll_Type := 1024;            --  Protocol number: must be 1024 (decimal)
      Addressable : Boolean        := True;            --  Message includes a target address: must be one (1)
      Is_Tagged   : Boolean        := True;            --  Determines usage of the Frame Address target field
      Origin      : Origin_Type    := 0;               --  Message origin indicator: must be zero (0)
      Source      : Interfaces.Unsigned_32 := 16#61_21_41_F9#; --  Source identifier: unique value set by the client, used by responses
   end record with
      Bit_Order            => System.Low_Order_First,
      Scalar_Storage_Order => System.Low_Order_First,
      Alignment            => 1,
      Write                => Write,
      Read                 => Read;

   for Frame_Type use record
      Size        at 0 range  0 .. 15;
      Protocol    at 2 range  0 .. 11;
      Addressable at 2 range 12 .. 12;
      Is_Tagged   at 2 range 13 .. 13;
      Origin      at 2 range 14 .. 15;
      Source      at 4 range  0 .. 31;
   end record;

   procedure Write (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : Frame_Type);

   procedure Read (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : out Frame_Type);

   type Frame_Address_Type is record
      Target       : Interfaces.Unsigned_64  := 0;     --  6 byte device address (MAC address) or zero (0) means all device
      Reserved_1   : Boolean_Array (1 .. 48) := (others => False);
      Res_Required : Boolean                 := False; --  Response message required
      Ack_Required : Boolean                 := False; --  Acknowledgement message required
      Reserved_2   : Boolean_Array (1 .. 06) := (others => False);
      Sequence     : Interfaces.Unsigned_8   := 0;     --  Wrap around message sequence number
   end record with
      Pack,
      Bit_Order            => System.Low_Order_First,
      Scalar_Storage_Order => System.Low_Order_First,
      Alignment            => 1,
      Write                => Write,
      Read                 => Read;

   procedure Write
     (S    : not null access Ada.Streams.Root_Stream_Type'Class;
      Data : Frame_Address_Type);
   procedure Read
     (S    : not null access Ada.Streams.Root_Stream_Type'Class;
      Data : out Frame_Address_Type);

   type Msg_Kind is new Interfaces.Unsigned_16;

   type Protocol_Header_Type is record
      Reserved_1 : Boolean_Array (1 .. 64) := (others => False);
      Msg_Type   : Msg_Kind   := 0; --  Message type determines the payload being used
      Reserved_2 : Boolean_Array (1 .. 16) := (others => False);
   end record with
      Pack,
      Bit_Order            => System.Low_Order_First,
      Scalar_Storage_Order => System.Low_Order_First,
      Alignment            => 1,
      Write                => Write,
      Read                 => Read;

   procedure Write
     (S    : not null access Ada.Streams.Root_Stream_Type'Class;
      Data : Protocol_Header_Type);
   procedure Read
     (S    : not null access Ada.Streams.Root_Stream_Type'Class;
      Data : out Protocol_Header_Type);

   type Header_Type is record
      Frame           : aliased Frame_Type;
      Frame_Address   : aliased Frame_Address_Type;
      Protocol_Header : aliased Protocol_Header_Type;
   end record with
      Pack;

   type Message is abstract new Ada.Finalization.Controlled with record
      Header : Header_Type;
   end record with
      Pack,
      Input'Class  => Input,
      Output'Class => Output;
   function Image (Item : Message) return String;

   function Input
     (S : not null access Ada.Streams.Root_Stream_Type'Class)
      return Message'Class;

   procedure Output
     (S   : not null access Ada.Streams.Root_Stream_Type'Class;
      Msg : Message'Class);

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return Message is abstract;

   function Image (Item : Ada.Streams.Stream_Element_Array) return String;
   function Image (Item : Boolean) return String is (Item'Img);
   function Image (Item : Boolean_Array) return String;
   function Image (Item : Interfaces.Unsigned_8) return String is (Item'Img);
   function Image (Item : Header_Type; With_Header : Boolean := True) return String;
   function Image (Item : HSBK_Type) return String;
   function Image (Item : Hue_Type) return String is (Item'Img);
   function Image (Item : Origin_Type) return String is (Item'Img);
   function Image (Item : Protocoll_Type) return String is (Item'Img);
   function Image (Item : String) return String;
   function Image (Item : Time_Type) return String;
   function Image (Item : Interfaces.Unsigned_16) return String is (Item'Img);
   function Image (Item : Unsigned_16_Array) return String;
   function Image (Item : Interfaces.Unsigned_32) return String is (Item'Img);
   function Image (Item : Interfaces.Unsigned_64) return String is (Item'Img);
   function Image (Item : Float) return String is (Item'Img);
   function Image (Item : Msg_Kind) return String;

private
   procedure Register_Name (Name : Msg_Kind; Object_Tag : Ada.Tags.Tag);
   Name_To_Tag : array (Msg_Kind) of Ada.Tags.Tag := (others => Ada.Tags.No_Tag);
   function Sequence return Interfaces.Unsigned_8;

end LIFX.Messages;
