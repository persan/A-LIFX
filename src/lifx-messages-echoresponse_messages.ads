package LIFX.Messages.EchoResponse_Messages is

   type EchoResponse_Message is new Message with record
      Payload : Ada.Streams.Stream_Element_Array (1 .. 64);
   end record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return EchoResponse_Message;

   overriding
   procedure Initialize
     (Msg : in out EchoResponse_Message);

   overriding
   function Image
     (Item : EchoResponse_Message) return String;

   function Create
     (Src : Message'Class) return EchoResponse_Message;

end LIFX.Messages.EchoResponse_Messages;
