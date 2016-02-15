with LIFX.Messages.Constants;
with Ada.Strings.Fixed;
package body LIFX.Messages.StateLabel_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding
   function Image (Item : StateLabel_Message) return String is
   begin
      return Image (Message (Item)) & "," & ASCII.LF & "Label    => " & Image (Item.Label);
   end Image;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateLabel_Message is
   begin
      return Ret : StateLabel_Message do
         String'Read (Params, Ret.Label);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateLabel_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateLabel;
      Msg.Header.Frame.Size               := StateLabel_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   function Create
     (Src      : Message'Class;
      Label : String)
      return StateLabel_Message is
   begin
      return Ret : StateLabel_Message do
         Ret.Header.Frame_Address.Sequence := Src.Header.Frame_Address.Sequence;
         Ada.Strings.Fixed.Move
           (Source => Label,
            Target  => Ret.Label,
            Pad      => ' ');
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateLabel, Object_Tag => StateLabel_Message'Tag);
end LIFX.Messages.StateLabel_Messages;
