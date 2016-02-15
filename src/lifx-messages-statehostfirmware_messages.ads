package LIFX.Messages.StateHostFirmware_Messages is
   type StateHostFirmware_Message is new Message with record
      Build    : Time_Type;
      Reserved : Interfaces.Unsigned_64 := 0;
      Version  : Unsigned_16_Array (1 .. 2);
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateHostFirmware_Message;

   overriding
   procedure Initialize
     (Msg : in out StateHostFirmware_Message);

   overriding
   function Image (Item : StateHostFirmware_Message) return String;

   function Create
     (Src      : Message'Class;
      Build    : Time_Type;
      Version  : Unsigned_16_Array) return StateHostFirmware_Message;

end LIFX.Messages.StateHostFirmware_Messages;
