#!/usr/bin/env zsh
# LANG="UTF-8"
autoload_() {
    # Enable ZSH completions / Bash / aliasrc

    # bash() {
    #     # Workaround if ZSH problem
    #     echo "back to bash"
    #     exec /bin/bash
    # }
    # bash

    autoload -Uz compinit promptinit zcalc colors
    compinit -id
    promptinit
    colors

    aliasrc_() {
        # aliasrc
        aliasrc_=~/ownCloud/dotfile/.aliasrc
        [[ -f $aliasrc_ ]] && source $aliasrc_
    }
    aliasrc_

    echo -e "\033[38;2;164;163;163m$nickname_\033[0m"
}
autoload_

## By the way if it ain't broke, break it then fix it. ##

history_() {
    # History - config
    export HISTFILE=$HOME/.config/.zshistory
    export HISTSIZE=8888
    export SAVEHIST=8888
    export HISTTIMEFORMAT="[%F %T] "
    export HISTORY_IGNORE="ls:bg:fg:exit:reset:clear:cd:ll:yt:sudo:ssh" # zsh #! alias not working
    export HISTIGNORE="   :ls:bg:fg:exit:reset:clear:cd:ll:yt:sudo:ssh" # bash
    export HISTCONTROL="ignoreboth:erasedups:ignorespace"
}
history_

# Browser
if [ -n "$DISPLAY" ]; then
    export BROWSER=brave-beta
else
    export BROWSER=librewolf
fi

if [ -z "$XDG_DATA_DIRS" ]; then
    export XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi

path_() {
    typeset -U path PATH
    export path=(~/.local/bin $path)
    export PATH
    # PATH 'short form "-P"'
    # If user ID is greater than or equal to 1000 & if ~/bin exists and is a directory & if ~/bin is not already in your $PATH
    # then export ~/bin to your $PATH.
    if [[ $UID -ge 1000 && -d ~/ownCloud/.bin ]]; then
        export PATH="${PATH}:~/ownCloud/.bin"
    fi
}
path_

setopt_() {
    ## Setopt section

    # setopt correct           # Auto correct mistakes  #! distract
    setopt extendedglob      # Extended globbing. Allows using regular expressions with *
    setopt nocaseglob        # Case insensitive globbing
    setopt rcexpandparam     # Array expension with parameters
    setopt nocheckjobs       # Don't warn about running processes when exiting
    setopt numericglobsort   # Sort filenames numerically when it makes sense
    setopt appendhistory     # Immediately append history instead of overwriting
    setopt histignorealldups # If a new command is a duplicate, remove the older one
    setopt notify

    # Set/unset  shell options
    setopt autoresume histignoredups
    setopt globdots pushdtohome cdablevars autolist
    # setopt correctall autocd recexact longlistjobs    #! distract
    setopt autopushd pushdminus rcquotes mailwarning
    unsetopt bgnice autoparamslash
    ## This reverts the +/- operators.
    setopt PUSHD_MINUS
    setopt nomatch
    # export setopt checkwinsize              # change winsize if needed    #! distract

    setopt COMPLETE_IN_WORD # Complete from both ends of a word.
    setopt ALWAYS_TO_END    # Move cursor to the end of a completed word.
    setopt PATH_DIRS        # Perform path search even on command names with slashes.
    setopt AUTO_MENU        # Show completion menu on a succesive tab press.
    setopt AUTO_LIST        # Automatically list choices on ambiguous completion.
    setopt AUTO_PARAM_SLASH # If completed parameter is a directory, add a trailing slash.
    ## Setopt section
    setopt interactivecomments
    setopt nobeep
    setopt histignorespace
    setopt histappend # Don't overwrite
    setopt no_nomatch
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
    setopt checkjobs
    unsetopt beep
    unsetopt MENU_COMPLETE # Do not autoselect the first completion entry.
    unsetopt FLOW_CONTROL  # Disable start/stop characters in shell editor.
}
setopt_

export_() {

    export VARIABLE="content"
    export GOPATH="$XDG_DATA_HOME"/go
    export ZSH_CACHE_DIR="$HOME/.cache/"
    export NVM_DIR="$XDG_DATA_HOME"/nvm
    export XDG_DATA_HOME="$HOME/.local/share"
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
    export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
    export PYTHONHISTORY="$HOME/.cache"
    export ICEAUTHORITY="$XDG_CACHE_HOME"
    export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube
    export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
    export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
    export RANDFILE=/path/to/.rnd
    export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
    export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
    # export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority     #! not for lightDM

    # dirs check with ~/.config/user-dirs.dirs
    export XDG_DESKTOP_DIR="$HOME/Schreibtisch"
    export XDG_DOWNLOAD_DIR="$HOME/Downloads"
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

    export LD_LIBRARY_PATH="/opt/spflashtool"

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

}
export_

env_() {

    # Environment
    # Wayland
    # GTK   #!..added gtk4
    # GDK_BACKEND=x11
    # QT_QPA_PLATFORM=wayland
    # export QT_STYLE_OVERRIDE="wayland"

    # X11
    # QT_QPA_PLATFORM="wayland;xcb"
    # QT Gnome
    export QT_QPA_PLATFORMTHEME="qt6ct" # Gnome / Plasma
    # export QT_STYLE_OVERRIDE="qt6ct"
    # export QT_QPA_PLATFORMTHEME="qt5ct" # Gnome
    # export QT_STYLE_OVERRIDE="qt5ct"

    # waydroid
    # GBM_BACKEND=nvidia-drm
    # __GLX_VENDOR_LIBRARY_NAME=nvidia

    # xfce
    # export QT_QPA_PLATFORMTHEME="kvantum" # xfce4
    # export QT_STYLE_OVERRIDE="kvantum"
    # export QT_QPA_PLATFORMTHEME="kvantum-dark"
    # export QT_STYLE_OVERRIDE="kvantum-dark"

    # which Session
    alias wich_session='echo $XDG_SESSION_TYPE'

    alias qttest="echo The QT_QPA_PLATFORMTHEME is: $QT_QPA_PLATFORMTHEME;
echo The QT_STYLE_OVERRIDE is: $QT_STYLE_OVERRIDE"
    # export GTK_THEME=Arc-Maia-Dark
    # export QT_AUTO_SCREEN_SCALE_FACTOR=1
    # export GTK2_RC_FILES="$HOME/.config/gtkrc-4"
    # export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
}
env_

ssh_() {
    SSH_AGENT_PID=""
    SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi

    # Start ssh-agent if not already running
    if ! pgrep -u "$USER" ssh-agent >/dev/null; then
        ssh-agent -t 1h >"$XDG_RUNTIME_DIR/ssh-agent.env"
    fi

    # Source ssh-agent environment variables
    if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
        source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
    fi

    if [[ ! -n ${SSH_CONNECTION} ]]; then
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
    keychain -q --absolute --dir "$XDG_RUNTIME_DIR"/keychain
    # eval "$(keychain --eval -q gpg ssh id_rsa)"
    # eval "$(keychain --eval -q --agents ssh id_rsa)"

    ssh_log() {
        journalctl | g ssh
    }

    ssh_check_agent() {
        ssh-agent
        ssh -V
        ssh-add -l
    }

    # SSH
    alias ssh-copypub='ssh-copy-id -fi ~/.ssh/id_rsa.pub'
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
    alias ssh-keygen_status=' ssh-keygen -lf ~/.ssh/id_rsa.pub'
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

    export GPG_TTY=$(tty)
    gpg-connect-agent updatestartuptty /bye >/dev/null

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
}
gpg_

powerline_() {
    # Use powerline manjaro-zsh-config #todo
    USE_POWERLINE="true"
    # Source manjaro-zsh-configuration
    if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
        source /usr/share/zsh/manjaro-zsh-config
    fi
    # Use manjaro zsh prompt
    if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
        source /usr/share/zsh/manjaro-zsh-prompt
    fi

    # starship prompt
    # eval "$(starship init zsh)"

    install_powerline_precmd() {
        for s in "${precmd_functions[@]}"; do
            if [ "$s" = "powerline_precmd" ]; then
                return
            fi
        done
        precmd_functions+=(powerline_precmd)
    }

    if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
        install_powerline_precmd
    fi
}
powerline_

zstyle_() {
    # ZDOTDIR="$XDG_CONFIG_HOME/zsh"    #! break terminal in vscodium
    export fpath=(/usr/local/share/zsh-completions $fpath)
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

    zstyle ':completion:*' cache-path $XDG_CACHE_HOME/

    # Add completion for the touch command
    zstyle ':completion:*:*:touch:*' file-patterns '*'

    # enable tab completion for image files
    zstyle ':completion:*:*:img:*' file-patterns '*.(#i)(jpg|jpeg|png|gif|bmp|tiff|webp)'

    # The following lines were added by compinstall
    zstyle :compinstall filename '/home/shaderico/.zshrc'

    # allow one error for every three characters typed in approximate completer
    zstyle -e ':completion:*:approximate:*' max-errors \ 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*' tag-order all-expansions
    # formatting and messages
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:messages' format '%d'
    zstyle ':completion:*:warnings' format 'No matches for: %d'
    zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
    zstyle ':completion:*' group-name ''

    # # match uppercase from lowercase
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

    # # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # # ignore completion functions (until the _ignored completer)
    zstyle ':completion:*:functions' ignored-patterns '_*'

    # if only directory path is entered, cd there.
    zstyle ':completion::complete:*' gain-privileges 1
    zstyle ':completion:*' menu select
    # zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS }          # Colored completion (different colors for dirs/files/etc)
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
    # zstyle ':completion:*:default'                      list-colors ${(s.:.)LS_COLORS}     # activate color-completion(!) list
    zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}' # format on #! use next line <<- 357:67: parameter expansion requires a literal

    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select # complete 'cd -<tab>' with menu
    zstyle ':completion:*:expand:*' tag-order all-expansions      # insert all expansions for expand completer
    zstyle ':completion:*:history-words' list false               #
    zstyle ':completion:*:history-words' menu yes                 # activate menu
    zstyle ':completion:*:history-words' remove-all-dups yes      # ignore duplicate entries
    zstyle ':completion:*:history-words' stop yes                 #
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'           # match uppercase from lowercase
    zstyle ':completion:*:matches' group 'yes'                    # separate matches into groups
    zstyle ':completion:*' group-name ''
    if [[ -z "$NOMENU" ]]; then
        zstyle ':completion:*' menu select=2 # if there are more than 5 options allow selecting from a menu
    else
        setopt no_auto_menu # don't use any menus at all
    fi

    zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
    zstyle ':completion:*:messages' format '%d'                                       #
    zstyle ':completion:*:options' auto-description '%d'                              #
    zstyle ':completion:*:options' description 'yes'                                  # describe options in full
    zstyle ':completion:*:processes' command 'ps -au$USER'                            # on processes completion complete all user processes
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters               # offer indexes before parameters in subscripts
    zstyle ':completion:*' verbose true                                               # provide verbose completion information
    zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d' # set format for warnings
    zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'                 # define files to ignore for zcompile
    # zstyle ':completion:correct:' prompt 'correct to: %e'                             #
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*' # Ignore completion functions for commands you don't have:

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

}
zstyle_

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

    bindkey -e
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

    #! key[Control - Left]="${terminfo[kLFT5]}"
    #! key[Control - Right]="${terminfo[kRIT5]}"

    [[ -n "${key[Control - Left]}" ]] && bindkey -- "${key[Control - Left]}" backward-word
    [[ -n "${key[Control - Right]}" ]] && bindkey -- "${key[Control - Right]}" forward-word

    # Another method for quick change directories. Add this to your ~/.zshrc, then just enter “cd …./dir"
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

fpath=("$HOME/.zprompts" "$fpath[@]")

# Suffix alias for opening PDF files with the default program
alias -s pdf='opendefaultpdf'
# Define suffix aliases for image files
alias -s '{jpg,jpeg,png,gif,bmp,tiff,webp}'=imgopen '\$1'

# help like "man" zb. run-help git
autoload -Uz run-help
autoload -Uz run-help-ip
autoload -Uz run-help-p4
autoload -Uz run-help-git
autoload -Uz add-zsh-hook
autoload -Uz run-help-svn
autoload -Uz run-help-svk
autoload -Uz run-help-sudo
autoload -Uz run-help-openssl
alias help=run-help

# export DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}"

# (( ${+aliases[run-help]} )) && unalias run-help

# if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
#     dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
#     [[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
# fi

# export DIRSTACKSIZE='20'

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

# Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

autoload -Uz add-zsh-hook

rehash_precmd() {
    if [[ -e /var/cache/zsh/pacman ]]; then
        local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
        if ((zshcache_time < paccache_time)); then
            rehash
            zshcache_time="$paccache_time"
        fi
    fi
}

autoload -Uz add-zsh-hook

function xterm_title_precmd() {
    print -Pn -- '\e]2;%n@%m %~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

# function xterm_title_preexec () {
#     print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
#     [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
# }

# if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
#     add-zsh-hook -Uz precmd xterm_title_precmd
#     add-zsh-hook -Uz preexec xterm_title_preexec
# fi

autoload -Uz add-zsh-hook

function xterm_title_precmd() {
    print -Pn -- '\e]2;%n@%m %~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

# function xterm_title_preexec () {
# 	# print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
# 	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
# }

# if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
# 	add-zsh-hook -Uz precmd xterm_title_precmd
# 	add-zsh-hook -Uz preexec xterm_title_preexec
# fi

# exit_zsh() { exit }
# zle -N exit_zsh
# bindkey '^D' exit_zsh

# function command_not_found_handler {
#     local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
#     printf 'zsh: command not found: %s\n' "$1"
#     local entries=(
#         ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}
#     )
#     if (( ${#entries[@]} ))
#     then
#         printf "${bright}$1${reset} may be found in the following packages:\n"
#         local pkg
#         for entry in "${entries[@]}"
#         do
#             # (repo package version file)
#             local fields=(
#                 ${(0)entry}
#             )
#             if [[ "$pkg" != "${fields[2]}" ]]
#             then
#                 printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
#             fi
#             printf '    /%s\n' "${fields[4]}"
#             pkg="${fields[2]}"
#         done
#     fi
#     return 127
# }

plugin_() {
    # Source Plugin Extension
    # dir-colors
    [[ -f ~/.config/.dir_colors ]] && eval $(dircolors ~/.config/.dir_colors)
    # p10k #! starting zsh config
    [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
    [[ -d $HOME/.config/zsh/ ]] && source "$HOME/.config/zsh/"
    # UFW aktivate
    [[ -f ~/ownCloud/.bin/ufwEnable.sh ]] && source ~/ownCloud/.bin/ufwEnable.sh
    [ -d /etc/profile ] && source /etc/profile
    # Pacman comand not found
    [ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh
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
    # oh-my-zsh
    [[ -d /usr/share/oh-my-zsh ]] && source /usr/share/oh-my-zsh
    ZSH_THEME="random" # theme of oh-my-zsh
    # ZSH_THEME="robbyrussell"
    # export ZSH_THEME="eastwood"
    # export ZSH_THEME="agnoster"
}
plugin_

userGroupdel() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: userGroupdel <username>"
        return 1
    fi

    # Prompt the user for confirmation before deleting the user and group
    read -r "REPLY?Are you sure you want to delete the user '$1' and its group(s)? [y/N] "
    case $REPLY in
    [yY][eE][sS] | [yY]) ;;
    *)
        echo "User and group deletion aborted"
        return 1
        ;;
    esac

    # Use usermod to remove the user from its groups before deleting it
    GROUP=$(id -Gn "$1" | sed 's/ /,/g')
    sudo usermod -G "$GROUP" -a "$1"

    # Use userdel to delete the user and groupdel to delete the group
    if
        sudo userdel "$1"
        sudo groupdel "$1"
    then
        echo "User and group for $1 have been successfully deleted"
    else
        echo "Error: User and group for $1 could not be deleted"
        return 1
    fi

    # userdel / groupdel
    # Enable zsh tab completion for this function
    compdef '_users -S ""' userGroupdel
}

: <<EO


echo 'you can't see me'

EO
