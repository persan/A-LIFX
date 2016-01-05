with LIFX.Messages.Constants;
package body LIFX.Messages.SetPower_Messages is

   -----------------
   -- Constructor --
   -----------------
   procedure Initialize (Msg : in  out SetPower_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Light_Messages.SetPower;
      Msg.Header.Frame.Size := Msg.Header'Size / 8 +2;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return SetPower_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : SetPower_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;

   function Create
     (Level : Float)
      return SetPower_Message is
   begin
      return Ret : SetPower_Message do
         Ret.Level := Uint16 (Float (Uint16'Last) * Level);
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.SetPower , Object_Tag => SetPower_Message'Tag );
end LIFX.Messages.SetPower_Messages;
