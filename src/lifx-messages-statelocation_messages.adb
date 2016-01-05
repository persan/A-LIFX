with LIFX.Messages.Constants;
package body LIFX.Messages.StateLocation_Messages is

   -----------------
   -- Constructor --
   -----------------
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateLocation_Message
   is
   begin
      return Ret : StateLocation_Message do
         String'Read (Params, Ret.Location);
         String'Read (Params, Ret.Label);
         Time_Type'Read (Params, Ret.Updated_At);
      end return;
   end Constructor;

   function Image ( Item : StateLocation_Message ) return String is
   begin
      return Image (Message (Item)) & ASCII.Lf &
        " Location   => """ & Image (Item.Location) & """"  & ASCII.Lf &
        " Label      => """ & Image (Item.Label) & """" & ASCII.Lf &
        " Updated_At => " & Image (Item.Updated_At) & "";
   end;
begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateLocation , Object_Tag => StateLocation_Message'Tag );
end LIFX.Messages.StateLocation_Messages;
