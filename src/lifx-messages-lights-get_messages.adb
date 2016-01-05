with LIFX.Messages.Constants;
package body LIFX.Messages.Lights.Get_Messages is

   -----------------
   -- Constructor --
   -----------------
   overriding procedure Initialize (Msg : in out Get_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Light_Messages.Get;
      Msg.Header.Frame.Size               := Msg.Header'Size / 8;
   end Initialize;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return Get_Message is
      pragma Unreferenced (Params);
   begin
      pragma Warnings (Off);
      return Ret : Get_Message do
         null;
      end return;
   end Constructor;

   function Create return Get_Message is
   begin
      return Ret : Get_Message do
         Ret.Header.Frame_Address.Res_Required := True;
         Ret.Header.Frame_Address.Ack_Required := False;
         Ret.Header.Frame_Address.Sequence     := Sequence;
      end return;
   end Create;
begin
   Register_Name (Name => LIFX.Messages.Constants.Light_Messages.Get, Object_Tag => Get_Message'Tag);

end LIFX.Messages.Lights.Get_Messages;
