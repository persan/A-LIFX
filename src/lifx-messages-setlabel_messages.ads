package LIFX.Messages.SetLabel_Messages is
   type SetLabel_Message is new Message with record
      Label : String (1 .. 32);
   end record;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return SetLabel_Message;
   overriding procedure Initialize (Msg : in out SetLabel_Message);
   function Create (Label : String) return SetLabel_Message;
end LIFX.Messages.SetLabel_Messages;
