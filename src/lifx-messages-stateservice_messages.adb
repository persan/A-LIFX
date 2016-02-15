with LIFX.Messages.Constants;
package body LIFX.Messages.StateService_Messages is

   -----------------
   -- Constructor --
   -----------------

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class) return StateService_Message is
   begin
      return Ret : StateService_Message do
         Interfaces.Unsigned_8'Read (Params, Ret.Service);
         Interfaces.Unsigned_32'Read (Params, Ret.Port);
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out StateService_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := LIFX.Messages.Constants.Device_Messages.StateService;
      Msg.Header.Frame.Size               := StateService_Message'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   overriding function Image (Item : StateService_Message) return String is
   begin
      return Image (Message (Item)) &  ASCII.LF &
        "Port    => " &  Image (Item.Port) & "," & ASCII.LF &
        "Service => " &  Image (Item.Service);
   end Image;

   function Create (Src      : Message'Class;
                    Service  : Interfaces.Unsigned_8;
                    Port     : GNAT.Sockets.Port_Type)
                    return StateService_Message is
   begin
      return Ret : StateService_Message  do
         Ret.Port := Interfaces.Unsigned_32 (Port);
         Ret.Service := 1;
      end return;
   end;

begin
   LIFX.Messages.Register_Name (LIFX.Messages.Constants.Device_Messages.StateService, StateService_Message'Tag);
end LIFX.Messages.StateService_Messages;
