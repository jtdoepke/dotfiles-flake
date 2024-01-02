{
  config,
  pkgs,
  lib,
  inputs,
  modulesPath,
  ...
}:
{
  zfs-root = {
    boot = {
      devNodes = "/dev/disk/by-id/";
      bootDevices = [
        "ata-VBOX_HARDDISK_VBdafbc84f-ba848264"
        "ata-VBOX_HARDDISK_VB0139ec5c-51d482be"
      ];
      immutable.enable = false;
      removableEfi = true;
      luks.enable = true;
    };
  };
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "ohci_pci"
    "ehci_pci"
    "ahci"
    "sd_mod"
    "sr_mod"
  ];
  boot.kernelParams = [ ];
  networking.hostId = "ea7e037b";
  networking.hostName = "bertha-vm";
  time.timeZone = "America/Chicago";

  # import preconfigured profiles
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # (modulesPath + "/profiles/hardened.nix")
    # (modulesPath + "/profiles/qemu-guest.nix")
    ../../imports/profiles/server.nix
  ];
}
