with LIFX.Messages.Constants;
with Ada.Strings.Fixed;
package body LIFX.Messages.Lights.State_Messages is

   -----------------
   -- Constructor --
   -----------------
   overriding procedure Initialize (Msg : in out State_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Light_Messages.SetPower;
      Msg.Header.Frame.Size               := Msg.Header'Size / 8;
   end Initialize;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return State_Message is
   begin
      return Ret : State_Message do
         HSBK_Type'Read (Params, Ret.Color);
         Interfaces.Unsigned_16'Read (Params, Ret.Reserved_1);
         Interfaces.Unsigned_16'Read (Params, Ret.Power);
         String'Read (Params, Ret.Label);
         Interfaces.Unsigned_64'Read (Params, Ret.Reserved_2);
      end return;
   end Constructor;

   overriding function Image (Item : State_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "Color => (" & Image (Item.Color) & ")," & ASCII.LF &
        "Power => " & Image (Item.Power) & "," &  ASCII.LF &
        "Label => " & Image (Item.Label);
   end Image;

   function Create (Src : Message'Class; Color : HSBK_Type; Power : Float; Label : String) return State_Message is
   begin
      return Ret : State_Message do
         Ret.Header.Frame_Address.Sequence := Src.Header.Frame_Address.Sequence;
         Ret.Color := Color;
         Ret.Power := Interfaces.Unsigned_16 (Float (Interfaces.Unsigned_16'Last) * Power);
         Ada.Strings.Fixed.Move (Label, Ret.Label);
         Ret.Header.Frame_Address.Res_Required := True;
         Ret.Header.Frame_Address.Ack_Required := False;
         Ret.Header.Frame_Address.Sequence     := Sequence;
      end return;
   end Create;

begin
   LIFX.Messages.Register_Name (LIFX.Messages.Constants.Light_Messages.State, State_Message'Tag);
end LIFX.Messages.Lights.State_Messages;
