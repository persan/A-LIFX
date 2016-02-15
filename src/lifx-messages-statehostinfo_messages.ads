package LIFX.Messages.StateHostInfo_Messages is

   type StateHostInfo_Message is new Message with record
      Signal   : Float;
      Tx       : Interfaces.Unsigned_32;
      Rx       : Interfaces.Unsigned_32;
      Reserved : Interfaces.Integer_16;
   end record with
     Pack => True;

   overriding

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateHostInfo_Message;

   overriding
   procedure Initialize
     (Msg : in out StateHostInfo_Message);

   overriding
   function Image (Item : StateHostInfo_Message) return String;

   function Create
     (Src      : Message'Class;
      Signal   : Float;
      Tx       : Interfaces.Unsigned_32;
      Rx       : Interfaces.Unsigned_32)
      return StateHostInfo_Message;

end LIFX.Messages.StateHostInfo_Messages;
