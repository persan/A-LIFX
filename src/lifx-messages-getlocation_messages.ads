package LIFX.Messages.GetLocation_Messages is
   type GetLocation_Message is new Message with null record;
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetLocation_Message;
   overriding
   procedure Initialize (Msg : in  out GetLocation_Message);
   function Create return GetLocation_Message;

end LIFX.Messages.GetLocation_Messages;
