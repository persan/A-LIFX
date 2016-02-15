package LIFX.Messages.GetHostInfo_Messages is

   type GetHostInfo_Message is new Message with null record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetHostInfo_Message;

   overriding
   procedure Initialize (Msg : in out GetHostInfo_Message);

   function Create return GetHostInfo_Message;

end LIFX.Messages.GetHostInfo_Messages;
