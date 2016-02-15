with LIFX.Messages.Constants;
package body LIFX.Messages.StateHostInfo_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return StateHostInfo_Message is
   begin
      return Ret : StateHostInfo_Message do
         Float'Read (Params, Ret.Signal);
         Interfaces.Unsigned_32'Read (Params, Ret.Tx);
         Interfaces.Unsigned_32'Read (Params, Ret.Rx);
         Interfaces.Integer_16'Read (Params, Ret.Reserved);
      end return;
   end Constructor;

   overriding
   procedure Initialize (Msg : in out StateHostInfo_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateHostInfo;
      Msg.Header.Frame.Size               := StateHostInfo_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   overriding
   function Image (Item : StateHostInfo_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "Signal => " & Image (Item.Signal) & "," &  ASCII.LF &
        "Tx     => " & Image (Item.Tx) & "," &  ASCII.LF &
        "Rx     => " & Image (Item.Rx);
   end Image;

   function Create
     (Src      : Message'Class;
      Signal   : Float;
      Tx       : Interfaces.Unsigned_32;
      Rx       : Interfaces.Unsigned_32)
      return StateHostInfo_Message is
   begin
      return Ret : StateHostInfo_Message do
         Ret.Header.Frame_Address.Sequence := Src.Header.Frame_Address.Sequence;
         Ret.Signal := Signal;
         Ret.Tx := Tx;
         Ret.Rx := Rx;
      end return;
   end Create;

begin
   LIFX.Messages.Register_Name (LIFX.Messages.Constants.Device_Messages.StateHostInfo, StateHostInfo_Message'Tag);
end LIFX.Messages.StateHostInfo_Messages;
