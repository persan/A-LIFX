package LIFX.Messages.GetWifiInfo_Messages is

   type GetWifiInfo_Message is new Message with null record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetWifiInfo_Message;

   overriding
   procedure Initialize (Msg : in out GetWifiInfo_Message);

   function create return GetWifiInfo_Message;

end LIFX.Messages.GetWifiInfo_Messages;
