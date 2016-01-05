with LIFX.Messages.Constants;
package body LIFX.Messages.StateGroup_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Image (Item : StateGroup_Message) return String is
   begin
      return Image (Message (Item)) &
        ASCII.LF &
        "group      => " &
        Image (Item.Group) &
        "," &
        ASCII.LF &
        "Label      => """ &
        Image (Item.Label) &
        """" &
        ASCII.LF &
        "updated_at => " &
        Image (Item.Updated_At);
   end Image;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateGroup_Message is
   begin
      return Ret : StateGroup_Message do
         Ada.Streams.Stream_Element_Array'Read (Params, Ret.Group);
         String'Read (Params, Ret.Label);
         Time_Type'Read (Params, Ret.Updated_At);
      end return;
   end Constructor;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateGroup, Object_Tag => StateGroup_Message'Tag);
end LIFX.Messages.StateGroup_Messages;
