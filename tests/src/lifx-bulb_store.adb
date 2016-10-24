with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Containers; use Ada.Containers;
with GNAT.IO; use GNAT.IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with GNAT.Calendar.Time_IO; use GNAT.Calendar.Time_IO;

package body LIFX.Bulb_Store is
   use LIFX.Messages;
   use type Ada.Calendar.Time;
   ----------
   -- Hash --
   ----------
   procedure Dump is
   begin
      GNAT.IO.Put_Line (140 * '-');
      for I of Store loop
         Put_Line ((if Ada.Calendar.Clock - I.Time > 10.0 then
                      "*" else
                         " ") &
                         Image (I.Time, "%T") & "|" &
                     Image (I.Label2, I.Label2'Length) & "|" &
                     Image (I.Label, I.Label'Length) & "|" &
                     Image (I.Group, I.Group'Length) & "|" &
                     Image (I.Location, I.Location'Length) & "|" &
                     Image (I.Addr));
      end loop;
      GNAT.IO.Put_Line (140 * '-');
   end;
   function "<" (L, R : GNAT.Sockets.Sock_Addr_Type) return Boolean is
      L_As_Stream_Element_Array : Stream_Element_Array (1 .. (Sock_Addr_Type'Size) + 7 / Stream_Element'Size) with
        Import => True,
        Address => L'Address;
      R_As_Stream_Element_Array : Stream_Element_Array (1 .. (Sock_Addr_Type'Size) + 7 / Stream_Element'Size) with
        Import => True,
        Address => R'Address;
   begin
      return L_As_Stream_Element_Array < R_As_Stream_Element_Array;
   end;

end LIFX.Bulb_Store;
