with Interfaces;
package body LIFX.Bulbs is
   use type Interfaces.Unsigned_16;
   ------------------------
   -- On_Acknowledgement --
   ------------------------

   overriding procedure On_Acknowledgement
     (Handler : in out Bulb;
      Message : LIFX.Messages.Acknowledgement_Messages.Acknowledgement_Message)
   is
      pragma Unreferenced (Message);
   begin
      Handler.Time := Ada.Calendar.Clock;
   end On_Acknowledgement;

   ---------------------
   -- On_EchoResponse --
   ---------------------

   overriding procedure On_EchoResponse
     (Handler : in out Bulb;
      Message : LIFX.Messages.EchoResponse_Messages.EchoResponse_Message)
   is
      pragma Unreferenced (Message);
   begin
      Handler.Time := Ada.Calendar.Clock;
   end On_EchoResponse;

   --------------
   -- On_State --
   --------------

   overriding procedure On_State
     (Handler : in out Bulb;
      Message : LIFX.Messages.Lights.State_Messages.State_Message)
   is
   begin
      Handler.Color := Message.Color;
      Handler.Label := Message.Label;
      Handler.Power_On := Message.Power /= 0;
      Handler.Time := Ada.Calendar.Clock;
   end On_State;

   -------------------
   -- On_StateGroup --
   -------------------

   overriding procedure On_StateGroup
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message)
   is
   begin
      Handler.Group := Message.Group;
      Handler.Location := Message.Location;
      Handler.Time := Ada.Calendar.Clock;
   end On_StateGroup;

   --------------------------
   -- On_StateHostFirmware --
   --------------------------

   overriding procedure On_StateHostFirmware
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message)
   is
      pragma Unreferenced (Message);
   begin
      Handler.Time := Ada.Calendar.Clock;
   end On_StateHostFirmware;

   ----------------------
   -- On_StateHostInfo --
   ----------------------

   overriding procedure On_StateHostInfo
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateHostInfo_Messages.StateHostInfo_Message)
   is
      pragma Unreferenced (Message);
   begin
      Handler.Time := Ada.Calendar.Clock;
   end On_StateHostInfo;

   ------------------
   -- On_StateInfo --
   ------------------

   overriding procedure On_StateInfo
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateInfo_Messages.StateInfo_Message)
   is
      pragma Unreferenced (Message);
   begin
      Handler.Time := Ada.Calendar.Clock;
   end On_StateInfo;

   -------------------
   -- On_StateLabel --
   -------------------

   overriding procedure On_StateLabel
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateLabel_Messages.StateLabel_Message)
   is
   begin
      Handler.Label := Message.Label;
      Handler.Time := Ada.Calendar.Clock;
   end On_StateLabel;

   ----------------------
   -- On_StateLocation --
   ----------------------

   overriding procedure On_StateLocation
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateLocation_Messages.StateLocation_Message)
   is
   begin
      Handler.Label := Message.Label;
      Handler.Location2 := Message.Location;
      Handler.Time := Ada.Calendar.Clock;
   end On_StateLocation;

   -------------------
   -- On_StatePower --
   -------------------

   overriding procedure On_StatePower
     (Handler : in out Bulb;
      Message : LIFX.Messages.Lights.StatePower_Messages.StatePower_Message)
   is
   begin
      Handler.Power_On := Message.Level /= 0;
      Handler.Time := Ada.Calendar.Clock;
   end On_StatePower;

   -------------------
   -- On_StatePower --
   -------------------

   overriding procedure On_StatePower
     (Handler : in out Bulb;
      Message : LIFX.Messages.StatePower_Messages.StatePower_Message)
   is
   begin
      Handler.Power_On := Message.Level /= 0;
      Handler.Time := Ada.Calendar.Clock;
   end On_StatePower;

   ---------------------
   -- On_StateService --
   ---------------------

   overriding procedure On_StateService
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateService_Messages.StateService_Message)
   is
      pragma Unreferenced (Message);
   begin
      Handler.Time := Ada.Calendar.Clock;
   end On_StateService;

   ---------------------
   -- On_StateVersion --
   ---------------------

   overriding procedure On_StateVersion
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateVersion_Messages.StateVersion_Message)
   is
   begin
      Handler.Version := Message;
   end On_StateVersion;

   --------------------------
   -- On_StateWifiFirmware --
   --------------------------

   overriding procedure On_StateWifiFirmware
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message)
   is
      pragma Unreferenced (Message);
   begin
      Handler.Time := Ada.Calendar.Clock;
   end On_StateWifiFirmware;

   ----------------------
   -- On_StateWifiInfo --
   ----------------------

   overriding procedure On_StateWifiInfo
     (Handler : in out Bulb;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message)
   is
      pragma Unreferenced (Message);
   begin
      Handler.Time := Ada.Calendar.Clock;
   end On_StateWifiInfo;

   procedure AppendNode (Self : in out Map; Node : GNAT.Sockets.Sock_Addr_Type) is
   begin
      if not Self.Contains (Node) then
         Self.Insert (Node, Null_Bulb_Info);
         Self (Node).Addr := Node;
      end if;
   end;
   overriding
   function Copy (Source : Map) return Map is
   begin
      return Ret : Map do
         Bulb_Maps.Map (Ret) :=  Bulb_Maps.Map (Source).Copy;
         Ret.From := Source.From;
      end return;
   end;

   ------------------------
   -- On_Acknowledgement --
   ------------------------

   overriding procedure On_Acknowledgement
     (Handler : in out Map;
      Message : LIFX.Messages.Acknowledgement_Messages.Acknowledgement_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_Acknowledgement (Message);
   end On_Acknowledgement;

   ---------------------
   -- On_EchoResponse --
   ---------------------

   overriding procedure On_EchoResponse
     (Handler : in out Map;
      Message : LIFX.Messages.EchoResponse_Messages.EchoResponse_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_EchoResponse (Message);
   end On_EchoResponse;

   --------------
   -- On_State --
   --------------

   overriding procedure On_State
     (Handler : in out Map;
      Message : LIFX.Messages.Lights.State_Messages.State_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_State (Message);
   end On_State;

   -------------------
   -- On_StateGroup --
   -------------------

   overriding procedure On_StateGroup
     (Handler : in out Map;
      Message : LIFX.Messages.StateGroup_Messages.StateGroup_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateGroup (Message);
   end On_StateGroup;

   --------------------------
   -- On_StateHostFirmware --
   --------------------------

   overriding procedure On_StateHostFirmware
     (Handler : in out Map;
      Message : LIFX.Messages.StateHostFirmware_Messages.StateHostFirmware_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateHostFirmware (Message);
   end On_StateHostFirmware;

   ----------------------
   -- On_StateHostInfo --
   ----------------------

   overriding procedure On_StateHostInfo
     (Handler : in out Map;
      Message : LIFX.Messages.StateHostInfo_Messages.StateHostInfo_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateHostInfo (Message);
   end On_StateHostInfo;

   ------------------
   -- On_StateInfo --
   ------------------

   overriding procedure On_StateInfo
     (Handler : in out Map;
      Message : LIFX.Messages.StateInfo_Messages.StateInfo_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateInfo (Message);
   end On_StateInfo;

   -------------------
   -- On_StateLabel --
   -------------------

   overriding procedure On_StateLabel
     (Handler : in out Map;
      Message : LIFX.Messages.StateLabel_Messages.StateLabel_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateLabel (Message);
   end On_StateLabel;

   ----------------------
   -- On_StateLocation --
   ----------------------

   overriding procedure On_StateLocation
     (Handler : in out Map;
      Message : LIFX.Messages.StateLocation_Messages.StateLocation_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateLocation (Message);
   end On_StateLocation;

   -------------------
   -- On_StatePower --
   -------------------

   overriding procedure On_StatePower
     (Handler : in out Map;
      Message : LIFX.Messages.Lights.StatePower_Messages.StatePower_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StatePower (Message);
   end On_StatePower;

   -------------------
   -- On_StatePower --
   -------------------

   overriding procedure On_StatePower
     (Handler : in out Map;
      Message : LIFX.Messages.StatePower_Messages.StatePower_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StatePower (Message);
   end On_StatePower;

   ---------------------
   -- On_StateService --
   ---------------------

   overriding procedure On_StateService
     (Handler : in out Map;
      Message : LIFX.Messages.StateService_Messages.StateService_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateService (Message);
   end On_StateService;

   ---------------------
   -- On_StateVersion --
   ---------------------

   overriding procedure On_StateVersion
     (Handler : in out Map;
      Message : LIFX.Messages.StateVersion_Messages.StateVersion_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateVersion (Message);
   end On_StateVersion;

   --------------------------
   -- On_StateWifiFirmware --
   --------------------------

   overriding procedure On_StateWifiFirmware
     (Handler : in out Map;
      Message : LIFX.Messages.StateWifiFirmware_Messages.StateWifiFirmware_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateWifiFirmware (Message);
   end On_StateWifiFirmware;

   ----------------------
   -- On_StateWifiInfo --
   ----------------------

   overriding procedure On_StateWifiInfo
     (Handler : in out Map;
      Message : LIFX.Messages.StateWifiInfo_Messages.StateWifiInfo_Message)
   is
   begin
      Handler.AppendNode (Handler.From);
      Handler (Handler.From).On_StateWifiInfo (Message);
   end On_StateWifiInfo;

end LIFX.Bulbs;
