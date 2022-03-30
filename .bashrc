#!/bin/bash
encoding="UTF-8"
### By the way if it ain't broke, break it then fix it. ###
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/ownCloud/.bin

# Pfetch, Neofetch Terminal CPU info
pfetch

echo '                     bash on Richard'

############### Todo / TEST ###############



#if pfetch ; then pfetch ; else neofetch
#fi
#Exec=prime-run cmatrix

################ Todo ######################
############################################

# History - config
HISTFILE=$HOME/.config/.zshistory
HISTSIZE=3333
SAVEHIST=3333

export ERL_AFLAGS="-kernel shell_history enabled"

WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

#Editor
export EDITOR=vscodium
export VISUAL=EDITOR

# Use powerline
USE_POWERLINE="true"

#powerlevel10k prompt
ZSH_THEME="powerlevel10k/powerlevel10k"

#powerline-go
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

#Modify the colors and symbols in these variables as desired.
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

## pluggin          #[[ -n $PS1 ]] && source ~/.bash_profile;     ##[[ ! -n $PS1 ]]=deaktivate

## aliasrc
#source ~/aliasrc #TODO not working for Suffix alias

## private-alias
[[ -f $HOME/ownCloud/private-git/p-aliasrc ]] && source $HOME/ownCloud/private-git/p-aliasrc

## dir-colors
[[ -f ~/.config/.dir_colors ]] &&  eval `dircolors ~/.config/.dir_colors`



##TEST powerlevel10k
# [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]] || source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/.p10k.zsh. at the bottom
[[ -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh


#####################  FUNCTIONS  ########################

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

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

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

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;



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
	if [ "$HOSTNAME" = dell ]; then
		FONT_COLOR_1=$WHITE; BACKGROUND_1=$BLUE; TEXTEFFECT_1=$BOLD
		FONT_COLOR_2=$WHITE; BACKGROUND_2=$L_BLUE; TEXTEFFECT_2=$BOLD
		FONT_COLOR_3=$D_GRAY; BACKGROUND_3=$WHITE; TEXTEFFECT_3=$BOLD
		PROMT_FORMAT=$CYAN_BOLD
	fi

	## CONFIGURATION: BLACK-RED
	if [ "$HOSTNAME" = giraff6 ]; then
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


	##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##
	  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##
	##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##




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
unset bash_prompt

# Use powerline
USE_POWERLINE="true"


















#################  alias  ###################


#alias netstat='sudo netstat -tapn |  sed '1 d' | sort -r +6 | grep -v 'TIME_WAIT' | grep -v 'FIN_WAIT' | grep -v 'LISTEN' | grep -v 'CLOSING' | grep -v 'LAST_ACK''
#alias please='sudo !!'
################ Todo ######################
############################################

## shortcut=

## Ln Links herstellen
alias backup='ln -fv .zshrc                                $HOME/ownCloud/dotfile/.zshrc
sudo          ln -fv /etc/lightdm/lightdm.conf             $HOME/ownCloud/dotfile/lightdm.conf
sudo          ln -fv /etc/vconsole.conf                    $HOME/ownCloud/dotfile/vconsole.conf
sudo          ln -fv /etc/systemd/journald.conf            $HOME/ownCloud/dotfile/journald.conf
              ln -fv $HOME/.stignore                       $HOME/ownCloud/dotfile/.stignore
              ln -fv $HOME/.config/.dir_colors             $HOME/ownCloud/dotfile/.dir_colors
              ln -fv $HOME/aliasrc                         $HOME/ownCloud/dotfile/aliasrc
              ln -fv $HOME/.bashrc                         $HOME/ownCloud/dotfile/.bashrc
              sudo pacman -Qqe > $HOME/ownCloud/dotfile/pkglist.txt
              ;echo                  here we go Richard'

alias backup-restore='ln -fv $HOME/ownCloud/dotfile/.zshrc $HOME/.zshrc
sudo ln -fv $HOME/ownCloud/dotfile/lightdm.conf             /etc/lightdm/lightdm.conf
     ln -fv $HOME/ownCloud/dotfile/.stignore                $HOME/.stignore
     ln -fv $HOME/ownCloud/dotfile/.dir_colors              $HOME/.config/.dir_colors
     ln -fv $HOME/ownCloud/dotfile/aliasrc                  $HOME/aliasrc
     ln -fv $HOME/ownCloud/dotfile/.bashrc                  $HOME/.bashrc
     sudo ln -fv  $HOME/ownCloud/dotfile/vconsole.conf /etc/vconsole.conf
     sudo ln -fv  $HOME/ownCloud/dotfile/journald.conf /etc/journald.conf
sudo timedatectl set-ntp true
sudo systemctl enable --now auto-cpufreq.service
sudo systemctl enable --now NetworkManager
sudo systemctl enable lightdm
sudo mkinitcpio -P && sudo update-grub
sudo journalctl --vacuum-size=33M
sudo systemctl enable --now systemd-timesyncd
sudo fc-cache -vf
;echo                   here we go Richard'

## xfce4-backup
alias xfce4-backup='
ln -fv $HOME/.config/mimeapps.list $HOME/ownCloud/dotfile/xfce4/mimeapps.list;
ln -fv $HOME/.config/xfce4/xfconf/xfce-perchannel-xml $HOME/ownCloud/dotfile/xfce4/xfce-perchannel-xml;
xfce4-panel-profiles save $HOME/ownCloud/dotfile/xfce4/xfce4-panel-profiles
;echo                  here we go Richard'

alias xfce4-restore='
ln -fv $HOME/ownCloud/dotfile/xfce4/mimeapps.list $HOME/.config/mimeapps.list;
ln -fv $HOME/ownCloud/dotfile/xfce-perchannel-xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml;
xfce4-panel-profiles load $HOME/ownCloud/dotfile/xfce4/xfce4-panel-profiles
;echo                   here we go Richard'

# sudo pacman -Qqe > pkglist.txt
alias pkglist-backup='pacman -Qqe > $HOME/ownCloud/dotfile/pkglist.txt'
alias pkglist-restore='sudo pacman --needed --noconfirm -Syu && yay --needed --noanswerclean --nocleanmenu --cleanafter --norebuild --batchinstall --combinedupgrade --useask --noredownload --topdown --sudoloop -Syv < $HOME/ownCloud/dotfile/pkglist.txt
;echo                   here we go Richard'

## Systemclean
alias cclean='sudo pacman  -Sc; /usr/bin/sudo journalctl --vacuum-time=14d; sudo find /tmp -type f -atime +10 -delete; sudo find ~/.cache/ -type f -atime +88 -delete; rm -fr ~/.local/share/Trash/*; ccache -C; echo                   here we go Richard'

# yay -Rc -noconfirm --needed pidgin hexchat mousepad xfce4-screensaver samba

## Block any Website
# zb. cat '0.0.0.0 www.pornhub.com' >> /etc/hosts

#TODO Suffix alias
#alias -s pdf='xreader'
#alias -s {jpg,jpeg,png,gif}='ristretto'

alias cp='cp -vi'                                               # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes check
alias free='free -h'                                            # Show sizes in MB
alias np='nano -w PKGBUILD'
alias whereami='echo $PWD'
alias more='less'
alias pacman-update='sudo pacman-mirrors --fasttrack ; sudo pacman -Syu;echo                   here we go Richard'
alias update-pacman='sudo pacman-mirrors --fasttrack ; sudo pacman -Syu;echo                   here we go Richard'
alias errors='sudo systemctl --failed'
alias failed='sudo systemctl --failed'
alias grub-update='sudo mkinitcpio -P && sudo update-grub'
alias ping='ping -c 4'
alias mv='mv -iv'
alias rm='sudo rm -rfv'
alias rechner-bc='bc -ql'  								     		#Calculator
alias calculator-bc='bc -ql'  										#Calculator
alias mkdir='mkdir -pv'
alias yt='youtube-dl --add-metadata -i'
alias yta='yt -x -f bestaudio/best'
alias arch-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias ffmpeg='ffmpeg -hide_banner'										 #'ffmpeg -i input.mp4 output.avi'  https:/ffmpeg.org/ffmpeg.html
alias inxi-Fanzy='inxi -Fanzy'                                                   #Info System
alias ip-c='ip -c a'                                                       #ip-coler
alias ssh-copypub='ssh-copy-id -fi $HOME/.ssh/id_rsa.pub' #-p #IP...                 #man ssh-keygen      #ssh-keygen -t rsa -b 4096
alias defenderscan-libredefender='libredefender scan'                             #Linux Antivierus/Defender programm
alias antivirusscan-libredefender='libredefender scan'                           #Linux Antivierus/Defender programm

# Pretty print the path
#alias  path='echo $PATH | tr -s ':' '\n''
alias path='echo -e ${PATH//:/\\n}'

# Network
alias myip='curl http:/ipecho.net/plain; echo'
alias traffic-jnettop='sudo jnettop'
alias nmap='sudo nmap -sS -v'                            #nmap -v google.ch  Network Ip scan programm like
alias traffic-nmap='sudo nmap -sS -v'                    #nmap -v google.ch  Network Ip scan programm like
alias networkmanagerlog='journalctl --boot 0 --unit NetworkManager.service --follow'   #NetworkManager info scan

## open port check
alias port-open='sudo lsof -i -P -n | grep LISTEN'          #port open-list

alias wget='wget -c'              			  #web get #Commandline Homepage URL Download > index.html
alias nvim='nvim'
alias  vim='nvim'
alias    n='nvim'
alias  env='env'                               #Startup memorie speicher Information
alias htop='sudo htop'
alias    f='nemo'
alias   rr='ranger'


# Colorize commands when possible.
alias ls='ls -thaNr  --color=auto --group-directories-first'
alias ll='ls -thaNrl --color=auto --group-directories-first'
alias ln='ln -v'
alias grep='grep --color=auto'
alias    g='grep --color=auto'
alias diff='diff --color=auto'

# These common commands are just too long! Abbreviate them.
alias ka='killall'
alias  e='vscodium '
alias  v='$EDITOR'
alias  p='sudo pacman '

# Git
alias gu='git update'
alias gitu='git add . && git commit && git push'
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gcm='git commit -m'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpl='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'
alias gdiscard='git checkout -- .'

# Quick/fast access
#alias i='.stignore && $HOME/aliasrc && $HOME/.zshrc'
alias ee='$EDITOR $HOME/.stignore;$EDITOR $HOME/aliasrc;$EDITOR $HOME/.zshrc; exit'
alias stignore='$EDITOR $HOME/.stignore; exit'
alias zshrc='$EDITOR $HOME/.zshrc; exit'
alias aliasrc='$EDITOR $HOME/aliasrc; exit'
alias t='mkdir -p ~/Downloads/test && cd ~/Downloads/test && ls'
alias dl='~/Downloads/ && cd ~/Downloads/ && ls'
alias cd..='cd .. && ls'
alias ownCloud='$HOME/ownCloud ; ls'
alias D-link='$HOME/ownCloud/D-link ; ls'
alias S-link='$HOME/ownCloud/S-link ; ls'
alias M-link='$HOME/ownCloud/M-link ; ls'
alias W-link='$HOME/ownCloud/W-link ; ls'
alias P-link='$HOME/ownCloud/P-link ; ls'
alias D-link='$HOME/ownCloud/D-link ; ls'

## mount
alias mount='mount |column -t'

## Get server cpu info ##
alias cpuinfo='lscpu'
alias cpuwatch='watch -n 0.5 grep \"cpu MHz\" /proc/cpuinfo'

## get GPU ram on desktop / laptop##
alias meminfo='grep -i --color memory /var/log/Xorg.0.log'
alias mem-psmc='ps -Ao "comm %cpu %mem"'

#turn screen off
alias screenoff="xset dpms force off"
alias qq='xfce4-terminal --drop-down cmatric'
# sort files in current directory by the number of words they contain
alias wordy='wc -w * | sort | tail -n10'
alias filecount='sudo ls -aRF | wc -l'

#Gets the total disk usage on your machine
alias diskinfo='df -hl --total | grep total'
#alias disk='    df -hTl'

#Gives you what is using the most space. Both directories and files. Varies on current directory
alias most='du -hsx * | sort -rh | head -15'                     # Bigest files in folder
alias bigest-file='du -hsx * | sort -rh | head -15'                     # Bigest files in folder

#shutdown
alias poweroff='xfce4-terminal --geometry=66x14 --hide-scrollbar -H -x zsh -c "termdown 88; sleep 1 ; poweroff"'
alias shutdown='xfce4-terminal --geometry=66x14 --hide-scrollbar -H -x zsh -c "termdown 88; sleep 1 ; poweroff"'
alias pwf='xfce4-terminal --geometry=66x14 --hide-scrollbar -H -x zsh -c "termdown 88; sleep 1 ; poweroff"'
alias gg=' xfce4-terminal --geometry=66x14 --hide-scrollbar -H -x zsh -c "termdown 88; sleep 1 ; poweroff"'


#########  opensource ##########

# alias phone-scrcpy='scrcpy -s 'your-adb-devices-id' -m 2110 -b 20m'                    #android-screen
# alias tablets-scrcpy='scrcpy -s 'your-adb-devices-id' -m 2110 -b 20m'                    # android-screen
# alias scp-up='  scp -rv'     #-P22                                             #scp -P 1234 file user@remote.host:/remote/location/
# alias scp-down='scp -rv'     #-P22                                             #scp -P 1234 user@remote.host:/remote/location/file ./
## manuel alias  rsync-up='rsync -e'ssh   -p22' --force -Rravuz --delete-before' #pkglist user@remotesystem:/path/           --exclude
## manuel alias  rsync-down='rsync -e'ssh -p22' --force -Rravuz --delete-before' #pkglist user@remotesystem:/path/
## manuel alias  rsyncvm='rsync -e 'ssh -p22'  $HOME/VirtualBox\ VMs/ 172.20.10.6:$HOME/VirtualBox\ VMs/ -r --force -avz'

## alias .config-update='rsync -e'ssh -p 22' --force -Rravuz --delete-before --exclude gnupg --exclude VirtualBox --exclude Barrier --exclude syncthing --exclude BraveSoftware --exclude .ssh --exclude ownCloud --exclude .stversions --exclude .xsession-errors .config/'   ## 172.0.0.1:

# rclone
#alias owncloud-encrypt='rclone --attr-timeout 3s --vfs-cache-mode full --vfs-read-chunk-size 100M       mount owncloud-encrypt crypt: $HOME/owncloud crypt   --allow-non-empty'


## open port check
alias port-open='sudo lsof -i -P -n | grep LISTEN'          #port open-list

alias wget='wget -c'     #web get #Commandline Homepage URL Download > index.html
alias nvim='nvim '
alias  vim='nvim '
alias    n='nvim '
alias  env='env'                               #Startup memorie speicher Information
alias htop='sudo htop'
alias    f='exec nemo'
alias   rr='ranger'

#nvidia Proprietary
alias nvidia0300='sudo mhwd -a pci nonfree 0300'

# Colorize commands when possible.
alias   ls='ls -thaNr  --color=auto --group-directories-first'
alias   ll='ls -thaNrl --color=auto --group-directories-first'
alias   ln='ln -v'
alias grep='grep --color=auto'
alias    g='grep --color=auto'
alias diff='diff --color=auto'
alias pacman-grep='pacman -Qe | grep '
# These common commands are just too long! Abbreviate them.
alias ka='killall'
alias  e='$EDITOR '
alias  v='$EDITOR '
alias  p='sudo pacman '

# Git
alias gitup='git add . && git commit && git push'
alias gitadd='git add '
alias gitpush='git push'
alias gitlog='git log'
alias gitstatus='git status'
alias gitdiff='git diff'
alias gitcommitm='git commit -m'
alias gitbranch='git branch'
alias gitcheckout='git checkout'
alias gitremoteadd='git remote add'
alias gitremoterm='git remote rm'
alias gitpull='git pull'
alias gitclone='git clone'
alias gittag='git tag -a -m'
alias gitreflog='git reflog'
alias gitl='git log --graph --oneline --decorate'
alias giti='echo; git log -n 12 --graph --oneline --decorate; echo; git status; echo'

## Arch
alias arch-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias reflector='sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist '

# Quick/fast access
alias np='$EDITOR -w PKGBUILD'
alias makepkg-si='makepkg -si'                          #git clone - PKGBUILD
alias ee='$EDITOR $HOME/.stignore ; $EDITOR $HOME/aliasrc ; $EDITOR $HOME/.zshrc; exit'
alias stignore='$EDITOR $HOME/.stignore; exit'
alias zshrc='$EDITOR $HOME/.zshrc; exit'
# alias aliasrc='$EDITOR $HOME/aliasrc; exit'
alias t='mkdir -p $HOME/Downloads/test ; cd $HOME/Downloads/test ; ls'
alias dl='$HOME/Downloads/ ; cd $HOME/Downloads/ ; ls'
alias cd..='cd .. ; ls'
alias ownCloud='$HOME/ownCloud ; ls'
alias D-link='$HOME/ownCloud/D-link ; ls'
alias S-link='$HOME/ownCloud/S-link ; ls'
alias M-link='$HOME/ownCloud/M-link ; ls'
alias W-link='$HOME/ownCloud/W-link ; ls'
alias P-link='$HOME/ownCloud/P-link ; ls'
alias D-link='$HOME/ownCloud/D-link ; ls'

## mount
alias mount='mount |column -t'

## systemctl
alias   enable='sudo systemctl enable  --now '
alias  disable='sudo systemctl disable --now '
alias   status='sudo systemctl status  --now '
alias  restart='sudo systemctl restart --now '
#'systemctl'    list all running units

# Suffix alias
alias pdf='qpdfview '
alias {jpg,jpeg,png,gif}='ristretto '
#todo alias imagemagick=                #image convert in to pdf   #man gmic #man convert #man
alias cp='cp -vi '                                               # Confirm before overwriting something
alias df='df -h '                                                # Human-readable sizes check
alias free='free -h '                                            # Show sizes in MB
alias whereami='echo $PWD'
alias more='less'
alias update-pacman='sudo pacman-mirrors -a -P https --fasttrack  ; sudo pacman -Syu;echo        here we go Richard'
alias pacman-update='sudo pacman-mirrors -a -P https --fasttrack  ; sudo pacman -Syu;echo        here we go Richard'
alias errors='sudo systemctl --failed'
alias failed='sudo systemctl --failed'
alias grub-update='sudo mkinitcpio -P && sudo update-grub'
alias ping='ping -c 4  google.ch '
alias mv='mv -iv '
alias yy='paru '
alias zz='paru '
alias pp='pycharm '
