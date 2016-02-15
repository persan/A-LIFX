with LIFX.Messages.Constants;
package body LIFX.Messages.StatePower_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StatePower_Message is
   begin
      return Ret : StatePower_Message do
         Interfaces.Unsigned_16'Read (Params, Ret.Level);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StatePower_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StatePower;
      Msg.Header.Frame.Size               := StatePower_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   overriding function Image (Item : StatePower_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "level => " & Image (Item.Level);
   end Image;

   function Create
     (Src      : Message'Class;
      Level : Interfaces.Unsigned_16)
      return StatePower_Message is
   begin
      return Ret : StatePower_Message do
         Ret.Header.Frame_Address.Sequence := Src.Header.Frame_Address.Sequence;
         Ret.Level := Level;
      end return;
   end Create;

begin
   LIFX.Messages.Register_Name (LIFX.Messages.Constants.Device_Messages.StatePower, StatePower_Message'Tag);
end LIFX.Messages.StatePower_Messages;
