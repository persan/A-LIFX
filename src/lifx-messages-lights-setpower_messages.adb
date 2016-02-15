with LIFX.Messages.Constants;
package body LIFX.Messages.Lights.SetPower_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return SetPower_Message is
      pragma Unreferenced (Params);
   begin
      return Ret : SetPower_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;

   overriding
   procedure Initialize (Msg : in out SetPower_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Light_Messages.SetPower;
      Msg.Header.Frame.Size               := Msg.Header'Size / 8;
   end Initialize;

   overriding
   function Image (Item : SetPower_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "Level    => " & Image (Item.Level) & "," & ASCII.LF &
        "Duration => " & Image (Item.Duration);
   end Image;

   function Create (Level : Float; Set_Time : Duration) return SetPower_Message is
   begin
      return Ret : SetPower_Message do
         Ret.Level                             := Interfaces.Unsigned_16 (Float (Interfaces.Unsigned_16'Last) * Level);
         Ret.Duration                          := Interfaces.Unsigned_32 (Set_Time * 1_000.0);
         Ret.Header.Frame_Address.Sequence     := Sequence;
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Light_Messages.SetPower, Object_Tag => SetPower_Message'Tag);
end LIFX.Messages.Lights.SetPower_Messages;
