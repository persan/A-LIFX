with LIFX.Messages.Constants;
with Ada.Strings.Fixed;
package body LIFX.Messages.SetLabel_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return SetLabel_Message is
      pragma Unreferenced (Params);
   begin
      return Ret : SetLabel_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out SetLabel_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.SetLabel;
      Msg.Header.Frame.Size               := SetLabel_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   overriding function Image (Item : SetLabel_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "Label    => " & Image (Item.Label);
   end Image;

   function Create (Label : String) return SetLabel_Message is
   begin
      return Ret : SetLabel_Message do
         Ada.Strings.Fixed.Move (Source => Label, Target => Ret.Label);
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.SetLabel, Object_Tag => SetLabel_Message'Tag);
end LIFX.Messages.SetLabel_Messages;
