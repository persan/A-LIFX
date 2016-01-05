with LIFX.Messages.Constants;
package body LIFX.Messages.StateInfo_Messages is

   -----------------
   -- Constructor --
   -----------------
   function Image ( Item : StateInfo_Message ) return String is
   begin
      return Image (Message (Item)) & ASCII.Lf &
        "Time     => " & image(Item.Time) & ","& ASCII.Lf &
        "Uptime   => " & image(Item.Uptime) & "," & ASCII.Lf &
        "Downtime => " & image(Item.Downtime) ;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateInfo_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : StateInfo_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;


begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateInfo , Object_Tag => StateInfo_Message'Tag );
end LIFX.Messages.StateInfo_Messages;
