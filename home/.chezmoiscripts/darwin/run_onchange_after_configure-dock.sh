#!/bin/bash

set -eufo pipefail

trap 'killall Dock' EXIT

declare -a remove_labels=(
	Launchpad
	Safari
	Messages
	Mail
	Maps
	Photos
	FaceTime
	Calendar
	Contacts
	Reminders
	Notes
	Freeform
	TV
	Music
	Keynote
	Numbers
	Pages
	"App Store"

    # In order to have a declarative-like dock setup, remove and then add again
    Alacritty
    kitty
    "Brave Browser"
    "Microsoft Teams"
    Spotify
)

for label in "${remove_labels[@]}"; do
	dockutil --no-restart --remove "${label}" || true
done

dockutil --add /Applications/kitty.app
dockutil --add "/Applications/Brave Browser.app"
dockutil --add "/Applications/Microsoft Teams.app"
dockutil --add /Applications/Spotify.app


