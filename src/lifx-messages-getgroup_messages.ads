package LIFX.Messages.GetGroup_Messages is

   type GetGroup_Message is new Message with null record;
   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return GetGroup_Message;

   overriding procedure Initialize (Msg : in out GetGroup_Message);
   function create return GetGroup_Message;

end LIFX.Messages.GetGroup_Messages;
