package LIFX.Messages.StateInfo_Messages is
   type StateInfo_Message is new Message with record
      Time     : Time_Type;
      Uptime   : Time_Type;
      Downtime : Time_Type;
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateInfo_Message;

   overriding
   procedure Initialize
     (Msg : in out StateInfo_Message);

   overriding
   function Image (Item : StateInfo_Message) return String;

   not overriding
   function Create
     (Src      : Message'Class;
      Time     : Time_Type;
      Uptime   : Time_Type;
      Downtime : Time_Type)
      return StateInfo_Message;

end LIFX.Messages.StateInfo_Messages;
