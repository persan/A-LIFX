package LIFX.Messages.GetLabel_Messages is

   type GetLabel_Message is new Message with null record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetLabel_Message;

   overriding
   procedure Initialize (Msg : in out GetLabel_Message);

   function Create return GetLabel_Message;

end LIFX.Messages.GetLabel_Messages;
