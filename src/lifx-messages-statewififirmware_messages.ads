with Ada.Streams;
use Ada.Streams;
package LIFX.Messages.StateWifiFirmware_Messages is

   type StateWifiFirmware_Message is new Message with record
      Build    : Time_Type;
      Reserved : Interfaces.Unsigned_64;
      Version  : Unsigned_16_Array (1 .. 2);
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateWifiFirmware_Message;

   overriding
   procedure Initialize
     (Msg : in out StateWifiFirmware_Message);

   overriding
   function Image (Item : StateWifiFirmware_Message) return String;

   function Create
     (Src      : Message'Class;
      Build    : Time_Type;
      Version  : Unsigned_16_Array)
      return StateWifiFirmware_Message;

end LIFX.Messages.StateWifiFirmware_Messages;
