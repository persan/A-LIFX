with LIFX.Messages.Constants;
package body LIFX.Messages.GetService_Messages is

   -----------------
   -- Constructor --
   -----------------

   procedure Initialize (Msg : in  out GetService_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetService;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetService_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : GetService_Message do
         null;
      end return;
   end Constructor;

   function Create return GetService_Message is
   begin
      return Ret : GetService_Message do
         Ret.Header.Frame.Is_Tagged := True;
         Ret.Header.Frame_Address.Res_Required := True;
         Ret.Header.Frame_Address.Ack_Required := False;
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetService , Object_Tag => GetService_Message'Tag );
end LIFX.Messages.GetService_Messages;
