#------------------------------------------------------------------#
# File: .zshrc ZSH resource file #
# Version: 0.1.16 #
# Author: ?yvind "Mr.Elendig" Heggstad <mrelendig@har-ikkje.net> #
#------------------------------------------------------------------#

#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#------------------------------
# Variables
#------------------------------
export BROWSER="google-chrome"
export EDITOR="vim"
#export PAGER="vimpager"
export PATH="${PATH}:${HOME}/bin:${HOME}/.cabal/bin"

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Keybindings
#------------------------------
bindkey -v
typeset -g -A key
#bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
#bindkey '\e[2~' overwrite-mode
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-word
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[1;5C' emacs-forward-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for gnome-terminal
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "^R" history-incremental-search-backward
#------------------------------
# Alias stuff
#------------------------------
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias spm="sudo pacman"
alias spmc="sudo pacman-color"
alias gr="gvim --remote-silent"
alias vr="vim --remote-silent"
alias sublime="subl"
alias apktool="java -jar /opt/apktool/apktool.jar"
alias jad="/opt/jad"
alias procyon="java -jar /opt/procyon.jar"
alias understand="/opt/understand/scitools/bin/linux64/./understand"
alias metagoofil="python /opt/metagoofil/metagoofil.py"
alias dirbuster="java -jar /opt/DirBuster/DirBuster-0.0.12.jar"
alias hma-vpn="/opt/hma-vpn.sh"
alias sign="/opt/sign"
alias smali="java -jar /opt/smali.jar"
alias baksmali="java -jar /opt/baksmali.jar"
alias htmltolatex="java -jar /opt/html-to-latex/htmltolatex.jar"
alias zipalign="/opt/adt/sdk/build-tools/android-4.4W/zipalign"
alias battery_status="/home/ramses/battery_status.sh"
alias msfconsole="sudo msfconsole"
alias golismero="python /opt/golismero/golismero.py"
alias apktool="java -jar /opt/apktool/apktool_2.1.1.jar"
#Alias trolling, courtesy of miself!

#alias ls=sl

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

#------------------------------
# Comp stuff
#------------------------------
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

#- complete pacman-color the same as pacman
compdef _pacman pacman-color=pacman

#------------------------------
# Window title
#------------------------------
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      vcs_info
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    }
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () {
      vcs_info
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
    }
    preexec () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
    }
    ;;
esac

#------------------------------
# Prompt
#------------------------------
autoload -U colors zsh/terminfo
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

setprompt() {
  # load some modules
  setopt prompt_subst

  # make some aliases for the colours: (coud use normal escap.seq's too)
  for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval PR_$color='%{$fg[${(L)color}]%}'
  done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

  # Check the UID
  if [[ $UID -ge 1000 ]]; then # normal user
    eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_GREEN}-\>${PR_NO_COLOR}'
  elif [[ $UID -eq 0 ]]; then # root
    eval PR_USER='${PR_BLUE}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_BLUE}%#${PR_NO_COLOR}'
  fi

  # Check if we are on SSH or not
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
eval PR_HOST='' #${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
  else
eval PR_HOST='' #${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
  fi
  # set the prompt
  PS1=$'${PR_CYAN}${PR_USER}${PR_CYAN}${PR_HOST}${PR_BLUE}[${PR_NO_COLOR}%24<...<%~${PR_BLUE}]${PR_USER_OP} '
  PS2=$'%_>'
  RPROMPT=$'${vcs_info_msg_0_}'
}
setprompt

# vim: set ts=2 sw=2 et:

export JAVA_HOME=/user/lib/jvm/java-7-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
