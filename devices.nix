{ config, ... }:

{
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  hardware.opentabletdriver.blacklistedKernelModules = [
    "hid-uclogic"
    "wacom"
  ];
}
