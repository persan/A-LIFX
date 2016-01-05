package LIFX.Messages.StateWifiInfo_Messages is
   type StateWifiInfo_Message is new Message with record
      Signal   : Float;
      Tx       : Uint32;
      Rx       : Uint32;
      Reserved : Short_Integer;
   end record;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateWifiInfo_Message;

   overriding function Image (Item : StateWifiInfo_Message) return String;

end LIFX.Messages.StateWifiInfo_Messages;
