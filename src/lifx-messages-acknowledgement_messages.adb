with LIFX.Messages.Constants;
package body LIFX.Messages.Acknowledgement_Messages is

   -----------------
   -- Constructor --
   -----------------

   procedure Initialize (Msg : in  out Acknowledgement_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.Acknowledgement;
      Msg.Header.Frame.Size := Msg.Header'Size / 8;
   end;

   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return Acknowledgement_Message
   is
      pragma Unreferenced (Params);
   begin
      return Ret : Acknowledgement_Message do
         null;
      end return;
   end Constructor;

   function Create return Acknowledgement_Message is
   begin
      return Ret : Acknowledgement_Message do
           Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end;

begin
   Register_Name (Name => LIFX.Messages.Constants.Device_Messages.Acknowledgement , Object_Tag => Acknowledgement_Message'Tag );
end LIFX.Messages.Acknowledgement_Messages;
