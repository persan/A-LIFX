package LIFX.Messages.StateGroup_Messages is
   type StateGroup_Message is new Message with record
      Group      : Ada.Streams.Stream_Element_Array (1 .. 16);
      Label      : String (1 .. 32);
      Updated_At : Time_Type;
   end record;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateGroup_Message;
   overriding function Image (Item : StateGroup_Message) return String;

end LIFX.Messages.StateGroup_Messages;
