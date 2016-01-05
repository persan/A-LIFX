package LIFX.Messages.StateService_Messages is
   type StateService_Message is new Message with record
      Service : Byte;
      Port    : Uint32;
   end record;
   overriding function Image (Item : StateService_Message) return String;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateService_Message;
end LIFX.Messages.StateService_Messages;
