with LIFX.Messages.Constants;
with Ada.Strings.Fixed;
package body LIFX.Messages.SetLabel_Messages is

   -----------------
   -- Constructor --
   -----------------
   procedure Initialize (Msg : in  out SetLabel_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.SetLabel;
      Msg.Header.Frame.Size := Msg.Header'Size / 8 + 32;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return SetLabel_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : SetLabel_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;

   function Create (Label : String) return SetLabel_Message is
   begin
      return Ret : SetLabel_Message do
         Ada.Strings.Fixed.Move (Source => Label, Target => Ret.Label);
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.SetLabel , Object_Tag => SetLabel_Message'Tag );
end LIFX.Messages.SetLabel_Messages;
