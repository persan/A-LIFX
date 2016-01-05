package LIFX.Messages.StateHostFirmware_Messages is
   type StateHostFirmware_Message is new Message with record
      Build    : Time_Type;
      Reserved : Uint64;
      Version  : Uint16_Array(1..2);
   end record;

   overriding function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateHostFirmware_Message;
   overriding function Image ( Item : StateHostFirmware_Message ) return String;

end LIFX.Messages.StateHostFirmware_Messages;
