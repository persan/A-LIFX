package LIFX.Messages.StateVersion_Messages is
   type StateVersion_Message is new Message with record
      Vendor  : Interfaces.Unsigned_32;
      Product : Interfaces.Unsigned_32;
      Version : Interfaces.Unsigned_32;
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateVersion_Message;

   overriding
   procedure Initialize
     (Msg : in out StateVersion_Message);

   overriding
   function Image (Item : StateVersion_Message) return String;

   function Create
     (Src      : Message'Class;
      Vendor  : Interfaces.Unsigned_32;
      Product : Interfaces.Unsigned_32;
      Version : Interfaces.Unsigned_32)
      return StateVersion_Message;

end LIFX.Messages.StateVersion_Messages;
