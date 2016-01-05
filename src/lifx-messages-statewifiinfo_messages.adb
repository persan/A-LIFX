with LIFX.Messages.Constants;
package body LIFX.Messages.StateWifiInfo_Messages is

   -----------------
   -- Constructor --
   -----------------

   function Image ( Item : StateWifiInfo_Message ) return String is
   begin
      return Image (Message (Item)) & ASCII.Lf &
        "Signal => " & Item.Signal'img & ","  & ASCII.Lf &
        "Tx     => " & Image(Item.Tx) & "," & ASCII.Lf &
        "Rx     => " & Image(Item.Rx);
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateWifiInfo_Message
   is
   begin
      return Ret : StateWifiInfo_Message do
         Float'Read (Params, Ret.Signal);
         Uint32'Read (Params, Ret.Tx);
         Uint32'Read (Params, Ret.Rx);
         Short_Integer'Read (Params, Ret.Reserved);
      end return;
   end Constructor;


begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateWifiInfo , Object_Tag => StateWifiInfo_Message'Tag );
end LIFX.Messages.StateWifiInfo_Messages;
