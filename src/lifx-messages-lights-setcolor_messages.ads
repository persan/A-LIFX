package LIFX.Messages.Lights.SetColor_Messages is
   type SetColor_Message is new Message with record
      Reserved : Byte;
      Color    : HSBK_Type;
      Duration : Uint32;
   end record;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return SetColor_Message;
   overriding
 procedure Initialize (Msg : in out SetColor_Message);
   function Create (Color : HSBK_Type; Duration : Standard.Duration) return SetColor_Message;

end LIFX.Messages.Lights.SetColor_Messages;
