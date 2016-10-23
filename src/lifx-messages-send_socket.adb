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

with GNAT.Source_Info;
with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Time_Stamp;
with Stream_Tools.Memory_Streams;
procedure LIFX.Messages.Send_Socket
  (Socket : Socket_Type;
   Item   : LIFX.Messages.Message'Class;
   To     : access Sock_Addr_Type;

   Flags  : Request_Flag_Type := No_Request_Flag) is
   Buffer : Ada.Streams.Stream_Element_Array (1 .. 1024);
   S      : aliased Stream_Tools.Memory_Streams.Memory_Stream;

   Last   : Ada.Streams.Stream_Element_Offset with
      Unreferenced;
   procedure Log
     (Message  : LIFX.Messages.Message'Class;
      Location : String := GNAT.Source_Info.Enclosing_Entity) with GHOST => True;
   procedure Log
     (Message  : LIFX.Messages.Message'Class;
      Location : String := GNAT.Source_Info.Enclosing_Entity) is
   begin
      New_Line;
      Put_Line (GNAT.Time_Stamp.Current_Time & " : " & GNAT.Sockets.Image (To.Addr) & ":" & To.Port'Img & ":" & Location);
      Put_Line (Message.Image);
   end;

begin
   pragma Debug (Log (Item, GNAT.Source_Info.Enclosing_Entity));
   S.Set_Address (To => Buffer'Address);
   S.Set_Length (To => Buffer'Length);
   LIFX.Messages.Message'Class'Output (S'Access, Item);
   Stream_Tools.Memory_Streams.Send_Socket (Socket, Item => S, Last => Last, To => To, Flags => Flags);
end LIFX.Messages.Send_Socket;
