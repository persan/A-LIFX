--  http://lan.developer.lifx.com/docs

with Ada.Finalization;
with System;
with Ada.Streams;
with Ada.Tags;
with Ada.Calendar;
package LIFX.Messages is

   type Int16 is range -2**15 .. 2**15 - 1;
   type Byte is mod 2**8;
   type Uint16 is mod 2**16;
   type Uint32 is mod 2**32;
   type Uint64 is mod 2**64;
   type Origin_Type is mod 2**2;
   type Protocoll_Type is mod 2**12;
   type Time_Type is new Uint64;
   type Uint16_Array is array (Natural range <>) of Uint16;


   type Hue_Type is delta 360.0 / (2**15) range 0.0 .. 360.0 - (360.0 / (2**16)) with
        Size => 16;

   function To_Calendar_Time (T : Time_Type) return Ada.Calendar.Time;
   function To_Time_Type (T : Ada.Calendar.Time) return Time_Type;

   type Temperature_Type is new Uint16 range 2500 .. 9000;
   overriding function Image (Item : Temperature_Type) return String is (Item'Img);

   type Saturation_Type is new Uint16;
   --   type Saturation_Type is delta 100.0 / (2 ** 16) range 0.0 .. 100.0 - (100.0 / (2 ** 16));

   type HSBK_Type is record
      Hue               : Hue_Type;
      Saturation        : Saturation_Type;
      Brightness        : Uint16;
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
        Pack                 => True,
        Scalar_Storage_Order => System.Low_Order_First;

   type Frame_Type is record
      Size        : Uint16         := 0;               --  Size of entire message in bytes including this field
      Protocol    : Protocoll_Type := 1024;            --  Protocol number: must be 1024 (decimal)
      Addressable : Boolean        := True;            --  Message includes a target address: must be one (1)
      Is_Tagged   : Boolean        := True;            --  Determines usage of the Frame Address target field
      Origin      : Origin_Type    := 0;               --  Message origin indicator: must be zero (0)
      Source      : Uint32         := 16#61_21_41_F9#; --  Source identifier: unique value set by the client, used by responses
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
      Target       : Uint64                  := 0;     --  6 byte device address (MAC address) or zero (0) means all device
      Reserved_1   : Boolean_Array (1 .. 48) := (others => False);
      Res_Required : Boolean                 := False; --  Response message required
      Ack_Required : Boolean                 := False; --  Acknowledgement message required
      Reserved_2   : Boolean_Array (1 .. 06) := (others => False);
      Sequence     : Byte                    := 0;     --  Wrap around message sequence number
   end record with
      Pack                 => True,
      Bit_Order            => System.Low_Order_First,
      Scalar_Storage_Order => System.Low_Order_First,
      Alignment            => 1,
      Write                => Write,
      Read                 => Read;

   procedure Write (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : Frame_Address_Type);
   procedure Read (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : out Frame_Address_Type);

   type Protocol_Header_Type is record
      Reserved_1 : Boolean_Array (1 .. 64) := (others => False);
      Msg_Type   : Uint16                  := 0; --  Message type determines the payload being used
      Reserved_2 : Boolean_Array (1 .. 16) := (others => False);
   end record with
      Pack                 => True,
      Bit_Order            => System.Low_Order_First,
      Scalar_Storage_Order => System.Low_Order_First,
      Alignment            => 1,
      Write                => Write,
      Read                 => Read;

   procedure Write (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : Protocol_Header_Type);
   procedure Read (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : out Protocol_Header_Type);

   type Header_Type is record
      Frame           : aliased Frame_Type;
      Frame_Address   : aliased Frame_Address_Type;
      Protocol_Header : aliased Protocol_Header_Type;
   end record with
      Pack => True;

   type Message is abstract new Ada.Finalization.Controlled with record
      Header : Header_Type;
   end record with
      Pack         => True,
      Input'Class  => Input,
      Output'Class => Output;
   function Image (Item : Message) return String;

   function Input (S : not null access Ada.Streams.Root_Stream_Type'Class) return Message'Class;

   procedure Output (S : not null access Ada.Streams.Root_Stream_Type'Class; Msg : Message'Class);

   function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return Message is abstract;

   function Image (Item : Ada.Streams.Stream_Element_Array) return String;
   function Image (Item : Boolean) return String is (Item'Img);
   function Image (Item : Boolean_Array) return String;
   function Image (Item : Byte) return String is (Item'Img);
   function Image (Item : Header_Type; With_Header : Boolean := False) return String;
   function Image (Item : HSBK_Type) return String;
   function Image (Item : Hue_Type) return String is (Item'Img);
   function Image (Item : Origin_Type) return String is (Item'Img);
   function Image (Item : Protocoll_Type) return String is (Item'Img);
   function Image (Item : String) return String;
   function Image (Item : Time_Type) return String;
   function Image (Item : Uint16) return String is (Item'Img);
   function Image (Item : Uint16_Array) return String;
   function Image (Item : Uint32) return String is (Item'Img);
   function Image (Item : Uint64) return String is (Item'Img);

private
   procedure Register_Name (Name : Uint16; Object_Tag : Ada.Tags.Tag);
   Name_To_Tag : array (Uint16) of Ada.Tags.Tag := (others => Ada.Tags.No_Tag);
   function Sequence return Byte;
end LIFX.Messages;
