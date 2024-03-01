{modulesPath, ...}: {
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "virtio_scsi" "usbhid"];
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
}
