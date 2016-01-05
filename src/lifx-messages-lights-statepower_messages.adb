with LIFX.Messages.Constants;
package body LIFX.Messages.Lights.StatePower_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StatePower_Message is
   begin
      return Ret : StatePower_Message do
         Uint16'Read (Params, Ret.Level);
      end return;
   end Constructor;

   overriding function Image (Item : StatePower_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF & "level => " & Item.Level'Img;
   end Image;

   function Create (Level : Float) return StatePower_Message is
   begin
      return Ret : StatePower_Message do
         Ret.Level := Uint16 (Float (Uint16'Last) * Level);
      end return;
   end Create;

begin
   LIFX.Messages.Register_Name (LIFX.Messages.Constants.Light_Messages.StatePower, StatePower_Message'Tag);
end LIFX.Messages.Lights.StatePower_Messages;
