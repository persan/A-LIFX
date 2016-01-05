package LIFX.Messages.Lights.StatePower_Messages is
   type StatePower_Message is new Message with record
      Level : Uint16;
   end record with
      Pack => True;

   overriding function Image (Item : StatePower_Message) return String;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StatePower_Message;

   function Create (Level : Float) return StatePower_Message;

end LIFX.Messages.Lights.StatePower_Messages;
