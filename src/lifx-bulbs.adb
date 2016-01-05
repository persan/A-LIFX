with GNAT.IO;
with GNAT.Source_Info;
with Ada.Tags;
-- with LIFX.Messages.GetService_Messages;
package body LIFX.Bulbs is
   use GNAT.Sockets;

   procedure Finalize   (Self : in out Bulbs_Record) is
   begin
      null;
   end;


   -------------------
   -- Query_Network --
   -------------------

   procedure Query_Network (Self : in out Bulbs_Record) is
   begin
      --  Generated stub: replace with real body!
--      pragma Compile_Time_Warning (Standard.True, "Query_Network unimplemented");
      raise Program_Error with "Unimplemented procedure Query_Network";
   end Query_Network;

   -----------
   -- Image --
   -----------

   function Image (Self : Bulbs_Record) return String is
   begin
      --  Generated stub: replace with real body!
--        pragma Compile_Time_Warning (Standard.True, "Image unimplemented");
      raise Program_Error with "Unimplemented function Image";
      return Image (Self);
   end Image;

   procedure On_Message (Self : Bulbs_Record ; Message : LIFX.Messages.Message'Class) is
      pragma Unreferenced (Self);
   begin
      pragma Debug (GNAT.IO.Put_Line (GNAT.Source_Info.Enclosing_Entity & "(" & Ada.Tags.External_Tag (Message'Tag) & ")"));
   end;

end LIFX.Bulbs;
