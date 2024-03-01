{
  config,
  pkgs,
  ...
}: {
  boot = {
    # Erase your darlings
    # initrd.systemd.enable = lib.mkDefault true;
    # initrd.systemd.services.rollback = {
    #   description = "Rollback root filesystem to a pristine state on boot";
    #   wantedBy = [
    #     # "zfs.target"
    #     "initrd.target"
    #   ];
    #   after = [
    #     "zfs-import-rpool.service"
    #   ];
    #   before = [
    #     "sysroot.mount"
    #   ];
    #   path = with pkgs; [
    #     zfs
    #   ];
    #   unitConfig.DefaultDependencies = "no";
    #   serviceConfig.Type = "oneshot";
    #   script = ''
    #     zfs rollback -r rpool/nixos/local/root@blank && echo "  >> >> rollback complete << <<"
    #   '';
    # };

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };

  # Other useful settings come from srvos's zfs module
  environment.systemPackages = [
    pkgs.zfs-prune-snapshots
  ];

  disko.devices = {
    disk = {
      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          compression = "lz4";
          xattr = "sa";
          atime = "off";
          acltype = "posixacl";
          "com.sun:auto-snapshot" = "false";
        };
        postCreateHook = "zfs snapshot zroot/local/root@blank";
        datasets = {
          "local" = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              # encryption = "aes-256-gcm";
              # keyformat = "passphrase";
              # keylocation = "file:///tmp/secret.key";
            };
          };
          "local/root" = {
            type = "zfs_fs";
            mountpoint = "/";
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "safe" = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
            };
          };
          "safe/home" = {
            type = "zfs_fs";
            mountpoint = "/home";
          };
          "safe/persist" = {
            type = "zfs_fs";
            mountpoint = "/persist";
          };
        };
      };
    };
  };
}
