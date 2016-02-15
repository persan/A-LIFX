package LIFX.Messages.StateGroup_Messages is
   type StateGroup_Message is new Message with record
      Group      : String (1 .. 16);
      Label      : String (1 .. 32);
      Updated_At : Time_Type;
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateGroup_Message;

   overriding
   procedure Initialize
     (Msg : in out StateGroup_Message);

   overriding
   function Image (Item : StateGroup_Message) return String;

   function Create
     (Src        : Message'Class;
      Group      : String;
      Label      : String;
      Updated_At : Time_Type) return StateGroup_Message;

end LIFX.Messages.StateGroup_Messages;
