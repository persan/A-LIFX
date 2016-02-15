package LIFX.Messages.SetPower_Messages is
   type SetPower_Message is new Message with record
      Level : Interfaces.Unsigned_16;
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return SetPower_Message;

   overriding
   procedure Initialize
     (Msg : in out SetPower_Message);

   overriding
   function Image (Item : SetPower_Message) return String;

   function Create (Level : Float) return SetPower_Message;

end LIFX.Messages.SetPower_Messages;
