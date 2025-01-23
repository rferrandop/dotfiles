FROM archlinux

# Install chezmoi
RUN pacman-db-upgrade
RUN pacman -Syyu --noconfirm
RUN pacman -Sy chezmoi --noconfirm

# Init chezmoi
RUN chezmoi init rferrandop --promptDefaults

# Apply changes
RUN chezmoi apply




