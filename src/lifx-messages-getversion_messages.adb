with LIFX.Messages.Constants;
package body LIFX.Messages.GetVersion_Messages is

   -----------------
   -- Constructor --
   -----------------

   procedure Initialize (Msg : in  out GetVersion_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetVersion;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetVersion_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : GetVersion_Message do
         null;
      end return;
   end Constructor;

   function Create return GetVersion_Message is
   begin
      return Ret : GetVersion_Message do
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetVersion , Object_Tag => GetVersion_Message'Tag );
end LIFX.Messages.GetVersion_Messages;
