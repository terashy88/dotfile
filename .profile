#!/usr/bin/env bash

## startup script       #! gui tool doesn't work properly

firewall_() {
    # Check if ufw is running
    if ! sudo systemctl status "ufw" | grep "active" >/dev/null; then
        # Activate ufw
        echo 'Your Firewall is not active'
        echo 'activating...'
        sudo ufw enable || true

    fi
}
firewall_

# Set all Java apps to use GTK+ font & theme settings
# export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel ${_JAVA_OPTIONS}"

# shellcheck source=/dev/null
[[ -f ~/.config/zsh/.zshenv ]] && . ~/.config/zsh/.zshenv

# Startup
# STARTUP() {# Autostart X at login
# if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#     exec startx
# fi

# # Wait for system to fully start up
# sleep 3

# Loop through all arguments (commands)
# for cmd in "$@"; do
#     # Check if command exists and start it
#     if command -v "$cmd" >/dev/null; then
#         if ! pgrep -x "$cmd" >/dev/null; then
#             "$cmd" &
#         fi
#     done
# }

# Call STARTUP with commands to start   #! use system starup if syncing on different PC
# STARTUP imwheel barrier caffeine "gammastep-indicator -t 5000:4100" /usr/bin/owncloud syncthing "telegram-desktop -- %u" "/opt/cisco/secureclient/bin/vpnui" "whatsapp-nativefier"

keychain_() {

    keychain ~/.ssh/id_*
    # keychain ~/.ssh/id_ecdsa
    # shellcheck source=/dev/null
    [ -f ~/.keychain/"$HOSTNAME"-sh ] && . ~/.keychain/"$HOSTNAME"-sh 2>/dev/null
    # shellcheck source=/dev/null
    [ -f ~/.keychain/"$HOSTNAME"-sh-gpg ] && . ~/.keychain/"$HOSTNAME"-sh-gpg 2>/dev/null
}
keychain_
