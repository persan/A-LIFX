with LIFX.Messages.Constants;
package body LIFX.Messages.Lights.SetColor_Messages is

   -----------------
   -- Constructor --
   -----------------
   procedure Initialize (Msg : in  out SetColor_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Light_Messages.SetColor;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return SetColor_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : SetColor_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;

   function Create
     (Color : HSBK_Type; Duration : Standard.Duration)
      return SetColor_Message is
   begin
      return Ret : SetColor_Message do
         Ret.Color := Color;
         Ret.Duration := Uint32 (Duration * 1000.0);
         Ret.Header.Frame_Address.Res_Required := True;
         Ret.Header.Frame_Address.Ack_Required := False;
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Light_Messages.SetColor , Object_Tag => SetColor_Message'Tag );
end LIFX.Messages.Lights.SetColor_Messages;
