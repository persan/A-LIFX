package LIFX.Messages.GetInfo_Messages is
   type GetInfo_Message is new Message with null record;
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetInfo_Message;
   overriding
   procedure Initialize (Msg : in  out GetInfo_Message);
   function Create return GetInfo_Message;

end LIFX.Messages.GetInfo_Messages;
