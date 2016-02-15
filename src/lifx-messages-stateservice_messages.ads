package LIFX.Messages.StateService_Messages is

   type StateService_Message is new Message with record
      Service : Interfaces.Unsigned_8;
      Port    : Interfaces.Unsigned_32;
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateService_Message;

   overriding
   procedure Initialize
     (Msg : in out StateService_Message);

   overriding
   function Image (Item : StateService_Message) return String;

   function Create
     (Src      : Message'Class;
      Service : Interfaces.Unsigned_8;
      Port    : GNAT.Sockets.Port_Type)
      return StateService_Message;

end LIFX.Messages.StateService_Messages;
