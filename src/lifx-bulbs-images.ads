package LIFX.Bulbs.Images is
   function Image (Item : Bulb) return String;
   function Image (Item : Map) return String;

   function Image (Item : String) return String;
   function Image (Item : LIFX.Messages.HSBK_Type) return String;
   function Image (Item : Float) return String;
   function Image (Item : Boolean) return String is (Item'Img);
   function Image (Item : GNAT.Sockets.Sock_Addr_Type) return String;
   function Image (Item : Ada.Calendar.Time) return String;

end LIFX.Bulbs.Images;
