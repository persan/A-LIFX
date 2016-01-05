with LIFX.Messages.Constants;
package body LIFX.Messages.GetLabel_Messages is

   -----------------
   -- Constructor --
   -----------------
   procedure Initialize (Msg : in  out GetLabel_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetLabel;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetLabel_Message
   is
      pragma Unreferenced (Params);
   begin
      pragma warnings (off);
      return Ret : GetLabel_Message do
         null;
      end return;
   end Constructor;

   function Create return GetLabel_Message is
   begin
      return Ret : GetLabel_Message do
         Ret.Header.Frame_Address.Res_Required := True;
         Ret.Header.Frame_Address.Ack_Required := False;
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;
begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetLabel , Object_Tag => GetLabel_Message'Tag );
end LIFX.Messages.GetLabel_Messages;
