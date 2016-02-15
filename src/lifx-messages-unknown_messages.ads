
package LIFX.Messages.Unknown_Messages is
   type Unknown_Message is new Message with null record;

   overriding
   function Constructor
     (Params : not null access Ada.Streams.Root_Stream_Type'Class)
      return Unknown_Message;

   overriding
   procedure Initialize (Msg : in out Unknown_Message);

   overriding
   function Image (Item : Unknown_Message) return String;

   function Create return Unknown_Message;

end LIFX.Messages.Unknown_Messages;
