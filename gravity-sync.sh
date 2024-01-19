curl -sSL https://raw.githubusercontent.com/vmstan/gs-install/main/gs-install.sh | bash

gravity-sync config

### INITIAL SYNC (from authority server) ###
gravity-sync push

### STANDARD SYNC ###
gravity-sync

### SCHEDULED SYNC ###
gravity-sync auto
