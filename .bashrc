#! /bin/bash
# LANG="UTF-8"
# Workaround #
# zsh(){
#     echo "back to zsh"
# exec /bin/zsh
# } ; zsh

# aliasrc
aliasrc_=~/ownCloud/dotfile/.aliasrc
[[ -f "${aliasrc_}" ]] && . "${aliasrc_}"

##################### TODO / Test ######################

#########################TODO###########################
########################################################

# History - config
export HISTFILE=$HOME/.config/.zshistory
export HISTSIZE=8888
export SAVEHIST=8888
export HISTTIMEFORMAT="[%F %T] "
export HISTORY_IGNORE="ls:bg:fg:exit:reset:clear:cd:ll:yt:sudo:ssh" # zsh #! alias not working
export HISTIGNORE="   :ls:bg:fg:exit:reset:clear:cd:ll:yt:sudo:ssh" # bash
export HISTCONTROL="ignoreboth:erasedups:ignorespace"
shopt -s histappend

# Browser
if [[ -n "$DISPLAY" ]]; then
    export BROWSER=brave-beta
else
    export BROWSER=librewolf
fi

# Editor
export VISUAL=EDITOR
if [[ -n $DISPLAY ]]; then
    export EDITOR='codium'
else
    export EDITOR='neovim'
fi

if [[ -z "$XDG_DATA_DIRS" ]]; then
    export XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi

export setopt histappend # Don't overwrite
export setopt no_nomatch
export setopt BANG_HIST              # Treat the '!' character specially during expansion.
export setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
export setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
export setopt SHARE_HISTORY          # Share history between all sessions.
export setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
export setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
export setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
export setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
export setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
export setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
export setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
export setopt EXTENDED_HISTORY
export setopt checkjobs
export unsetopt beep

export VARIABLE="content"
export GOPATH="$XDG_DATA_HOME"/go
export ZSH_CACHE_DIR="$HOME/.cache/"
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
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

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

export LD_LIBRARY_PATH="/opt/spflashtool"

export ERL_AFLAGS="-kernel shell_history enabled"
WORDCHARS=${WORDCHARS//\/[&.;]/} # Don't consider certain characters part of the word

complete -c man which
complete -cf sudo

shopt -s autocd
set -o noclobber

shopt -s checkwinsize

export IGNOREEOF=100

run-help() { help "$READLINE_LINE" 2>/dev/null || man "$READLINE_LINE"; }

# Powerline
# Use powerline
# USE_POWERLINE="true"

powerline-daemon -q
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
if [[ -f /usr/share/powerline/bash/powerline.sh ]]; then
    . /usr/share/powerline/bash/powerline.sh
fi

install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [[ "$s" = "powerline_precmd" ]]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}

if [[ "$TERM" != "linux" ]] && [[ -f "$GOPATH/bin/powerline-go" ]]; then
    install_powerline_precmd
fi

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

export XDG_CONFIG_HOME="$HOME/.config"

# Keybindings section #    "bindkey -L"  to get all the bindkey info
# Menu select

[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

#! key[Control - Left]="${terminfo[kLFT5]}"
#! key[Control - Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control - Left]}" ]] && bindkey -- "${key[Control - Left]}" backward-word
[[ -n "${key[Control - Right]}" ]] && bindkey -- "${key[Control - Right]}" forward-word

function reset_broken_terminal() {
    printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}"

export DIRSTACKSIZE='20'

# Source Plugin Extension
# dir-colors
[[ -f ~/.config/.dir_colors ]] && eval "$(dircolors ~/.config/.dir_colors)"
# UFW aktivate
UFW=~/ownCloud/.bin/ufwEnable.sh
[[ -f $UFW ]] && source $UFW
[[ -d /etc/profile ]] && source /etc/profile
# powerlevel10k icons
PALIASRC=$HOME/ownCloud/private-git/p-aliasrc
[[ -f "${PALIASRC}" ]] && . "${PALIASRC}"
# bash_completion
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
# Use bash-completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

: <<EO


echo 'you can't see me'

EO

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [[ -r "${file}" ]] && [[ -f "${file}" ]] && source "${file}"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2>/dev/null
done

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &>/dev/null; then
    complete -o default -o nospace -F _git g
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

################################################################################
##  FUNCTIONS                                                                 ##
################################################################################

##
##	ARRANGE $PWD AND STORE IT IN $NEW_PWD
##	* The home directory (HOME) is replaced with a ~
##	* The last pwdmaxlen characters of the PWD are displayed
##	* Leading partial directory names are striped off
##		/home/me/stuff -> ~/stuff (if USER=me)
##		/usr/share/big_dir_name -> ../share/big_dir_name (if pwdmaxlen=20)
##
##	Original source: WOLFMAN'S color bash promt
##	https://wiki.chakralinux.org/index.php?title=Color_Bash_Prompt#Wolfman.27s
##
bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25

    # Indicate that there has been dir truncation
    local trunc_symbol=".."

    # Store local dir
    local dir=${PWD##*/}

    # Which length to use
    pwdmaxlen=$(((pwdmaxlen < ${#dir}) ? ${#dir} : pwdmaxlen))

    NEW_PWD=${PWD/#$HOME/\~}

    local pwdoffset=$((${#NEW_PWD} - pwdmaxlen))

    # Generate name
    if [[ ${pwdoffset} -gt "0" ]]; then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

##
##	GENERATE A FORMAT SEQUENCE
##
format_font() {
    ## FIRST ARGUMENT TO RETURN FORMAT STRING
    local output=$1

    case $# in
    2)
        eval "$output"="'\[\033[0;${2}m\]'"
        ;;
    3)
        eval "$output"="'\[\033[0;${2};${3}m\]'"
        ;;
    4)
        eval "$output"="'\[\033[0;${2};${3};${4}m\]'"
        ;;
    *)
        eval "$output"="'\[\033[0m\]'"
        ;;
    esac
}

##
## COLORIZE BASH PROMT
##
bash_prompt() {

    ############################################################################
    ## COLOR CODES                                                            ##
    ## These can be used in the configuration below                           ##
    ############################################################################

    ## FONT EFFECT
    local NONE='0'
    local BOLD='1'
    local DIM='2'
    local UNDERLINE='4'
    local BLINK='5'
    local INVERT='7'
    local HIDDEN='8'

    ## COLORS
    local DEFAULT='9'
    local BLACK='0'
    local RED='1'
    local GREEN='2'
    local YELLOW='3'
    local BLUE='4'
    local MAGENTA='5'
    local CYAN='6'
    local L_GRAY='7'
    local D_GRAY='60'
    local L_RED='61'
    local L_GREEN='62'
    local L_YELLOW='63'
    local L_BLUE='64'
    local L_MAGENTA='65'
    local L_CYAN='66'
    local WHITE='67'

    ## TYPE
    local RESET='0'
    local EFFECT='0'
    local COLOR='30'
    local BG='40'

    ## 256 COLOR CODES
    local NO_FORMAT="\[\033[0m\]"
    local ORANGE_BOLD="\[\033[1;38;5;208m\]"
    local TOXIC_GREEN_BOLD="\[\033[1;38;5;118m\]"
    local RED_BOLD="\[\033[1;38;5;1m\]"
    local CYAN_BOLD="\[\033[1;38;5;87m\]"
    local BLACK_BOLD="\[\033[1;38;5;0m\]"
    local WHITE_BOLD="\[\033[1;38;5;15m\]"
    local GRAY_BOLD="\[\033[1;90m\]"
    local BLUE_BOLD="\[\033[1;38;5;74m\]"

    ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##
    ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##
    ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##

    ##                          CONFIGURE HERE                                ##

    ############################################################################
    ## CONFIGURATION                                                          ##
    ## Choose your color combination here                                     ##
    ############################################################################
    local FONT_COLOR_1=$WHITE
    local BACKGROUND_1=$BLUE
    local TEXTEFFECT_1=$BOLD

    local FONT_COLOR_2=$WHITE
    local BACKGROUND_2=$L_BLUE
    local TEXTEFFECT_2=$BOLD

    local FONT_COLOR_3=$D_GRAY
    local BACKGROUND_3=$WHITE
    local TEXTEFFECT_3=$BOLD

    local PROMT_FORMAT=$BLUE_BOLD

    ############################################################################
    ## EXAMPLE CONFIGURATIONS                                                 ##
    ## I use them for different hosts. Test them out ;)                       ##
    ############################################################################

    ## CONFIGURATION: BLUE-WHITE
    if [[ "$HOSTNAME" = dell ]]; then
        FONT_COLOR_1=$WHITE
        BACKGROUND_1=$BLUE
        TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE
        BACKGROUND_2=$L_BLUE
        TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$D_GRAY
        BACKGROUND_3=$WHITE
        TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$CYAN_BOLD
    fi

    ## CONFIGURATION: BLACK-RED
    if [[ "$HOSTNAME" = giraff6 ]]; then
        FONT_COLOR_1=$WHITE
        BACKGROUND_1=$BLACK
        TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE
        BACKGROUND_2=$D_GRAY
        TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$WHITE
        BACKGROUND_3=$RED
        TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$RED_BOLD
    fi

    ## CONFIGURATION: RED-BLACK
    #FONT_COLOR_1=$WHITE; BACKGROUND_1=$RED; TEXTEFFECT_1=$BOLD
    #FONT_COLOR_2=$WHITE; BACKGROUND_2=$D_GRAY; TEXTEFFECT_2=$BOLD
    #FONT_COLOR_3=$WHITE; BACKGROUND_3=$BLACK; TEXTEFFECT_3=$BOLD
    #PROMT_FORMAT=$RED_BOLD

    ## CONFIGURATION: CYAN-BLUE
    if [[ "$HOSTNAME" = sharkoon ]]; then
        FONT_COLOR_1=$BLACK
        BACKGROUND_1=$L_CYAN
        TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE
        BACKGROUND_2=$L_BLUE
        TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$WHITE
        BACKGROUND_3=$BLUE
        TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$CYAN_BOLD
    fi

    ## CONFIGURATION: GRAY-SCALE
    if [[ "$HOSTNAME" = giraff ]]; then
        FONT_COLOR_1=$WHITE
        BACKGROUND_1=$BLACK
        TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE
        BACKGROUND_2=$D_GRAY
        TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$WHITE
        BACKGROUND_3=$L_GRAY
        TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$BLACK_BOLD
    fi

    ## CONFIGURATION: GRAY-CYAN
    if [[ "$HOSTNAME" = light ]]; then
        FONT_COLOR_1=$WHITE
        BACKGROUND_1=$BLACK
        TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE
        BACKGROUND_2=$D_GRAY
        TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$BLACK
        BACKGROUND_3=$L_CYAN
        TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$CYAN_BOLD
    fi

    ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##
    ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##
    ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##

    ############################################################################
    ## TEXT FORMATING                                                         ##
    ## Generate the text formating according to configuration                 ##
    ############################################################################

    ## CONVERT CODES: add offset
    FC1=$(($FONT_COLOR_1 + $COLOR))
    BG1=$(($BACKGROUND_1 + $BG))
    FE1=$(($TEXTEFFECT_1 + $EFFECT))

    FC2=$(($FONT_COLOR_2 + $COLOR))
    BG2=$(($BACKGROUND_2 + $BG))
    FE2=$(($TEXTEFFECT_2 + $EFFECT))

    FC3=$(($FONT_COLOR_3 + $COLOR))
    BG3=$(($BACKGROUND_3 + $BG))
    FE3=$(($TEXTEFFECT_3 + $EFFECT))

    FC4=$(($FONT_COLOR_4 + $COLOR))
    BG4=$(($BACKGROUND_4 + $BG))
    FE4=$(($TEXTEFFECT_4 + $EFFECT))

    ## CALL FORMATING HELPER FUNCTION: effect + font color + BG color
    local TEXT_FORMAT_1
    local TEXT_FORMAT_2
    local TEXT_FORMAT_3
    local TEXT_FORMAT_4
    format_font TEXT_FORMAT_1 $FE1 $FC1 $BG1
    format_font TEXT_FORMAT_2 $FE2 $FC2 $BG2
    format_font TEXT_FORMAT_3 $FC3 $FE3 $BG3
    format_font TEXT_FORMAT_4 $FC4 $FE4 $BG4

    # GENERATE PROMT SECTIONS
    local PROMT_USER=$"$TEXT_FORMAT_1 \u "
    local PROMT_HOST=$"$TEXT_FORMAT_2 \h "
    local PROMT_PWD=$"$TEXT_FORMAT_3 \${NEW_PWD} "
    local PROMT_INPUT=$"$PROMT_FORMAT "

    ############################################################################
    ## SEPARATOR FORMATING                                                    ##
    ## Generate the separators between sections                               ##
    ## Uses background colors of the sections                                 ##
    ############################################################################

    ## CONVERT CODES
    TSFC1=$(($BACKGROUND_1 + $COLOR))
    TSBG1=$(($BACKGROUND_2 + $BG))

    TSFC2=$(($BACKGROUND_2 + $COLOR))
    TSBG2=$(($BACKGROUND_3 + $BG))

    TSFC3=$(($BACKGROUND_3 + $COLOR))
    TSBG3=$(($DEFAULT + $BG))

    ## CALL FORMATING HELPER FUNCTION: effect + font color + BG color
    local SEPARATOR_FORMAT_1
    local SEPARATOR_FORMAT_2
    local SEPARATOR_FORMAT_3
    format_font SEPARATOR_FORMAT_1 $TSFC1 $TSBG1
    format_font SEPARATOR_FORMAT_2 $TSFC2 $TSBG2
    format_font SEPARATOR_FORMAT_3 $TSFC3 $TSBG3

    # GENERATE SEPARATORS WITH FANCY TRIANGLE
    local TRIANGLE=$'\uE0B0'
    local SEPARATOR_1=$SEPARATOR_FORMAT_1$TRIANGLE
    local SEPARATOR_2=$SEPARATOR_FORMAT_2$TRIANGLE
    local SEPARATOR_3=$SEPARATOR_FORMAT_3$TRIANGLE

    ############################################################################
    ## WINDOW TITLE                                                           ##
    ## Prevent messed up terminal-window titles                               ##
    ############################################################################
    case $TERM in
    xterm* | rxvt*)
        local TITLEBAR="\[\033]0;\u:${NEW_PWD}\007\]"
        ;;
    *)
        local TITLEBAR=""
        ;;
    esac

    ############################################################################
    ## BASH PROMT                                                             ##
    ## Generate promt and remove format from the rest                         ##
    ############################################################################
    PS1="$TITLEBAR\n${PROMT_USER}${SEPARATOR_1}${PROMT_HOST}${SEPARATOR_2}${PROMT_PWD}${SEPARATOR_3}${PROMT_INPUT}"

    ## For terminal line coloring, leaving the rest standard
    none="$(tput sgr0)"
    trap 'echo -ne "${none}"' DEBUG
}

################################################################################
##  MAIN                                                                      ##
################################################################################

##	Bash provides an environment variable called PROMPT_COMMAND.
##	The contents of this variable are executed as a regular Bash command
##	just before Bash displays a prompt.
##	We want it to call our own command to truncate PWD and store it in NEW_PWD
PROMPT_COMMAND=bash_prompt_command

##	Call bash_promnt only once, then unset it (not needed any more)
##	It will set $PS1 with colors and relative to $NEW_PWD,
##	which gets updated by $PROMT_COMMAND on behalf of the terminal
bash_prompt
unset bash_prompt
