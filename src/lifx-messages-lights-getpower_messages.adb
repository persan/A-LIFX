with LIFX.Messages.Constants;
package body LIFX.Messages.Lights.GetPower_Messages is

   -----------------
   -- Constructor --
   -----------------
   procedure Initialize (Msg : in  out GetPower_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Light_Messages.Get;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetPower_Message
   is
      pragma Unreferenced (Params);
   begin
      pragma warnings (off);
      return Ret : GetPower_Message do
         null;
      end return;
   end Constructor;

   function Create return GetPower_Message is
   begin
      return Ret : GetPower_Message do
         Ret.Header.Frame_Address.Res_Required := True;
         Ret.Header.Frame_Address.Ack_Required := False;
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;
begin
   Register_Name (Name => LIFX.Messages.Constants.Light_Messages.GetPower , Object_Tag => GetPower_Message'Tag );

end LIFX.Messages.Lights.GetPower_Messages;
