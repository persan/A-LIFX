package body LIFX.Messages.Unknown_Messages is

   -----------------
   -- Constructor --
   -----------------
   overriding function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class) return Unknown_Message is
      pragma Unreferenced (Params);
   begin
      return Ret : Unknown_Message do
         null;
      end return;
   end Constructor;

   overriding procedure Initialize (Msg : in out Unknown_Message) is
   begin
      Msg.Header.Protocol_Header.Msg_Type := 0;
      Msg.Header.Frame.Size               := Msg.Header'Size / Ada.Streams.Stream_Element'Size;
   end Initialize;

   overriding function Image (Item : Unknown_Message) return String is
   begin
      return Image (Message (Item)) & ASCII.LF &
        "<< ERRONOUS MESSAGE >>";
   end Image;

   function Create return Unknown_Message is
   begin
      return Ret : Unknown_Message do
         Ret.Header.Frame_Address.Sequence := Sequence;
      end return;
   end Create;
end LIFX.Messages.Unknown_Messages;
