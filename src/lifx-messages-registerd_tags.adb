with Ada.Strings.Unbounded;
function LIFX.Messages.Registerd_Tags return String is
   ret : Ada.Strings.Unbounded.Unbounded_String;
   use Ada.Strings.Unbounded;
   use type Ada.Tags.Tag;
begin
   for Ix in Name_To_Tag'Range loop
      if Name_To_Tag (Ix) /= Ada.Tags.No_Tag then
         Append (ret, Ix'Img & " => " & Ada.Tags.External_Tag (Name_To_Tag (Ix)) & ASCII.LF);
      end if;
   end loop;
   return To_String (ret);
end LIFX.Messages.Registerd_Tags;
