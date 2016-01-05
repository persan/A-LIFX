with LIFX.Messages.Constants;
package body LIFX.Messages.StateWifiFirmware_Messages is

   -----------------
   -- Constructor --
   -----------------

   function Image ( Item : StateWifiFirmware_Message ) return String is
   begin
      return Image (Message (Item)) & ASCII.Lf &
        "Build   => " & Image (Item.Build) & ","  & ASCII.Lf &
        "Version => " & Image (Item.Version);
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateWifiFirmware_Message
   is
   begin
      return Ret : StateWifiFirmware_Message do
         Time_Type'Read (Params, Ret.Build);
         Uint64'Read (Params, Ret.Reserved);
         Uint16_Array'Read (Params, Ret.Version);
      end return;
   end Constructor;


begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateWifiFirmware , Object_Tag => StateWifiFirmware_Message'Tag );
end LIFX.Messages.StateWifiFirmware_Messages;
