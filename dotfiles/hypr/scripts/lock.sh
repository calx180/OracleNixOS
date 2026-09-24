
#!/usr/bin/env bash
# ~/.config/hypr/scripts/lock.sh
# Bound to SUPER+L.
#
# grim is no longer needed — hyprlock.conf now uses background.path =
# screenshot, so hyprlock captures the screen itself (GPU-accelerated) the
# moment it starts. This script is just a thin wrapper in case you want to
# add more logic later (e.g. muting notifications before locking).

exec hyprlock
