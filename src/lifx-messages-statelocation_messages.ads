package LIFX.Messages.StateLocation_Messages is
   type StateLocation_Message is new Message with record
      Location   : String (1 .. 16);
      Label      : String (1 .. 32);
      Updated_At : Time_Type;
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateLocation_Message;

   overriding
   procedure Initialize
     (Msg : in out StateLocation_Message);

   overriding
   function Image (Item : StateLocation_Message) return String;

   function Create
     (Src      : Message'Class;
      Location   : String;
      Label      : String;
      Updated_At : Time_Type)
      return StateLocation_Message;

end LIFX.Messages.StateLocation_Messages;
