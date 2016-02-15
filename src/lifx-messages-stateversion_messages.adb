with LIFX.Messages.Constants;
package body LIFX.Messages.StateVersion_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Image (Item : StateVersion_Message) return String is
   begin
      return Image (Message (Item)) &  ASCII.LF &
        "vendor  => " &  Image (Item.Vendor) &  "," &   ASCII.LF &
        "product => " &  Image (Item.Product) & "," &  ASCII.LF &
        "version => " &  Image (Item.Version);
   end Image;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateVersion_Message is
   begin
      return Ret : StateVersion_Message do
         Interfaces.Unsigned_32'Read (Params, Ret.Vendor);
         Interfaces.Unsigned_32'Read (Params, Ret.Product);
         Interfaces.Unsigned_32'Read (Params, Ret.Version);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateVersion_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateVersion;
      Msg.Header.Frame.Size               := StateVersion_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   function Create
     (Src      : Message'Class;
      Vendor   : Interfaces.Unsigned_32;
      Product  : Interfaces.Unsigned_32;
      Version  : Interfaces.Unsigned_32)
      return StateVersion_Message is
   begin
      return Ret : StateVersion_Message do
         Ret.Header.Frame_Address.Sequence :=  Src.Header.Frame_Address.Sequence;
         Ret.Vendor := Vendor;
         Ret.Product := Product;
         Ret.Version := Version;
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateVersion, Object_Tag => StateVersion_Message'Tag);
end LIFX.Messages.StateVersion_Messages;
