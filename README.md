# NixOS

My personal NixOS configurations.

## Structure

- `flake.nix`: Entrypoint for hosts and home configurations. Also exposes a devshell for boostrapping (nix develop or nix-shell).
- `/home`: Home-Manager configurations
- `/hosts`: NixOS Configurations
  - `/common`: Shared configurations consumed by the machine-specific ones.
  - `/common/global`: Configurations that are globally applied to all my machines.
  - `/common/optional`: Opt-in configurations my machines can use.
  - `/homepi`: Raspberry Pi 4 - 8GB RAM, 32GB SD Card | Server
  - `/mbp2021`: MacBook Pro M1 16" (2021) - 16GB RAM | Laptop
- `/modules`: Custom modules for NixOS and Home-Manager
- `/overlays`: Patches and version overrides for some packages

## Acknowledgements

The structure and functionality of this repository is heavily inspired by [konradmalik/dotfiles](https://github.com/konradmalik/dotfiles).