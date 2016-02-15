package LIFX.Messages.StateWifiInfo_Messages is
   type StateWifiInfo_Message is new Message with record
      Signal   : Float;
      Tx       : Interfaces.Unsigned_32;
      Rx       : Interfaces.Unsigned_32;
      Reserved : Short_Integer;
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateWifiInfo_Message;

   overriding
   procedure Initialize
     (Msg : in out StateWifiInfo_Message);

   overriding
   function Image (Item : StateWifiInfo_Message) return String;

   function Create
     (Src      : Message'Class;
      Signal   : Float;
      Tx       : Interfaces.Unsigned_32;
      Rx       : Interfaces.Unsigned_32)
      return StateWifiInfo_Message;

end LIFX.Messages.StateWifiInfo_Messages;
