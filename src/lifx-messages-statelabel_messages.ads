package LIFX.Messages.StateLabel_Messages is
   type StateLabel_Message is new Message with record
      Label : String (1 .. 32);
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateLabel_Message;

   overriding
   procedure Initialize
     (Msg : in out StateLabel_Message);

   overriding
   function Image (Item : StateLabel_Message) return String;

   not overriding
   function Create
     (Src      : Message'Class;
      Label : String)
      return StateLabel_Message;

end LIFX.Messages.StateLabel_Messages;
