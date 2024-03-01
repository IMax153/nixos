{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
  ];

  boot = {
    initrd.availableKernelModules = ["ehci_pci" "ahci" "mpt3sas" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
    kernelModules = ["kvm-intel"];
    kernel.sysctl = {
      "net.ipv4.ip_forward" = true;
      "net.ipv6.conf.all.forwarding" = true;
    };
    loader = {
      systemd-boot.enable = true;
      # Set to `true` when installing NixOS on a new machine!
      efi.canTouchEfiVariables = false;
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
