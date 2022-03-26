#!/bin/zsh
### By the way if it ain't broke, break it then fix it. ###

##################### TODO / Test ######################



#########################TODO###########################
########################################################

# pfetch, neofetch Terminal System info
pfetch

# History - config
HISTFILE=$HOME/.config/.zshistory
HISTSIZE=3333
SAVEHIST=3333
HISTIGNORE=" ls:bg:fg:exit:reset:clear:cd:ll"
HISTCONTROL="ignoreboth:erasedups"

setopt autocd extendedglob nomatch
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
unsetopt beep

# Editor
export EDITOR=vscodium
export VISUAL=EDITOR

# PATH 'short form "-P"'
export PATH=$PATH:~/.local/bin:~/ownCloud/.bin
#! 'test combine with line 40' export PATH=$PATH:~/ownCloud/.bin

export ERL_AFLAGS="-kernel shell_history enabled"
WORDCHARS=${WORDCHARS//\/[&.;]}     # Don't consider certain characters part of the word

# Use powerline
USE_POWERLINE="true"

# powerline-go
function powerline_precmd() {
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs ${${(%):%j}:-0})"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    #set "?"
}

function install_powerline_precmd() {
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

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd
# if only directory path is entered, cd there.

# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.config/.zsh/cache

## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                      # End key
if [[ "${terminfo[kend]}" != "" ]]; then
    bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
#bindkey '^[[5~' history-beginning-search-backward               # Page up key
#bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# Menu select
zmodload -i zsh/complist
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char

# Theming section
autoload -Uz compinit -i colors zcalc
compinit -d
colors

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}?"                              # plus/minus     - clean repo
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"             # A"NUM"         - ahead by "NUM" commits
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"           # B"NUM"         - behind by "NUM" commits
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}??%{$reset_color%}"     # lightning bolt - merge conflict
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}?%{$reset_color%}"       # red circle     - untracked files
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}?%{$reset_color%}"     # yellow circle  - tracked files modified
GIT_PROMPT_STAGED="%{$fg_bold[green]%}?%{$reset_color%}"        # green circle   - staged changes present = ready for "git push"

parse_git_branch() {
    # Show Git branch/tag, or name-rev if on detached head
    ( git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD ) 2> /dev/null
}

parse_git_state() {
    # Show different symbols as appropriate for various Git repository states
    # Compose this value via multiple conditional appends.
    local GIT_STATE=""
    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi
    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi
    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
    fi
    if ! git diff --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
    fi
    if ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
    fi
    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

git_prompt_string() {
    local git_where="$(parse_git_branch)"

    # If inside a Git repository, print its branch and state
    [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"

    # If not inside the Git repo, print exit codes of last command (only if it failed)
    [ ! -n "$git_where" ] && echo "%{$fg[red]%} %(?..[%?])"
}

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

## source ##
## profile
source /etc/profile
## aliasrc
[[ -f $HOME/aliasrc ]] && source "$HOME/aliasrc"
## private-alias
[[ -f $HOME/ownCloud/private-git/p-aliasrc ]] && source $HOME/ownCloud/private-git/p-aliasrc
## oh-my-zsh
[[ -f /usr/share/oh-my-zsh/ ]] ; source /usr/share/oh-my-zsh/
## dir-colors
[[ -f ~/.config/.dir_colors ]] &&  eval `dircolors ~/.config/.dir_colors`
## zsh-autosuggestions
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] ; source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
## Use syntax highlighting
[[  -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] ; source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
## Use history substring search
[[  -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] ; source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

## bind UP and DOWN arrow keys to history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## powerlevel10k
#[[  -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]] || source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
#[[  -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]] ; source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
#[[  -f /usr/share/zsh-theme-powerlevel10k/internal/icons.zsh]] || source /usr/share/zsh-theme-powerlevel10k/internal/icons.zsh
#[[  -f /usr/share/zsh-theme-powerlevel10k/internal/worker.zsh]] || source /usr/share/zsh-theme-powerlevel10k/internal/worker.zsh
## pluggin          #[[ -n $PS1 ]] && source ~/.bash_profile;     ##[[ ! -n $PS1 ]]=deaktivate

#fpath+=(~/.zsh/completion/)

setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a succesive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

# Group matches and describe.
# zstyle ':completion:*:default' menu select=2

# Completing Groping
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''

# Completing misc
zstyle ':completion:*' complete-options true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*' squeeze-slashes true
zstyle -e ':completion:*:approximate:*' \
                   max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:functions' ignored-patterns '_*'

           xdvi() { command xdvi ${*:-*.dvi(om[1])} }
rationalise-dot() {
             if [[ $LBUFFER = *.. ]]; then
               LBUFFER+=/..
             else
               LBUFFER+=.
             fi
           }
           zle -N rationalise-dot
           bindkey . rationalise-dot

# Directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' file-list all
zstyle ':completion:*:*:xdvi:*' menu yes select
           zstyle ':completion:*:*:xdvi:*' file-sort time

#####################  FUNCTIONS  ########################

## Another method for quick change directories. Add this to your ~/.zshrc, then just enter “cd …./dir”
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot


# Easy extract
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       rar x $1       ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Makes directory then moves into it
function mkcdr {
    mkdir -p -v $1
    cd $1
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

#######################################################

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    # Ensure existing Homebrew v1 completions continue to work
    export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
    elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

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
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))

    NEW_PWD=${PWD/#$HOME/\~}

    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))

    # Generate name
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

##
##	GENERATE A FORMAT SEQUENCE
##
format_font()
{
    ## FIRST ARGUMENT TO RETURN FORMAT STRING
    local output=$1

    case $# in
        2)
            eval $output="'\[\033[0;${2}m\]'"
        ;;
        3)
            eval $output="'\[\033[0;${2};${3}m\]'"
        ;;
        4)
            eval $output="'\[\033[0;${2};${3};${4}m\]'"
        ;;
        *)
            eval $output="'\[\033[0m\]'"
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
    local      NONE='0'
    local      BOLD='1'
    local       DIM='2'
    local UNDERLINE='4'
    local     BLINK='5'
    local    INVERT='7'
    local    HIDDEN='8'

    ## COLORS
    local   DEFAULT='9'
    local     BLACK='0'
    local       RED='1'
    local     GREEN='2'
    local    YELLOW='3'
    local      BLUE='4'
    local   MAGENTA='5'
    local      CYAN='6'
    local    L_GRAY='7'
    local    D_GRAY='60'
    local     L_RED='61'
    local   L_GREEN='62'
    local  L_YELLOW='63'
    local    L_BLUE='64'
    local L_MAGENTA='65'
    local    L_CYAN='66'
    local     WHITE='67'

    ## TYPE
    local     RESET='0'
    local    EFFECT='0'
    local     COLOR='30'
    local        BG='40'

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
    if [ "$HOSTNAME" = dell ]; then
        FONT_COLOR_1=$WHITE; BACKGROUND_1=$BLUE; TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE; BACKGROUND_2=$L_BLUE; TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$D_GRAY; BACKGROUND_3=$WHITE; TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$CYAN_BOLD
    fi

    ## CONFIGURATION: BLACK-RED
    if [ "$HOSTNAME" = shaderico ]; then
        FONT_COLOR_1=$WHITE; BACKGROUND_1=$BLACK; TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE; BACKGROUND_2=$D_GRAY; TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$WHITE; BACKGROUND_3=$RED; TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$RED_BOLD
    fi

    ## CONFIGURATION: RED-BLACK
    #FONT_COLOR_1=$WHITE; BACKGROUND_1=$RED; TEXTEFFECT_1=$BOLD
    #FONT_COLOR_2=$WHITE; BACKGROUND_2=$D_GRAY; TEXTEFFECT_2=$BOLD
    #FONT_COLOR_3=$WHITE; BACKGROUND_3=$BLACK; TEXTEFFECT_3=$BOLD
    #PROMT_FORMAT=$RED_BOLD

    ## CONFIGURATION: CYAN-BLUE
    if [ "$HOSTNAME" = sharkoon ]; then
        FONT_COLOR_1=$BLACK; BACKGROUND_1=$L_CYAN; TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE; BACKGROUND_2=$L_BLUE; TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$WHITE; BACKGROUND_3=$BLUE; TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$CYAN_BOLD
    fi

    ## CONFIGURATION: GRAY-SCALE
    if [ "$HOSTNAME" = giraff ]; then
        FONT_COLOR_1=$WHITE; BACKGROUND_1=$BLACK; TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE; BACKGROUND_2=$D_GRAY; TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$WHITE; BACKGROUND_3=$L_GRAY; TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$BLACK_BOLD
    fi

    ## CONFIGURATION: GRAY-CYAN
    if [ "$HOSTNAME" = light ]; then
        FONT_COLOR_1=$WHITE; BACKGROUND_1=$BLACK; TEXTEFFECT_1=$BOLD
        FONT_COLOR_2=$WHITE; BACKGROUND_2=$D_GRAY; TEXTEFFECT_2=$BOLD
        FONT_COLOR_3=$BLACK; BACKGROUND_3=$L_CYAN; TEXTEFFECT_3=$BOLD
        PROMT_FORMAT=$CYAN_BOLD
    fi

    ############################################################################
    ## TEXT FORMATING                                                         ##
    ## Generate the text formating according to configuration                 ##
    ############################################################################

    ## CONVERT CODES: add offset
    FC1=$(($FONT_COLOR_1+$COLOR))
    BG1=$(($BACKGROUND_1+$BG))
    FE1=$(($TEXTEFFECT_1+$EFFECT))

    FC2=$(($FONT_COLOR_2+$COLOR))
    BG2=$(($BACKGROUND_2+$BG))
    FE2=$(($TEXTEFFECT_2+$EFFECT))

    FC3=$(($FONT_COLOR_3+$COLOR))
    BG3=$(($BACKGROUND_3+$BG))
    FE3=$(($TEXTEFFECT_3+$EFFECT))

    FC4=$(($FONT_COLOR_4+$COLOR))
    BG4=$(($BACKGROUND_4+$BG))
    FE4=$(($TEXTEFFECT_4+$EFFECT))

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
    TSFC1=$(($BACKGROUND_1+$COLOR))
    TSBG1=$(($BACKGROUND_2+$BG))

    TSFC2=$(($BACKGROUND_2+$COLOR))
    TSBG2=$(($BACKGROUND_3+$BG))

    TSFC3=$(($BACKGROUND_3+$COLOR))
    TSBG3=$(($DEFAULT+$BG))

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
        xterm*|rxvt*)
            local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
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

##	Bash provides an environment variable called PROMPT_COMMAND.
##	The contents of this variable are executed as a regular Bash command
##	just before Bash displays a prompt.
##	We want it to call our own command to truncate PWD and store it in NEW_PWD
PROMPT_COMMAND=bash_prompt_command

# To customize prompt, run `p10k configure` or edit ~/.config/.p10k.zsh. at the bottom
[[  -f ~/.config/.p10k.zsh ]] ; source ~/.config/.p10k.zsh
