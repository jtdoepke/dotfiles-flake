{ config, pkgs, lib, inputs, modulesPath, ... }: {
  zfs-root = {
    boot = {
      devNodes = "/dev/disk/by-id/";
      bootDevices = [ "ata-Samsung_SSD_860_PRO_1TB_S5G8NS0R104172Z" "ata-Samsung_SSD_860_PRO_1TB_S5G8NS0R104173P" ];
      immutable.enable = false;
      removableEfi = true;
      luks.enable = true;
    };
  };
  boot.initrd.availableKernelModules = [  "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelParams = [ ];
  networking.hostId = "35690e3b";
  networking.hostName = "bertha";
  time.timeZone = "America/Chicago";

  # import preconfigured profiles
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # (modulesPath + "/profiles/hardened.nix")
    # (modulesPath + "/profiles/qemu-guest.nix")
    ../../imports/profiles/server.nix
  ];
}
