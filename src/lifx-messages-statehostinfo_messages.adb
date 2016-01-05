with LIFX.Messages.Constants;
package body LIFX.Messages.StateHostInfo_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateHostInfo_Message is
   begin
      return Ret : StateHostInfo_Message do
         Float'Read (Params, Ret.Signal);
         Uint32'Read (Params, Ret.Tx);
         Uint32'Read (Params, Ret.Rx);
         Int16'Read (Params, Ret.Reserved);
      end return;
   end Constructor;

   overriding function Image (Item : StateHostInfo_Message) return String is
   begin
      return Image (Message (Item)) &
        ASCII.LF &
        "Signal => " &
        Item.Signal'Img &
        ASCII.LF &
        "Tx     => " &
        Item.Tx'Img &
        ASCII.LF &
        "Rx     => " &
        Item.Rx'Img;
   end Image;

begin
   LIFX.Messages.Register_Name (LIFX.Messages.Constants.Device_Messages.StateHostInfo, StateHostInfo_Message'Tag);
end LIFX.Messages.StateHostInfo_Messages;
