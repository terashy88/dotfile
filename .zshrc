#!/usr/bin/env zsh

autoload_() {

    # Enable ZSH completions / Bash / aliasrc

    # bash_() {
    #     # Workaround if ZSH problem
    #     echo "back to bash"
    #     exec /bin/bash
    # }
    # bash_

    autoload -Uz compinit promptinit zcalc colors
    compinit -id
    promptinit
    colors

    aliasrc_() {

        aliasrc_=~/ownCloud/dotfile/.aliasrc
        [[ -f $aliasrc_ ]] && source $aliasrc_
    }
    aliasrc_

    echo -e "\033[38;2;164;163;163m$nickname_\033[0m"
}
autoload_

## By the way if it ain't broke, break it then fix it. ##

history_() {
    # if .zshistory is not working check --->> manjaro-zsh-config
    if [[ ! -f $HOME/.config/.zshistory ]]; then
        touch $HOME/.config/.zshistory
    fi

    export HISTFILE="$HOME"/.config/.zshistory
    export HISTSIZE=8888
    export SAVEHIST=8888
    export HISTTIMEFORMAT="[%F %T] "
    export HISTORY_IGNORE="ls:bg:fg:exit:reset:clear:cd:ll:yt:sudo:ssh" # zsh
    export HISTIGNORE="ls:bg:fg:exit:reset:clear:cd:ll:yt:sudo:ssh"     # bash
    export HISTCONTROL="ignoreboth:erasedups:ignorespace"

}
history_

# Browser
if [ -n "$DISPLAY" ]; then
    if command -v brave-beta &>/dev/null; then
        export BROWSER=brave-beta
    elif command -v librewolf &>/dev/null; then
        export BROWSER=librewolf
    fi
fi

if [ -z "$XDG_DATA_DIRS" ]; then
    export XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi

setopt_() {
    # Set/unset  shell options

    setopt checkjobs
    # setopt nocheckjobs       # Don't warn about running processes when exiting

    # setopt correct           # Auto correct mistakes  #! distract
    setopt extendedglob      # Extended globbing. Allows using regular expressions with *
    setopt nocaseglob        # Case insensitive globbing
    setopt rcexpandparam     # Array expension with parameters
    setopt numericglobsort   # Sort filenames numerically when it makes sense
    setopt appendhistory     # Immediately append history instead of overwriting
    setopt histignorealldups # If a new command is a duplicate, remove the older one
    setopt notify
    setopt autoresume
    setopt globdots pushdtohome cdablevars autolist
    # setopt correctall autocd recexact longlistjobs    #! distract
    setopt autopushd pushdminus rcquotes mailwarning
    unsetopt bgnice autoparamslash
    ## This reverts the +/- operators.
    setopt PUSHD_MINUS
    setopt nomatch
    # export setopt checkwinsize       # change winsize if needed    #! distract
    setopt COMPLETE_IN_WORD # Complete from both ends of a word.
    setopt ALWAYS_TO_END    # Move cursor to the end of a completed word.
    setopt PATH_DIRS        # Perform path search even on command names with slashes.
    setopt AUTO_LIST        # Automatically list choices on ambiguous completion.
    setopt AUTO_PARAM_SLASH # If completed parameter is a directory, add a trailing slash.
    setopt interactivecomments
    setopt nobeep
    setopt histignorespace
    setopt histappend             # Don't overwrite
    setopt BANG_HIST              # Treat the '!' character specially during expansion.
    setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
    setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
    setopt SHARE_HISTORY          # Share history between all sessions.
    setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
    setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
    setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
    setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
    setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
    setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
    setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
    # unsetopt beep
    unsetopt MENU_COMPLETE # Do not autoselect the first completion entry.
    unsetopt FLOW_CONTROL  # Disable start/stop characters in shell editor.

    setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

    # Remove duplicate entries
    setopt PUSHD_IGNORE_DUPS
}
setopt_

export_() {

    export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
    # export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
    export XDG_CONFIG_HOME="$HOME"/.config
    export XDG_DATA_HOME="$HOME/.local/share"
    export ZSH_CACHE_DIR="$HOME/.cache/"
    export GOPATH="$XDG_DATA_HOME"/go
    export NVM_DIR="$XDG_DATA_HOME"/nvm
    export XDG_STATE_HOME="$HOME/.local/state"
    export XDG_BIN_HOME="$HOME/.local/bin"
    export XDG_CACHE_DIR="$HOME/.cache"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_LIB_HOME="$HOME/.local/lib"
    export XDG_LIBRARY_DIR="$HOME/.local/lib"
    export CARGO_HOME="$XDG_DATA_HOME"/cargo
    export CONAN_USER_HOME="$XDG_CONFIG_HOME"
    export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
    export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss
    export PYTHONHISTORY="$HOME/.cache"
    export ICEAUTHORITY="$XDG_CACHE_HOME"
    export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube
    export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
    export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
    # export RANDFILE=/path/to/.rnd
    export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
    # export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority     #! not allow for lightDM

    # dirs check with ~/.config/user-dirs.dirs
    export XDG_DESKTOP_DIR="$HOME/Schreibtisch" || export XDG_DESKTOP_DIR="$HOME/Desktop"
    # ! test Dlss
    export XDG_DOWNLOAD_DIR="$HOME/Downloadss"
    # XDG_TEMPLATES_DIR="$HOME/Vorlagen"
    # XDG_PUBLICSHARE_DIR="$HOME/Öffentlich"
    export XDG_DOCUMENTS_DIR="$HOME/ownCloud/D-link"
    export XDG_MUSIC_DIR="$HOME/ownCloud/S-link"
    export XDG_PICTURES_DIR="$HOME/ownCloud/P-link"
    export XDG_VIDEOS_DIR="$HOME/ownCloud/M-link"

    # android sdk / Studio
    export ANDROID_HOME="$HOME/Android/Sdk"
    export PATH=$PATH:"$ANDROID_HOME/tools"
    export PATH=$PATH:"$ANDROID_HOME/emulator"
    export PATH=$PATH:"$ANDROID_HOME/tools/bin"
    export PATH=$PATH:"$ANDROID_HOME/platform-tools"

    # gpodder
    export GPODDER_HOME="$XDG_CONFIG_HOME"/gPodder

    export LD_LIBRARY_PATH="/opt/spflashtool"

    # Prompt Jump
    export ERL_AFLAGS="-kernel shell_history enabled"
    export WORDCHARS=${WORDCHARS//\/[&.;]/} # Don't consider certain characters part of the word

    # Color man pages
    export LESS_TERMCAP_mb=$'\E[01;32m'
    export LESS_TERMCAP_md=$'\E[01;32m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;47;34m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;36m'
    export LESS=-R

    export WGETRC="$XDG_CONFIG_HOME/wgetrc"

    # export JAVA_HOME=""
    # export _JAVA_OPTIONS=""
    # export JAVA_HOME="/usr/lib/jvm/default"
    export JAVA_HOME="/usr/lib/jvm/default-runtime"
    # export JAVA_HOME="/usr/lib/jvm/java-21-openjdk/"
    # export PATH="/usr/lib/jvm/default/bin/:$PATH"

    # aspell
    export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_DATA_HOME/aspell/en.pws; repl $XDG_DATA_HOME/aspell/en.prepl"

    # aws
    export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials, export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

    # ollama
    export OLLAMA_MODELS=$XDG_DATA_HOME/ollama/models
}
export_

env_() {
    # Environment

    # GTK Theme
    # Matcha-dark-sea
    # gsettings set org.gnome.desktop.interface gtk-theme Adwaita

    # test:
    # GTK_THEME=Matcha-dark-sea:dark nemo

    # GTK Icon
    # papirus-maia-icon-theme

    # Wayland --
    # GTK
    # export QT_QPA_PLATFORM=wayland
    #! export QT_STYLE_OVERRIDE="wayland"

    # X11
    # export QT_QPA_PLATFORM="wayland;xcb"
    # QT Gnome
    # export QT_QPA_PLATFORMTHEME="qt6ct" # Gnome / Plasma
    # ! export QT_STYLE_OVERRIDE="qt6ct"
    # export QT_QPA_PLATFORMTHEME="qt5ct" # Gnome
    #! export QT_STYLE_OVERRIDE="qt5ct"

    # waydroid / steam
    # export GBM_BACKEND=nvidia-drm
    # export __GLX_VENDOR_LIBRARY_NAME=nvidia

    # xfce
    # export QT_QPA_PLATFORMTHEME="kvantum" # xfce4
    #! export QT_STYLE_OVERRIDE="kvantum"
    # export QT_QPA_PLATFORMTHEME="kvantum-dark"
    #! export QT_STYLE_OVERRIDE="kvantum-dark"

    # export QT_QPA_PLATFORMTHEME=""
    # export QT_STYLE_OVERRIDE=""

    # which Session
    wich_session() {
        echo $XDG_SESSION_TYPE
    }
    qttest() {
        echo The QT_QPA_PLATFORMTHEME is: $QT_QPA_PLATFORMTHEME
        echo The QT_STYLE_OVERRIDE is: $QT_STYLE_OVERRIDE
    }

    screen_info() {
        xrandr --verbose
    }

    # gsettings get org.gnome.desktop.interface gtk-theme

    # export GTK_THEME=Adwaita-dark
    # export GTK_THEME=Arc-Maia-Dark
    # export QT_AUTO_SCREEN_SCALE_FACTOR=1
    # export GTK2_RC_FILES="$HOME/.config/gtk-4.0"
    # export GTK2_RC_FILES="$HOME/.config/gtk-2.0"
    # export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
    # export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

    # https://wiki.archlinux.org/title/GTK
    # export GDK_DPI_SCALE=0.5
    # xfconf-query -c xsettings -p /Gdk/WindowScalingFactor -s 1
    # gsettings set org.gnome.desktop.interface color-scheme prefer-dark

    # unset QT_STYLE_OVERRIDE
}
env_

ssh_() {
    # https://wiki.archlinux.org/title/GnuPG
    SSH_AGENT_PID=""
    SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

    # Start ssh-agent if not already running
    if ! pgrep -u "$USER" ssh-agent >/dev/null; then
        ssh-agent -t 1h >"$XDG_RUNTIME_DIR/ssh-agent.env"
    fi

    # Source ssh-agent environment variables
    if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
        source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
    fi

    # Forwarding ssh-agent
    if [[ -z "${SSH_CONNECTION}" ]]; then
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    fi

    # Start ssh-agent, add key to Agent and show Agent
    if ! pgrep -x ssh-agent >/dev/null; then
        eval "$(ssh-agent -s)" >/dev/null
        if [ -d "$HOME/.ssh" ]; then
            ssh-add ~/.ssh/* && ssh-add -l
        else
            echo 'no SSH key found'
        fi
    fi

    #  keychain
    keychain_() {

        # keychain ~/.ssh/id_*
        # shellcheck source=/dev/null
        [ -f ~/.keychain/"$HOSTNAME"-sh ] && . ~/.keychain/"$HOSTNAME"-sh 2>/dev/null
        # shellcheck source=/dev/null
        [ -f ~/.keychain/"$HOSTNAME"-sh-gpg ] && . ~/.keychain/"$HOSTNAME"-sh-gpg 2>/dev/null

        keychain -q --absolute --dir "$XDG_RUNTIME_DIR"/keychain
    }
    keychain_

    # ---> to gh_up
    # eval "$(keychain --eval -q gpg ~/.gnupg/**/*)"
    # eval "$(keychain --eval -q --agents ssh ~/.ssh/id_rsa*)"

    ssh_log() {
        journalctl | g ssh
    }

    ssh_check_agent() {
        ssh -V
        ssh-agent
        ssh-add ~/.ssh/id_rsa*
        eval $(ssh-agent)
        ps ax | grep ssh-agent

        ssh-add -l
    }

    # SSH
    ssh-keygen_() {
        # Prompt for email address
        echo "Enter your email address: "
        read -r email

        # Generate new SSH key with passphrase
        echo "Generating new SSH key with passphrase..."
        if ! ssh-keygen -t rsa -b 4096 -C "$email" -N ""; then
            echo "Error generating SSH key."
            exit 1
        fi

        # Add public key to SSH agent
        eval "$(ssh-agent -s)" >/dev/null 2>&1
        echo "Adding public key to SSH agent..."
        if ! ssh-add ~/.ssh/id_rsa; then
            echo "Error adding public key to SSH agent."
            exit 1
        fi

        echo "SSH key added successfully."
    }
    #todo alias ssh='enable sshd.service; ssh; disable sshd.service'
}
ssh_

gpg_() {
    # GPG  https://keys.openpgp.org/
    gpg-status() {
        gpg -k
        echo "test" | gpg --clearsign
        gpg --list-keys
        gpg --list-secret-keys
        echo "test agent:.."
        gpg-connect-agent reloadagent /bye
    }
    gpg-setnew() {
        gpg --full-generate-key --expert
    }

    gpg-manjaro() {
        wget gitlab.manjaro.org/packages/core/manjaro-keyring/-/raw/master/manjaro.gpg
        gpg --import manjaro.gpg
        gpg --verify manjaro-ISO-image.iso.sig manjaro-ISO-image.iso
    }

    keychain_clear() {
        # Clearing Keys in Memory
        keychain --clear
    }

    gpg_reload() {
        gpg-connect-agent reloadagent /bye
    }

    keygrip_() {
        gpg --list-keys --with-keygrip
    }

    encryption_() {
        # todo encrypt not working
        decrypt_gpg() {
            gpg --recipient "$mail_" --encrypt "$@"
        }
        encrypt_gpg() {
            gpg --output "$2" --decrypt "$1"
        }
    }
    encryption_

    # pinentry-tty
    export GPG_TTY=$(tty)
}
gpg_

bindkey_() {
    # Keybindings section #    "bindkey -L"  to get all the bindkey info
    zmodload -i zsh/complist
    bindkey -M menuselect '^h' vi-backward-char
    bindkey -M menuselect '^j' vi-down-line-or-history
    bindkey -M menuselect '^k' vi-up-line-or-history
    bindkey -M menuselect '^l' vi-forward-char
    # bind UP and DOWN arrow keys to history substring search
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    # bindkey -e
    bindkey '^[[7~' beginning-of-line # Home key
    bindkey '^[[H' beginning-of-line  # Home key
    if [[ "${terminfo[khome]}" != "" ]]; then
        bindkey "${terminfo[khome]}" beginning-of-line # [Home] - Go to beginning of line
    fi
    bindkey '^[[8~' end-of-line # End key
    bindkey '^[[F' end-of-line  # End key
    if [[ "${terminfo[kend]}" != "" ]]; then
        bindkey "${terminfo[kend]}" end-of-line # [End] - Go to end of line
    fi
    bindkey '^[[2~' overwrite-mode                    # Insert key
    bindkey '^[[3~' delete-char                       # Delete key
    bindkey '^[[C' forward-char                       # Right key
    bindkey '^[[D' backward-char                      # Left key
    bindkey '^[[5~' history-beginning-search-backward # Page up key
    bindkey '^[[6~' history-beginning-search-forward  # Page down key
    bindkey '^[Oc' forward-word                       #
    bindkey '^[Od' backward-word                      #
    bindkey '^[[1;5D' backward-word                   #
    bindkey '^[[1;5C' forward-word                    #
    bindkey '^H' backward-kill-word                   # delete previous word with ctrl+backspace
    bindkey '^[[3;5~' kill-word
    bindkey '^[[Z' undo # Shift+tab undo last action

    bindkey '^a' alias-expension
    bindkey '^A' beginning-of-line

    autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search

    [[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
    [[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

    rationalise-dot() {
        if [[ $LBUFFER = *.. ]]; then
            LBUFFER+=/..
        else
            LBUFFER+=.
        fi
    }
    zle -N rationalise-dot
    bindkey . rationalise-dot

    function clear-screen-and-scrollback() {
        echoti civis >"$TTY"
        printf '%b' '\e[H\e[2J' >"$TTY"
        zle .reset-prompt
        zle -R
        printf '%b' '\e[3J' >"$TTY"
        echoti cnorm >"$TTY"
    }

    zle -N clear-screen-and-scrollback
    bindkey '^L' clear-screen-and-scrollback
}
bindkey_

# Suffix alias for opening PDF files with the default program
alias -s pdf='opendefaultpdf'
# Define suffix aliases for image files
alias -s '{jpg,jpeg,png,gif,bmp,tiff,webp}'=imgopen '\$1'

# help like "man" zb. run-help git
autoload -Uz run-help
autoload -Uz run-help-ip
autoload -Uz run-help-p4
autoload -Uz run-help-git
autoload -Uz run-help-svn
autoload -Uz run-help-svk
autoload -Uz run-help-sudo
autoload -Uz run-help-openssl
alias help=run-help

.profile_() {

    # Set our umask
    umask 022
    # Append "$1" to $PATH when not already in.
    # This function API is accessible to scripts in /etc/profile.d
    append_path() {
        case ":${PATH}:" in
        *:"$1":*) ;;
        *)
            PATH="${PATH:+${PATH}:}$1"
            ;;
        esac
    }

    # Append our default paths
    append_path '/usr/local/sbin'
    append_path '/usr/local/bin'
    append_path '/usr/bin'

    # Force PATH to be environment
    export PATH

    # Load profiles from /etc/profile.d
    if test -d /etc/profile.d/; then
        for profile in /etc/profile.d/*.sh; do
            test -r "${profile}" && . "${profile}"
        done
        unset profile
    fi

    # Unload our profile API functions
    unset -f append_path

    # Source global bash config, when interactive but not posix or sh mode
    if test "$BASH" &&
        test "$PS1" &&
        test -z "$POSIXLY_CORRECT" &&
        test "${0#-}" != sh &&
        test -r /etc/bash.bashrc; then
        . /etc/bash.bashrc
    fi

    # Termcap is outdated, old, and crusty, kill it.
    unset TERMCAP

    # Man is much better than us at figuring this out
    unset MANPATH
}
.profile_

prompt_() {

    # prompt #todo
    PS1="%B-= %{$fg[yellow]%}%n%{$fg[green]%} =-$reset_color%}$%b "
    PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '
    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

    powerline_() {
        # Use powerline manjaro-zsh-config
        USE_POWERLINE="true"
        # Source manjaro-zsh-configuration #! conflict default .zshrc settings
        # if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
        #     source /usr/share/zsh/manjaro-zsh-config
        # fi
        # Use manjaro zsh prompt
        if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
            source /usr/share/zsh/manjaro-zsh-prompt
        fi

        # starship prompt
        eval "$(starship init zsh)"

    }
    powerline_
}
prompt_

zstyle_() {

    compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
    export fpath=(/usr/local/share/zsh-completions $fpath)
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

    zstyle ':completion:*' cache-path $XDG_CACHE_HOME/

    # Add completion for the touch command
    zstyle ':completion:*:*:touch:*' file-patterns '*'

    # enable tab completion for image files
    zstyle ':completion:*:*:img:*' file-patterns '*.(#i)(jpg|jpeg|png|gif|bmp|tiff|webp)'

    # The following lines were added by compinstall
    zstyle :compinstall filename "~/.zshrc"

    # allow one error for every three characters typed in approximate completer
    zstyle -e ':completion:*:approximate:*' max-errors \ 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*' tag-order all-expansions
    # formatting and messages
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:messages' format '%d'
    zstyle ':completion:*:warnings' format 'No matches for: %d'
    zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

    # # match uppercase from lowercase
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

    # # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # # ignore completion functions (until the _ignored completer)
    zstyle ':completion:*:functions' ignored-patterns '_*'

    # if only directory path is entered, cd there.
    zstyle ':completion::complete:*' gain-privileges 1
    zstyle ':completion:*' menu select

    zstyle ':completion:*' rehash true # automatically find new executables in path
    # Speed up completions
    zstyle ':completion:*' accept-exact '*(N)'
    zstyle ':completion:*' use-cache on

    zstyle ':completion:*' completions 1
    zstyle ':completion:*' format '0 %d'
    zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
    zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
    zstyle ':completion:*' glob 1
    zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    zstyle ':completion:*' max-errors 2
    zstyle ':completion:*' substitute 1
    zstyle :compinstall filename '~/.zshrc'

    # To format messages or warnings (for example when no match is found), you can add the following:
    zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
    zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
    # Group matches and describe.
    zstyle ':completion:*:default' menu select=2

    # # Completing Groping
    zstyle ':completion:*:options' description 'yes'
    zstyle ':completion:*:options' auto-description '%d'
    zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
    zstyle ':completion:*' file-sort dummyvalue

    zle -C alias-expension complete-word _generic

    zstyle ':completion:alias-expension:*' completer _expand_alias

    # Completing misc
    zstyle ':completion:*:*:cp:*' file-sort modification reverse
    zstyle ':completion:*' complete-options true
    zstyle ':completion:*' squeeze-slashes true
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list
    zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
    zstyle ':completion:*' use-cache true
    zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
    zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
    zstyle ':completion:*' completer _complete _match _approximate
    zstyle ':completion:*:match:*' original only
    zstyle ':completion:*:approximate:*' max-errors 1 numeric
    zstyle ':completion:*:*:kill:*' menu yes select
    zstyle ':completion:*:kill:*' force-list always
    zstyle -e ':completion:*:approximate:*' \ max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

    xdvi() {
        command xdvi ${*:-*.dvi(om[1])}
    }

    # Directory
    zstyle ':completion:*:cd:*' ignore-parents parent pwd
    zstyle ':completion:*' file-list all
    zstyle ':completion:*:*:xdvi:*' menu yes select
    zstyle ':completion:*:*:xdvi:*' file-sort time

    # completion system
    zstyle ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )' # allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'                     # don't complete backup files as executables
    zstyle ':completion:*:correct:*' insert-unambiguous true                                       # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'              #
    zstyle ':completion:*:correct:*' original true                                                 #
    zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'           # format on

    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select # complete 'cd -<tab>' with menu
    zstyle ':completion:*:expand:*' tag-order all-expansions      # insert all expansions for expand completer
    zstyle ':completion:*:history-words' list false               #
    zstyle ':completion:*:history-words' menu yes                 # activate menu
    zstyle ':completion:*:history-words' remove-all-dups yes      # ignore duplicate entries
    zstyle ':completion:*:history-words' stop yes                 #
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'           # match uppercase from lowercase
    zstyle ':completion:*:matches' group 'yes'                    # separate matches into groups
    zstyle ':completion:*' group-name ''

    zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
    zstyle ':completion:*:messages' format '%d'                                       #
    zstyle ':completion:*:options' auto-description '%d'                              #
    zstyle ':completion:*:options' description 'yes'                                  # describe options in full
    zstyle ':completion:*:processes' command 'ps -au$USER'                            # on processes completion complete all user processes
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters               # offer indexes before parameters in subscripts
    zstyle ':completion:*' verbose true                                               # provide verbose completion information
    zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d' # set format for warnings
    zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'                 # define files to ignore for zcompile
    zstyle ':completion:correct:' prompt 'correct to: %e'                             # todo test
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'           # Ignore completion functions for commands you don't have:

    # complete manual by their section
    zstyle ':completion:*:manuals' separate-sections true
    zstyle ':completion:*:manuals.*' insert-sections true
    zstyle ':completion:*:man:*' menu yes select
    # command for process lists, the local web server details and host completion
    zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'

    zstyle ':completion:*:hosts' hosts $hosts

    # My zsh configurations (Based on the Manjaro ZSH config)
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

    zstyle ':completion:*:*:cp:*' file-sort size
    zstyle ':completion:*' file-sort modification

    # Establish default values for styles, but only if not already set
    zstyle -m :bracketed-paste-magic active-widgets '*' ||
        zstyle ':bracketed-paste-magic' active-widgets 'self-*'

    # Helper/example paste-init for exposing a word prefix inside PASTED.
    # Useful with url-quote-magic if you have http://... on the line and
    # are pasting additional text on the end of the URL.
    #
    # Usage:
    zstyle :bracketed-paste-magic paste-init backward-extend-paste
    #

    # Handle zsh autoloading conventions
    if [[ "$zsh_eval_context" = *loadautofunc && ! -o kshautoload ]]; then
        bracketed-paste-magic "$@"
    fi

    # Autoload zsh modules when they are referenced
    zmodload -a zsh/zpty zpty
    zmodload -a zsh/zprof zprof
    zmodload -ap zsh/mapfile mapfile
    # stat(1) is now commonly an external command, so just load zstat
    zmodload -aF zsh/stat b:zstat

    ZSH_THEME="random" # theme of oh-my-zsh
    # ZSH_THEME="robbyrussell"
    # export ZSH_THEME="eastwood"
    # export ZSH_THEME="agnoster"
}
zstyle_

plugin_() {
    # Source Plugin Extension

    # dir-colors
    [[ -f ~/.config/.dir_colors ]] && eval $(dircolors ~/.config/.dir_colors)
    # p10k #! starting zsh config
    [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
    # profile
    [ -f /etc/profile ] && source /etc/profile
    # powerlevel10k icons
    [[ -f /usr/share/zsh-theme-powerlevel10k/internal/icons.zsh ]] && source /usr/share/zsh-theme-powerlevel10k/internal/icons.zsh
    # zsh-autosuggestions
    [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    # zsh-history-substring-search
    [[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
    # zsh-syntax-highlighting
    [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # powerlevel10k theme
    [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]] && source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
    [[ -f $HOME/ownCloud/p-git/p-aliasrc ]] && source "$HOME"/ownCloud/p-git/p-aliasrc
    # oh-my-zsh #! de-install
    #! terminal Enter problem on f7 PC
    # [[ -f /usr/share/oh-my-zsh/oh-my-zsh.sh ]] && source /usr/share/oh-my-zsh/oh-my-zsh.sh

}
plugin_

: <<EO


echo 'you can't see me'

EO
