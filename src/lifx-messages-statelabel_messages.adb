with LIFX.Messages.Constants;
package body LIFX.Messages.StateLabel_Messages is

   -----------------
   -- Constructor --
   -----------------

   function Image ( Item : StateLabel_Message) return String is
   begin
      return Image (Message (Item)) & "," & ASCII.Lf &
        "Label    => """ & image(Item.Label) & """";
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateLabel_Message
   is
   begin
      return Ret : StateLabel_Message do
         String'Read (Params, Ret.Label);
      end return;
   end Constructor;


begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateLabel , Object_Tag => StateLabel_Message'Tag );
end LIFX.Messages.StateLabel_Messages;
