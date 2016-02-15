package LIFX.Messages.Lights.State_Messages is
   type State_Message is new Message with record
      Color      : HSBK_Type;
      Reserved_1 : Interfaces.Unsigned_16;
      Power      : Interfaces.Unsigned_16;
      Label      : String (1 .. 32);
      Reserved_2 : Interfaces.Unsigned_64;
   end record with
     Pack => True;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
        return State_Message;

   overriding
   procedure Initialize (Msg : in out State_Message);

   overriding
   function Image (Item : State_Message) return String;

   function Create
     (Src          : Message'Class;
      Color        : HSBK_Type;
      Power        : Float;
      Label        : String)
      return State_Message;

end LIFX.Messages.Lights.State_Messages;
