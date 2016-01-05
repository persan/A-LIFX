package LIFX.Messages.StateVersion_Messages is
   type StateVersion_Message is new Message with record
      Vendor  : Uint32;
      Product : Uint32;
      Version : Uint32;
   end record;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateVersion_Message;

   overriding function Image (Item : StateVersion_Message) return String;

end LIFX.Messages.StateVersion_Messages;
