# Nix Configuration

## Secret Management

This project makes use of [Mozilla SOPS (Secrets OPerationS)](https://github.com/mozilla/sops)

The [`.sops.yaml`](./.sops.yaml) file at the root of the repository defines creation rules for secrets to be encrypted with `sops`. Any files matching the defined creation rule paths will be encrypted with the specified public keys.

### Updating Secrets

To update secret files after making changes to the `.sops.yaml` file, run the snippet below:

```bash
find . -regex $(yq -r '[.creation_rules[] | "./" + .path_regex] | join("\\|")' "$(pwd)/.sops.yaml") | \
xargs -i sops updatekeys -y {}
```