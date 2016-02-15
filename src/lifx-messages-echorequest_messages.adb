with LIFX.Messages.Constants;
with Ada.Streams;
use Ada.Streams;
package body LIFX.Messages.EchoRequest_Messages is

   -----------------
   -- Constructor --
   -----------------
   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return EchoRequest_Message is
      pragma Unreferenced (Params);
   begin
      return Ret : EchoRequest_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;

   overriding
   procedure Initialize (Msg : in out EchoRequest_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.EchoRequest;
      Msg.Header.Frame.Size               := Msg.Header'Size / 8 + 64;
   end Initialize;

   overriding function Image (Item : EchoRequest_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "Payload    => " & Image (Item.Payload);
   end Image;

   function Create
     (Payload : Ada.Streams.Stream_Element_Array)
      return EchoRequest_Message is
   begin
      return Ret : EchoRequest_Message do
         Ret.Header.Frame_Address.Sequence := Sequence;
         Ret.Payload
           (Ret.Payload'First .. Ret.Payload'First + Stream_Element_Offset'Min (Ret.Payload'Length, Payload'Length)) :=
             Payload (Payload'First .. Payload'First + Stream_Element_Offset'Min (Ret.Payload'Length, Payload'Length));
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.EchoRequest,
                  Object_Tag => EchoRequest_Message'Tag);
end LIFX.Messages.EchoRequest_Messages;
