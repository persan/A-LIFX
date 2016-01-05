package LIFX.Messages.Lights.StatePower_Messages is
   type StatePower_Message is new Message with record
      Level         : Uint16;
   end record with pack => True;

   function Image ( Item : StatePower_Message ) return String;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StatePower_Message;

   function Create
     (Level : Float)
      return StatePower_Message;

end LIFX.Messages.Lights.StatePower_Messages;
