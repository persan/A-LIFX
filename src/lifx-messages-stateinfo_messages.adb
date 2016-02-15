with LIFX.Messages.Constants;
package body LIFX.Messages.StateInfo_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateInfo_Message is
      pragma Unreferenced (Params);
   begin
      return Ret : StateInfo_Message do
         pragma Warnings (Off, Ret);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateInfo_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateInfo;
      Msg.Header.Frame.Size               := StateInfo_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   overriding function Image (Item : StateInfo_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "Time     => " & Image (Item.Time) & "," &  ASCII.LF &
        "Uptime   => " & Image (Item.Uptime) &  "," &  ASCII.LF &
        "Downtime => " & Image (Item.Downtime);
   end Image;

   function Create
     (Src      : Message'Class;
      Time     : Time_Type;
      Uptime   : Time_Type;
      Downtime : Time_Type)
      return StateInfo_Message is
   begin
      return Ret : StateInfo_Message do
         Ret.Header.Frame_Address.Sequence := Src.Header.Frame_Address.Sequence;
         Ret.Time := Time;
         Ret.Uptime := Uptime;
         Ret.Downtime := Downtime;
      end return;
   end Create;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.StateInfo, Object_Tag => StateInfo_Message'Tag);
end LIFX.Messages.StateInfo_Messages;
