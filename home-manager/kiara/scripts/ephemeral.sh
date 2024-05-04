#!/usr/bin/env -S nix shell nixpkgs#jaq --command sh
set -x
DIR="${1:-$HOME}"
find $DIR $(nix eval .#nixosConfigurations.default.config.disko.devices.disk."main".content.partitions.luks.content.content.subvolumes --json | jaq -r '.[].mountpoint | select(. != "/") | "-path " + . + " -prune -o"') $(nix eval .#nixosConfigurations.default.config.environment.persistence."/persist".directories --json | jaq -r '.[].dirPath | "-path " + . + " -prune -o"') $(nix eval .#nixosConfigurations.default.config.environment.persistence."/persist".files --json | jaq -r '.[].filePath | "-path " + . + " -prune -o"') $(nix eval .#nixosConfigurations.default.config.environment.persistence."/persist".users.kiara.directories --json | jaq -r '.[].dirPath | "-path " + . + " -prune -o"') $(nix eval .#nixosConfigurations.default.config.environment.persistence."/persist".users.kiara.files --json | jaq -r '.[].filePath | "-path " + . + " -prune -o"') -type f -printf '%p\n'
