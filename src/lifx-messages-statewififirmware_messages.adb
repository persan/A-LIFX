with LIFX.Messages.Constants;
package body LIFX.Messages.StateWifiFirmware_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Image (Item : StateWifiFirmware_Message) return String is
   begin
      return Image (Message (Item)) &
        ASCII.LF &
        "Build   => " &
        Image (Item.Build) &
        "," &
        ASCII.LF &
        "Version => " &
        Image (Item.Version);
   end Image;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateWifiFirmware_Message is
   begin
      return Ret : StateWifiFirmware_Message do
         Time_Type'Read (Params, Ret.Build);
         Uint64'Read (Params, Ret.Reserved);
         Uint16_Array'Read (Params, Ret.Version);
      end return;
   end Constructor;

begin
   Register_Name
     (Name       => LIFX.Messages.Constants.Device_Messages.StateWifiFirmware,
      Object_Tag => StateWifiFirmware_Message'Tag);
end LIFX.Messages.StateWifiFirmware_Messages;
