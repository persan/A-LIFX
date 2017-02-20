with Ada.Strings.Unbounded;
with GNAT.Formatted_String;
with GNAT.Calendar.Time_IO;
package body LIFX.Bulbs.Images is

   use Ada.Strings.Unbounded;
   use GNAT.Formatted_String;

   function Image (Item : String) return String is
   begin
      return Ret : String := Item do
         for I in Ret'Range loop
            Ret (I) := (if Ret (I) in ' ' .. 'z' then Ret (I) else ' ');
         end loop;
      end return;
   end;

   function Image (Item : LIFX.Messages.HSBK_Type) return String is
      Format : constant Formatted_String := +"%01f/%01f/%01/%01f";
   begin
      return -(Format & Float (Item.Hue) & Float (Item.Saturation) & Float (Item.Brightness) & Float (Item.Color_Temperature));
   end Image;

   function Image (Item : Float) return String is
      Format : constant Formatted_String := +"%05f";
   begin
      return -(Format & Item);
   end Image;

   function Image (Item : GNAT.Sockets.Sock_Addr_Type) return String is
   begin
      return GNAT.Sockets.Image (Item);
   end Image;

   function Image (Item : Ada.Calendar.Time) return String is
   begin
      return GNAT.Calendar.Time_IO.Image (Item, "%T");
   end Image;

   -----------
   -- Image --
   -----------
   --            1234567890123456789012345678901234567890
   Heading : constant String :=
               "| Label                          " &
               "| Label2                         " &
               "| Group          " &
               "| Location                       " &
               "| Location2      " &
               "| Colour         " &
               "| Power                  " &
               "| Addr                  " &
               "| Time                  ";
   Line    : constant String (Heading'Range) := (others => '-');
   function Image (Item : Bulb) return String is
   begin
      return "|" & Image (Item.Label) &
        "|" & Image (Item.Label2) &
        "|" & Image (Item.Group) &
        "|" & Image (Item.Location) &
        "|" & Image (Item.Location2) &
        "|" & Image (Item.Color) &
        "|" & Image (Item.Power_On) &
        "|" & Image (Item.Power_Level) &
        "|" & Image (Item.Addr) &
        "|" & Image (Item.Time);
   end Image;

   -----------
   -- Image --
   -----------

   function Image (Item : Map) return String is
      Ret : Unbounded_String;
   begin
      Append (Ret, Heading & ASCII.LF);
      Append (Ret, Line & ASCII.LF);
      for I of Item loop
         Append (Ret, Image (I) & ASCII.LF);
      end loop;
      Append (Ret, Line & ASCII.LF);
      return To_String (Ret);
   end Image;

end LIFX.Bulbs.Images;
