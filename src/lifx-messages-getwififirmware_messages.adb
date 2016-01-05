with LIFX.Messages.Constants;
package body LIFX.Messages.GetWifiFirmware_Messages is

   -----------------
   -- Constructor --
   -----------------

   procedure Initialize (Msg : in  out GetWifiFirmware_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetWifiFirmware;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetWifiFirmware_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : GetWifiFirmware_Message do
         null;
      end return;
   end Constructor;

   function Create return GetWifiFirmware_Message is
   begin
      return Ret : GetWifiFirmware_Message do
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetWifiFirmware , Object_Tag => GetWifiFirmware_Message'Tag );
end LIFX.Messages.GetWifiFirmware_Messages;
