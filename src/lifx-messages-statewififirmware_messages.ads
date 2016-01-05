with Ada.Streams;
use Ada.Streams;
package LIFX.Messages.StateWifiFirmware_Messages is
   type StateWifiFirmware_Message is new Message with record
      Build    : Time_Type;
      Reserved : Uint64;
      Version  : Uint16_Array (1 .. 2);
   end record;

   overriding function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateWifiFirmware_Message;

   overriding function Image (Item : StateWifiFirmware_Message) return String;

end LIFX.Messages.StateWifiFirmware_Messages;
