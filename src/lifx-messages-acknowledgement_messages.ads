package LIFX.Messages.Acknowledgement_Messages is

   type Acknowledgement_Message is new Message with null record;
   overriding function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class) return Acknowledgement_Message;

   overriding procedure Initialize (Msg : in out Acknowledgement_Message);
   function Create return Acknowledgement_Message;

end LIFX.Messages.Acknowledgement_Messages;
