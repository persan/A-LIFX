package LIFX.Messages.EchoRequest_Messages is
   type EchoRequest_Message is new Message with record
      payload : Ada.Streams.Stream_Element_Array (1 .. 64);
   end record;

   overriding function Constructor (Params : not null access Ada.Streams.Root_Stream_Type'Class) return EchoRequest_Message;
   overriding procedure Initialize (Msg : in out EchoRequest_Message);
   function Create (payload : Ada.Streams.Stream_Element_Array) return EchoRequest_Message;
end LIFX.Messages.EchoRequest_Messages;
