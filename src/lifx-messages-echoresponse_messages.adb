with LIFX.Messages.Constants;
package body LIFX.Messages.EchoResponse_Messages is

   -----------------
   -- Constructor --
   -----------------
   overriding procedure Initialize (Msg : in out EchoResponse_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.SetLabel;
      Msg.Header.Frame.Size               := Msg.Header'Size / 8 + 64;
   end Initialize;

   overriding function Image (Item : EchoResponse_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF & "Label    => """ & Item.Label & """";
   end Image;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return EchoResponse_Message is
      pragma Unreferenced (Params);
   begin
      return Ret : EchoResponse_Message do
         pragma Warnings (Off, Ret);
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end Constructor;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.EchoResponse, Object_Tag => EchoResponse_Message'Tag);
end LIFX.Messages.EchoResponse_Messages;
