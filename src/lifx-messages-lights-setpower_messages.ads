package LIFX.Messages.Lights.SetPower_Messages is
   type SetPower_Message is new Message with record
      Level    : Uint16;
      Duration : Uint32;
   end record;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return SetPower_Message;

   overriding

   procedure Initialize (Msg : in out SetPower_Message);

   function Create
     (Level : Float;
      Set_Time : Duration)
      return SetPower_Message;


end LIFX.Messages.Lights.SetPower_Messages;
