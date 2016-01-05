package LIFX.Messages.GetService_Messages is

   type GetService_Message is new Message with null record;
   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetService_Message;

   overriding
   procedure Initialize (Msg : in  out GetService_Message);
   function create return GetService_Message;

end LIFX.Messages.GetService_Messages;
