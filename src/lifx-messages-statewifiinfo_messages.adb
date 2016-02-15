with LIFX.Messages.Constants;
package body LIFX.Messages.StateWifiInfo_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Image (Item : StateWifiInfo_Message) return String is
   begin
      return Image (Message (Item)) & "," & ASCII.LF &
        "Signal => " & Item.Signal'Img & "," &  ASCII.LF &
        "Tx     => " & Image (Item.Tx) & "," &  ASCII.LF &
        "Rx     => " & Image (Item.Rx);
   end Image;

   overriding function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateWifiInfo_Message is
   begin
      return Ret : StateWifiInfo_Message do
         Float'Read (Params, Ret.Signal);
         Interfaces.Unsigned_32'Read (Params, Ret.Tx);
         Interfaces.Unsigned_32'Read (Params, Ret.Rx);
         Short_Integer'Read (Params, Ret.Reserved);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateWifiInfo_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateWifiInfo;
      Msg.Header.Frame.Size               := StateWifiInfo_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   function Create
     (Src      : Message'Class;
      Signal   : Float;
      Tx       : Interfaces.Unsigned_32;
      Rx       : Interfaces.Unsigned_32)
      return StateWifiInfo_Message is
   begin
      return Ret : StateWifiInfo_Message do
         Ret.Header.Frame_Address.Sequence :=  Src.Header.Frame_Address.Sequence;
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateWifiInfo, Object_Tag => StateWifiInfo_Message'Tag);
end LIFX.Messages.StateWifiInfo_Messages;
