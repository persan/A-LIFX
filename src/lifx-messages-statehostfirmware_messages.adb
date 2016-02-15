with LIFX.Messages.Constants;
package body LIFX.Messages.StateHostFirmware_Messages is

   overriding function Image (Item : StateHostFirmware_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "Build   => " & Image (Item.Build) &  "," & ASCII.LF &
        "Version => " & Image (Item.Version);
   end Image;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateHostFirmware_Message is
   begin
      return Ret : StateHostFirmware_Message do
         Time_Type'Read (Params, Ret.Build);
         Interfaces.Unsigned_64'Read (Params, Ret.Reserved);
         Unsigned_16_Array'Read (Params, Ret.Version);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateHostFirmware_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateHostFirmware;
      Msg.Header.Frame.Size               := StateHostFirmware_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   function Create
     (Src      : Message'Class;
      Build    : Time_Type;
      Version  : Unsigned_16_Array) return StateHostFirmware_Message is
   begin
      return Ret : StateHostFirmware_Message do
         Ret.Header.Frame_Address.Sequence :=  Src.Header.Frame_Address.Sequence;
         Ret.Build := Build;
         Ret.Version := Version;
      end return;
   end Create;

begin
   Register_Name
     (Name       => LIFX.Messages.Constants.Device_Messages.StateHostFirmware,
      Object_Tag => StateHostFirmware_Message'Tag);
end LIFX.Messages.StateHostFirmware_Messages;
