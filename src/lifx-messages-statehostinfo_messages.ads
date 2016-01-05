package LIFX.Messages.StateHostInfo_Messages is
   type StateHostInfo_Message is new Message with record
      Signal         : Float;
      Tx             : Uint32;
      Rx             : Uint32;
      Reserved       : Int16;
   end record with Pack => True;

   function Image ( Item : StateHostInfo_Message ) return String;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateHostInfo_Message;

end LIFX.Messages.StateHostInfo_Messages;
