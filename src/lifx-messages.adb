with Stream_Tools.Memory_Streams;
with Ada.Tags.Generic_Dispatching_Constructor;
with GNAT.Calendar;
with Ada.Calendar;
with GNAT.Calendar.Time_IO;
with Ada.Strings.Unbounded;
package body LIFX.Messages is
   use all type Ada.Streams.Stream_Element_Offset;

   -----------
   -- Input --
   -----------
   use all type Ada.Tags.Tag;

   function Input
     (S : not null access Ada.Streams.Root_Stream_Type'Class)
      return Message'Class
   is
      function Dispatching_Constructor is new
        Ada.Tags.Generic_Dispatching_Constructor
          (T           => Message,
           Parameters  => Ada.Streams.Root_Stream_Type'Class,
           Constructor =>  Constructor);
      Name : Header_Type;

   begin
      Header_Type'Read (S, Name);
      if Name_To_Tag (Name.Protocol_Header.Msg_Type) = Ada.Tags.No_Tag then
         raise Constraint_Error with "Unknown message => " & Name.Protocol_Header.Msg_Type'Img;
      end if;
      return Ret : Message'Class :=  Dispatching_Constructor (Name_To_Tag (Name.Protocol_Header.Msg_Type), S) do
         ret.header := Name;
      end return;
   end Input;

   ------------
   -- Output --
   ------------

   procedure Output
     (S : not null access Ada.Streams.Root_Stream_Type'Class;
      Msg :   Message'Class)
   is
      use Stream_Tools.Memory_Streams;
      Buffer : aliased Dynamic_Memory_Stream (1024, Add_Initial_Size);

   begin
      Message'Class'Write (Buffer'Access, Msg);
      Buffer.Seek (-1);
      Dynamic_Memory_Stream'Write (S, Buffer);
   end Output;

   function Image ( Item : Uint16_Array) return String is
      Ret : Ada.Strings.Unbounded.Unbounded_String;
   begin
      for I of Item loop
         Ada.Strings.Unbounded.Append (Ret," " & I'Img);
      end loop;
      return Ada.Strings.Unbounded.To_String (Ret);
   end;

   -------------------
   -- Register_Name --
   -------------------

   procedure Register_Name
     (Name        : Uint16;
      Object_Tag  : Ada.Tags.Tag)
   is
   begin
      if Name_To_Tag (Name) /= ADA.Tags.No_Tag then
         raise Constraint_Error with "id" & Name'Img & " defined twice";
      else
         Name_To_Tag (Name) := Object_Tag;
      end if;

   end Register_Name;

   procedure Write (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : Frame_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Frame_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Write (S, Buffer);
   end;


   procedure Read (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : out Frame_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Frame_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Read (S, Buffer);
   end;


   procedure Write (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : Frame_Address_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Frame_Address_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Write (S, Buffer);
   end;


   procedure Read (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : out Frame_Address_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Frame_Address_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Read (S, Buffer);
   end;


   procedure Write (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : Protocol_Header_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Protocol_Header_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Write (S, Buffer);
   end;


   procedure Read (S : not null access Ada.Streams.Root_Stream_Type'Class; Data : out Protocol_Header_Type) is
      Buffer : Ada.Streams.Stream_Element_Array (1 .. Protocol_Header_Type'Size / Ada.Streams.Stream_Element'Size) with
        Import => True,
        Address => Data'Address;
   begin
      Ada.Streams.Stream_Element_Array'Read (S, Buffer);
   end;


   function Image ( Item : Boolean_Array ) return String is
   begin
      return Ret : String (Item'Range) do
         for I in Item'Range loop
            Ret (I) := (if Item (I) then  '1' else '_');
         end loop;
      end return;
   end;

   function Image ( Item : String ) return String is
   begin
      for I in Item'Range loop
         if Item (I) < ' ' or Item (I) > ASCII.DEL then
            return Item (Item'First .. I-1);
         end if;
      end loop;
      return Item;
   end;

   function Image ( Item : Frame_Type ) return String is
   begin
      return
        "    Size        => " & Item.Size'Img & ", " & ASCII.LF &
        "    Origin      => " & Item.Origin'Img & ", " & ASCII.LF &
        "    Is_Tagged   => " & Item.Is_Tagged'Img & ", " & ASCII.LF &
        "    Addressable => " & Item.Addressable'Img & ", " & ASCII.LF &
        "    Protocol    => " & Item.Protocol'Img & ", " & ASCII.LF &
        "    Source      => " & Item.Source'Img;
     end;

   function Image ( Item : Frame_Address_Type ) return String is
      function Image ( S : Uint64 ) return String is
--           Ret : String (1 .. 8) with
--             Import => True,
--             Address => S'Address;
      begin
         return s'Img;
      end;
   begin
      return
        "    Target       => " & image(Item.Target) & ", " & ASCII.LF &
      --  "    Reserved_1 => " & Image (Item.Reserved_1) & ", " & ASCII.LF &
      --  "    Reserved_2 => " & Image (Item.Reserved_2) & ", " & ASCII.LF &
        "    Ack_Required => " & Item.Ack_Required'Img & ", " & ASCII.LF &
        "    Res_Required => " & Item.Res_Required'Img & ", " & ASCII.LF &
        "    Sequence     => " & Item.Sequence'Img;
     end;

   function Image ( Item : Protocol_Header_Type ) return String is
   begin
     return --"    Reserved_1 => (" & Image (Item.Reserved_1) & "), " & ASCII.LF &
        "    Msg_Type => " & Item.Msg_Type'Img & ", " & ASCII.LF &
        "";-- "    Reserved_2 => " & Image (Item.Reserved_2);

   end;

   function Image (Item : Header_Type; with_Header : Boolean := False ) return String is
   begin
      return
        (if with_Header then
        "  Frame           => (" & ASCII.LF & Image (Item.Frame) & ")," & ASCII.LF &
        "  Frame_Address   => (" & ASCII.LF & Image (Item.Frame_Address) & ")," & ASCII.LF &
        "  Protocol_Header => (" & ASCII.LF & Image (Item.Protocol_Header) & ")" else "");
   end;

   function Image ( Item : Message ) return String is
   begin
      return "Header => (" & Image (Item.Header) & ")";
   end;


   function image ( Item : HSBK_Type ) return String is
   begin
      return
        "      Hue               => " & Image (Item.Hue) & ASCII.LF &
        "      Saturation        => " & Image (Item.Saturation) & ASCII.LF &
        "      Brightness        => " & Image (Item.Brightness) & ASCII.LF &
        "      color_temperature => " & Image (Item.color_temperature );
   end;

   function Image ( Item : Ada.Streams.Stream_Element_Array) return String is
      Ret : String (1 .. Item'Length * 3);
      Cursor : Natural := Ret'First;
      Map    : constant array (ada.Streams.Stream_Element(0) .. ada.Streams.Stream_Element(15)) of Character := "0123456789ABCDEF";
      use type ada.Streams.Stream_Element;
   begin
      for I of Item loop
         Ret (Cursor) := Map (I / 16);
         Cursor := Cursor +1;
         Ret (Cursor) := Map (I mod 16);
         Cursor := Cursor + 1;
         Ret (Cursor) := ' ';
         Cursor := Cursor + 1;
      end loop;
      return Ret (Ret'First .. Ret'Last - 1);
   end;

   function To_Calendar_Time (T : Time_Type) return Ada.Calendar.Time is
      use all type Ada.Calendar.Time;
      EPOC : constant Ada.Calendar.Time := Ada.Calendar.Time_Of (1970, 01, 01,0.0);
   begin
      return EPOC + Duration (T / 1_000_000_000);
   end;

   function Image (Item : Time_Type) return String is

   begin
      return GNAT.Calendar.Time_IO.Image (To_Calendar_Time (Item), "%Y-%m-%d %T" );
   end;

   Sequence_Store : Byte := 0;
   function Sequence return Byte is
   begin
      Sequence_Store := Sequence_Store + 1;
      return Sequence_Store;
   end Sequence;

end LIFX.Messages;
