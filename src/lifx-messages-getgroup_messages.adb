with LIFX.Messages.Constants;
package body LIFX.Messages.GetGroup_Messages is

   -----------------
   -- Constructor --
   -----------------

   procedure Initialize (Msg : in  out GetGroup_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.GetGroup;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return GetGroup_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : GetGroup_Message do
         null;
      end return;
   end Constructor;

   function Create return GetGroup_Message is
   begin
      return Ret : GetGroup_Message do
           Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.GetGroup , Object_Tag => GetGroup_Message'Tag );
end LIFX.Messages.GetGroup_Messages;
