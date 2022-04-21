#! /usr/bin/env bash

groupadd nixbld -g 30000 || true

for i in {1..10}; do
  useradd -c "Nix build user $i" -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(which nologin)" "nixbld$i" || true
done

curl -L https://nixos.org/nix/install | sh

. /root/.nix-profile/etc/profile.d/nix.sh

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | \
	NIX_CHANNEL=nixos-unstable \
	NIXOS_CONFIG=/tmp/nix-master/configuration.nix \
	bash 2>&1 | tee /tmp/infect.log
