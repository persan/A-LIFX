package LIFX.Messages.Lights.GetPower_Messages is

   type GetPower_Message is new Message with null record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetPower_Message;

   overriding
   procedure Initialize (Msg : in out GetPower_Message);

   function Create return GetPower_Message;

end LIFX.Messages.Lights.GetPower_Messages;
