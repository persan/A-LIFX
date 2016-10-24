with Ada.Calendar;
with Ada.Containers.Ordered_Maps;

with GNAT.Sockets;

with LIFX.Messages;

package LIFX.Bulb_Store is
   type Bulb_Info is tagged record
      Label    : String (1 .. 32) := (others => ' ');
      Label2   : String (1 .. 32) := (others => ' ');
      Group    : String (1 .. 32) := (others => ' ');
      Location : String (1 .. 32) := (others => ' ');
      Color    : LIFX.Messages.HSBK_Type;
      Power    : Float;
      Addr     : GNAT.Sockets.Sock_Addr_Type;
      Time     : Ada.Calendar.Time;
   end record;

   function "<" (L, R : GNAT.Sockets.Sock_Addr_Type) return Boolean;
   package Bulb_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type        => GNAT.Sockets.Sock_Addr_Type,
      Element_Type    => Bulb_Info,
      "<"             => "<",
      "="             => "=");
   Store : Bulb_Maps.Map;
   procedure Dump;
end LIFX.Bulb_Store;
