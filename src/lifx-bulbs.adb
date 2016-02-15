------------------------------------------------------------------------------
--                                                                          --
--                   A-LIFX An Ada interface to the LIFX-BULBS              --
--                                                                          --
--                                                                          --
--                                                                          --
--                     Copyright (C) 2016 Per Sandberg                      --
--                                                                          --
--  This library is free software;  you can redistribute it and/or modify   --
--  it under terms of the  GNU General Public License  as published by the  --
--  Free Software  Foundation;  either version 3,  or (at your  option) any --
--  later version. This library is distributed in the hope that it will be  --
--  useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                    --
--                                                                          --
--  As a special exception under Section 7 of GPL version 3, you are        --
--  granted additional permissions described in the GCC Runtime Library     --
--  Exception, version 3.1, as published by the Free Software Foundation.   --
--                                                                          --
--  You should have received a copy of the GNU General Public License and   --
--  a copy of the GCC Runtime Library Exception along with this program;    --
--  see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see   --
--  <http://www.gnu.org/licenses/>.                                         --
--                                                                          --
--  As a special exception, if other files instantiate generics from this   --
--  unit, or you link this unit with other files to produce an executable,  --
--  this  unit  does not  by itself cause  the resulting executable to be   --
--  covered by the GNU General Public License. This exception does not      --
--  however invalidate any other reasons why the executable file  might be  --
--  covered by the  GNU Public License.                                     --
--                                                                          --
--                                                                          --
------------------------------------------------------------------------------

with Ada.Tags;
with GNAT.IO;
with GNAT.Source_Info;

package body LIFX.Bulbs is
   use GNAT.Sockets;

   overriding procedure Finalize (Self : in out Bulbs_Record) is
   begin
      null;
   end Finalize;

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

   procedure On_Message (Self : Bulbs_Record; Message : LIFX.Messages.Message'Class) is
      pragma Unreferenced (Self);
   begin
      pragma Debug (GNAT.IO.Put_Line (GNAT.Source_Info.Enclosing_Entity & "(" & Ada.Tags.External_Tag (Message'Tag) & ")"));
   end On_Message;

end LIFX.Bulbs;
