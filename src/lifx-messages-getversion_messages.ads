package LIFX.Messages.GetVersion_Messages is

   type GetVersion_Message is new Message with null record;
   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetVersion_Message;

   overriding
   procedure Initialize (Msg : in  out GetVersion_Message);
   function create return GetVersion_Message;

end LIFX.Messages.GetVersion_Messages;
