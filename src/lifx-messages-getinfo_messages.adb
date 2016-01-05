with LIFX.Messages.Constants;
package body LIFX.Messages.GetInfo_Messages is

   -----------------
   -- Constructor --
   -----------------
   overriding procedure Initialize (Msg : in out GetInfo_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetInfo;
      Msg.Header.Frame.Size               := Msg.Header'Size / 8;
   end Initialize;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return GetInfo_Message is
      pragma Unreferenced (Params);
   begin
      pragma Warnings (Off);
      return Ret : GetInfo_Message do
         null;
      end return;
   end Constructor;

   function Create return GetInfo_Message is
   begin
      return Ret : GetInfo_Message do
         Ret.Header.Frame_Address.Sequence     := Sequence;
         Ret.Header.Frame_Address.Res_Required := True;
         Ret.Header.Frame_Address.Ack_Required := False;
      end return;
   end Create;
begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetInfo, Object_Tag => GetInfo_Message'Tag);
end LIFX.Messages.GetInfo_Messages;
