with LIFX.Messages.Constants;
package body LIFX.Messages.StatePower_Messages is

   -----------------
   -- Constructor --
   -----------------

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StatePower_Message
   is
   begin
      return Ret : StatePower_Message do
         Uint16'Read (Params, Ret.level);
      end return;
   end Constructor;

   function Image ( Item : StatePower_Message ) return String is
   begin
      return Image (Message (Item)) & ASCII.Lf &
        "level => " & Item.level'img;
   end;

begin
   LIFX.Messages.Register_Name (LIFX.Messages.Constants.Device_Messages.StatePower,StatePower_Message'Tag);
end LIFX.Messages.StatePower_Messages;
