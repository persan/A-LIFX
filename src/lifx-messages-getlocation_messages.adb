with LIFX.Messages.Constants;
package body LIFX.Messages.GetLocation_Messages is

   -----------------
   -- Constructor --
   -----------------
   procedure Initialize (Msg : in  out GetLocation_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetLocation;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetLocation_Message
   is
      pragma Unreferenced (Params);
   begin
      pragma warnings (off);
      return Ret : GetLocation_Message do
         null;
      end return;
   end Constructor;

   function Create return GetLocation_Message is
   begin
      return Ret : GetLocation_Message do
         Ret.Header.Frame_Address.Res_Required := True;
         Ret.Header.Frame_Address.Ack_Required := False;
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;
begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetLocation , Object_Tag => GetLocation_Message'Tag );
end LIFX.Messages.GetLocation_Messages;
