with LIFX.Messages.Constants;
package body LIFX.Messages.StateService_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateService_Message is
   begin
      return Ret : StateService_Message do
         Byte'Read (Params, Ret.Service);
         Uint32'Read (Params, Ret.Port);
      end return;
   end Constructor;

   overriding function Image (Item : StateService_Message) return String is
   begin
      return Image (Message (Item)) &
        ASCII.LF &
        "Port    => " &
        Item.Port'Img &
        "," &
        ASCII.LF &
        "Service => " &
        Item.Service'Img;
   end Image;

begin
   LIFX.Messages.Register_Name (LIFX.Messages.Constants.Device_Messages.StateService, StateService_Message'Tag);
end LIFX.Messages.StateService_Messages;
