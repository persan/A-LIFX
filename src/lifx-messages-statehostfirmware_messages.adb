with LIFX.Messages.Constants;
package body LIFX.Messages.StateHostFirmware_Messages is

   overriding function Image (Item : StateHostFirmware_Message) return String is
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

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateHostFirmware_Message is
   begin
      return Ret : StateHostFirmware_Message do
         Time_Type'Read (Params, Ret.Build);
         Uint64'Read (Params, Ret.Reserved);
         Uint16_Array'Read (Params, Ret.Version);
      end return;
   end Constructor;

begin
   Register_Name
     (Name       => LIFX.Messages.Constants.Device_Messages.StateHostFirmware,
      Object_Tag => StateHostFirmware_Message'Tag);
end LIFX.Messages.StateHostFirmware_Messages;
