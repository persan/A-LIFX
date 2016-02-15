with LIFX.Messages.Constants;
package body LIFX.Messages.StateGroup_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Image (Item : StateGroup_Message) return String is
   begin
      return Image (Message (Item)) &  ASCII.LF &
        "group      => " & Image (Item.Group) & "," & ASCII.LF &
        "Label      => " & Image (Item.Label) & "," & ASCII.LF &
        "updated_at => " & Image (Item.Updated_At);
   end Image;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateGroup_Message is
   begin
      return Ret : StateGroup_Message do
         String'Read (Params, Ret.Group);
         String'Read (Params, Ret.Label);
         Time_Type'Read (Params, Ret.Updated_At);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateGroup_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateGroup;
      Msg.Header.Frame.Size               := StateGroup_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   function Create
     (Src        : Message'Class;
      Group      : String;
      Label      : String;
      Updated_At : Time_Type) return StateGroup_Message is
   begin
      return Ret : StateGroup_Message do
         Ret.Header.Frame_Address.Sequence :=  Src.Header.Frame_Address.Sequence;
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateGroup, Object_Tag => StateGroup_Message'Tag);
end LIFX.Messages.StateGroup_Messages;
