package LIFX.Messages.GetPower_Messages is
   type GetPower_Message is new Message with null record;
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetPower_Message;
   overriding
   procedure Initialize (Msg : in  out GetPower_Message);
   function Create return GetPower_Message;

end LIFX.Messages.GetPower_Messages;
