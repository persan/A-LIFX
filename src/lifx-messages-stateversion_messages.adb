with LIFX.Messages.Constants;
package body LIFX.Messages.StateVersion_Messages is

   -----------------
   -- Constructor --
   -----------------

   function Image ( Item : StateVersion_Message ) return String is
   begin
      return Image (Message (Item)) & ASCII.Lf &
        "vendor  => " & Image (Item.Vendor) & ","  & ASCII.Lf &
        "product => """ & Image (Item.Product) & """" & ASCII.Lf &
        "version => " & Image (Item.Version);
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateVersion_Message
   is
   begin
      return Ret : StateVersion_Message do
         Uint32'Read   (Params, Ret.Vendor);
         Uint32'Read   (Params, Ret.Product);
         Uint32'Read   (Params, Ret.Version);
      end return;
   end Constructor;


begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateVersion , Object_Tag => StateVersion_Message'Tag );
end LIFX.Messages.StateVersion_Messages;
