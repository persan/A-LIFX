package LIFX.Messages.Lights.Get_Messages is

   type Get_Message is new Message with null record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return Get_Message;

   overriding
   procedure Initialize (Msg : in out Get_Message);

   function Create return Get_Message;

end LIFX.Messages.Lights.Get_Messages;
