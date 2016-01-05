package LIFX.Messages.Constants is

   package Device_Messages is
      GetService    : constant := 02;
      StateService  : constant := 03;
      GetHostInfo   : constant := 12;
      StateHostInfo : constant := 13;

      GetHostFirmware   : constant := 14;
      StateHostFirmware : constant := 15;

      GetWifiInfo   : constant := 16;
      StateWifiInfo : constant := 17;

      GetWifiFirmware   : constant := 18;
      StateWifiFirmware : constant := 19;

      GetPower   : constant := 20;
      SetPower   : constant := 21;
      StatePower : constant := 22;

      GetLabel   : constant := 23;
      SetLabel   : constant := 24;
      StateLabel : constant := 25;

      GetVersion   : constant := 32;
      StateVersion : constant := 33;

      GetInfo   : constant := 34;
      StateInfo : constant := 35;

      Acknowledgement : constant := 45;

      GetLocation   : constant := 48;
      StateLocation : constant := 50;

      GetGroup     : constant := 51;
      StateGroup   : constant := 53;
      EchoRequest  : constant := 58;
      EchoResponse : constant := 59;
   end Device_Messages;

   package Light_Messages is
      Get        : constant := 101;
      SetColor   : constant := 102;
      State      : constant := 107;
      GetPower   : constant := 116;
      SetPower   : constant := 117;
      StatePower : constant := 118;
   end Light_Messages;

end LIFX.Messages.Constants;
