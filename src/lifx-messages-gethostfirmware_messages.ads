package LIFX.Messages.GetHostFirmware_Messages is

   type GetHostFirmware_Message is new Message with null record;
   overriding function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class) return GetHostFirmware_Message;

   overriding procedure Initialize (Msg : in out GetHostFirmware_Message);
   function create return GetHostFirmware_Message;

end LIFX.Messages.GetHostFirmware_Messages;
