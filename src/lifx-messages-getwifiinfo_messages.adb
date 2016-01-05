with LIFX.Messages.Constants;
package body LIFX.Messages.GetWifiInfo_Messages is

   -----------------
   -- Constructor --
   -----------------

   procedure Initialize (Msg : in  out GetWifiInfo_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetWifiInfo;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetWifiInfo_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : GetWifiInfo_Message do
         null;
      end return;
   end Constructor;

   function Create return GetWifiInfo_Message is
   begin
      return Ret : GetWifiInfo_Message do
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetWifiInfo , Object_Tag => GetWifiInfo_Message'Tag );
end LIFX.Messages.GetWifiInfo_Messages;
