with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with GNAT.Sockets;
with Ada.Finalization;
with LIFX.Messages;
package LIFX.Bulbs  is
   type Bulb is tagged record
      Name    : Ada.Strings.Unbounded.Unbounded_String;
      Address : GNAT.Sockets.Inet_Addr_Type;
   end record;

   package Bulb_Vectors is new Ada.Containers.Vectors (Natural, Bulb);

   type Bulbs_Record is tagged limited private;

   procedure Query_Network (Self : in out Bulbs_Record);
   function Image (Self : Bulbs_Record) return String;

private

   type Bulbs_Record is new Ada.Finalization.Limited_Controlled with record
      Bulbs         : Bulb_Vectors.Vector;
   end record;

   procedure On_Message (Self : Bulbs_Record ; Message : LIFX.Messages.Message'Class);
--    procedure Initialize (Self : in out Bulbs_Record);
   procedure Finalize   (Self : in out Bulbs_Record);

end LIFX.Bulbs;
