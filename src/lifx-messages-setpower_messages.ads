package LIFX.Messages.SetPower_Messages is
   type SetPower_Message is new Message with record
      Level : Uint16;
   end record;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return SetPower_Message;
   overriding
 procedure Initialize (Msg : in out SetPower_Message);
   function Create (Level : Float) return SetPower_Message;

end LIFX.Messages.SetPower_Messages;
