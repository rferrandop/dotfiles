#!/bin/bash
set -eufo pipefail

sudo dnf -y install pipewire wireplumber

sudo systemctl enable --now pipewire
