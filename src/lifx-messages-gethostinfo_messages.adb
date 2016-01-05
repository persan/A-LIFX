with LIFX.Messages.Constants;
package body LIFX.Messages.GetHostInfo_Messages is

   -----------------
   -- Constructor --
   -----------------

   procedure Initialize (Msg : in  out GetHostInfo_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetHostInfo;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetHostInfo_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : GetHostInfo_Message do
         null;
      end return;
   end Constructor;

   function Create return GetHostInfo_Message is
   begin
      return Ret : GetHostInfo_Message do
           Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetHostInfo , Object_Tag => GetHostInfo_Message'Tag );
end LIFX.Messages.GetHostInfo_Messages;
