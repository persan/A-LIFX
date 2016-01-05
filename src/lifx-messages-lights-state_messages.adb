with LIFX.Messages.Constants;
with Ada.Strings.Fixed;
package body LIFX.Messages.Lights.State_Messages is

   -----------------
   -- Constructor --
   -----------------
   procedure Initialize (Msg : in  out State_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Light_Messages.SetPower;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return State_Message
   is
   begin
      return Ret : State_Message do
         HSBK_TYPE'Read (Params, Ret.color);
         Uint16'Read (Params, Ret.Reserved_1);
         Uint16'Read (Params, Ret.Power);
         String'Read (Params, Ret.Label);
         Uint64'Read (Params, Ret.Reserved_2);
      end return;
   end Constructor;

   function Image ( Item : State_Message ) return String is
   begin
      return Image (Message (Item)) & ASCII.Lf &
        "Color    => (" & Image (Item.Color) & ")," & ASCII.Lf &
        "Power    => " & image(Item.Power) & "," & ASCII.Lf &
        "Label => "    & image(Item.Label);
   end;

   function Create
     (Color : HSBK_TYPE; Power : Float ; Label : String)
      return State_Message is
   begin
      return Ret : State_Message do
         Ret.Color := Color;
         Ret.Power := Uint16 (Float (Uint16'Last) * Power);
         Ada.Strings.Fixed.Move (Label, Ret.Label);
         Ret.Header.Frame_Address.Res_Required := True;
         Ret.Header.Frame_Address.Ack_Required := False;
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;

begin
   LIFX.Messages.Register_Name (LIFX.Messages.Constants.Light_Messages.State,State_Message'Tag);
end LIFX.Messages.Lights.State_Messages;
