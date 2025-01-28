#!/bin/bash

sudo pacman -Sy --noconfirm bluez bluez-utils blueman

sudo systemctl enable --now bluetooth.service
