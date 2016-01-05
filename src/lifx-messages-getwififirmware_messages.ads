package LIFX.Messages.GetWifiFirmware_Messages is

   type GetWifiFirmware_Message is new Message with null record;
   overriding function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class) return GetWifiFirmware_Message;

   overriding procedure Initialize (Msg : in out GetWifiFirmware_Message);
   function create return GetWifiFirmware_Message;

end LIFX.Messages.GetWifiFirmware_Messages;
