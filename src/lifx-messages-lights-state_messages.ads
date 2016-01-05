package LIFX.Messages.Lights.State_Messages is
   type State_Message is new Message with record
      color        : HSBK_TYPE;
      Reserved_1    : Uint16;
      Power         : Uint16;
      Label         : String (1 .. 32);
      Reserved_2    : Uint64;
   end record with pack => True;

   function Image ( Item : State_Message ) return String;
   procedure Initialize (Msg : in  out State_Message);
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return State_Message;

   function Create
     (color : HSBK_TYPE; Power : Float ; Label : String)
      return State_Message;

end LIFX.Messages.Lights.State_Messages;