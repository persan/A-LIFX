package LIFX.Messages.StatePower_Messages is
   type StatePower_Message is new Message with record
      Level : Interfaces.Unsigned_16;
   end record with
      Pack => True;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StatePower_Message;

   overriding
   procedure Initialize
     (Msg : in out StatePower_Message);

   overriding
   function Image (Item : StatePower_Message) return String;

   function Create
     (Src      : Message'Class;
      Level : Interfaces.Unsigned_16)
      return StatePower_Message;

end LIFX.Messages.StatePower_Messages;
