with LIFX.Messages.Constants;
package body LIFX.Messages.StateInfo_Messages is

   -----------------
   -- Constructor --
   -----------------
   overriding function Image (Item : StateInfo_Message) return String is
   begin
      return Image (Message (Item)) &
        ASCII.LF &
        "Time     => " &
        Image (Item.Time) &
        "," &
        ASCII.LF &
        "Uptime   => " &
        Image (Item.Uptime) &
        "," &
        ASCII.LF &
        "Downtime => " &
        Image (Item.Downtime);
   end Image;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateInfo_Message is
      pragma Unreferenced (Params);
   begin
      return Ret : StateInfo_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateInfo, Object_Tag => StateInfo_Message'Tag);
end LIFX.Messages.StateInfo_Messages;
