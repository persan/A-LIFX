with LIFX.Messages.Constants;
package body LIFX.Messages.GetHostFirmware_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding procedure Initialize (Msg : in out GetHostFirmware_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetHostFirmware;
      Msg.Header.Frame.Size               := Msg.Header'Size / 8;
   end Initialize;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return GetHostFirmware_Message is
      pragma Unreferenced (Params);
   begin
      return Ret : GetHostFirmware_Message do
         null;
      end return;
   end Constructor;

   function create return GetHostFirmware_Message is
   begin
      return Ret : GetHostFirmware_Message do
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetHostFirmware, Object_Tag => GetHostFirmware_Message'Tag);
end LIFX.Messages.GetHostFirmware_Messages;
