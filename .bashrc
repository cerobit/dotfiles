# /etc/bash.bashrc
#
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ ${EUID} == 0 ]]
    then
        BG_COLOR=41
        ARROW_COLOR=31
        TEXT_COLOR_1=37
        TEXT_COLOR_2=30
        TEXT_GIT=124
    else
        BG_COLOR=47
        ARROW_COLOR=37
        TEXT_COLOR_1=34
        TEXT_COLOR_2=36
        TEXT_GIT=124
fi
TEMP_CPU='$(sensors | grep Package | cut -c16-20)'



#fmtprompt Repace / for > befor apply  PS1   (Note: to remove function in PS1 replace $finalpwd with \w and  and move PS1.., PS2.. out of the function )
fmtprompt() {
    replaceslash=${PWD//\//  }
    if [[ "$PWD" == *"$HOME"* ]]
    then
        replacehome=${replaceslash/home  bitcero/'~'}
        removefirstslash=${replacehome/'  ~'/'~'}
    else
        removefirstslash=${replaceslash/'  '/' '}
    fi

    finalpwd=$removefirstslash

#Git Plugin
source /usr/share/git/completion/git-prompt.sh
git_status='$(__git_ps1 " ( %s) ")'


PS2='> '
PS3='> '
PS4='+ '
}

export PROMPT_COMMAND=(fmtprompt)


[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# modified commands
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'


# new commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias hist='history | grep $1'      # requires an argument
alias openports='netstat --all --numeric --programs --inet'
alias pg='ps -Af | grep $1'         # requires an argument (note: /usr/bin/pg is installed by the util-linux package; maybe a different alias name should be used)

# ls
#alias ls='ls -hF --color=always'
#Ls replace eza
alias l='eza -lF --icons --group-directories-first'
alias ls='eza -F --icons --group-directories-first'
alias tree='eza --tree --level=2 --long --icons --git'
alias ll='ls -l'
alias lr='ls -R'                    # recursive ls
alias la='ll -a'
alias lx='ll -s=Extension'          # sort by extension
alias lz='ll -s=size'               # sort by size
alias lt='ll -snew'                 # sort by date
alias lm='la | more'
alias ld='ll -D'                    # list directories only

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'


#Path Mod
export GOPATH=/beta/devel/gocode
export PATH=$PATH:/beta/devel/gocode/bin


#Fuzzy Finder integration
eval "$(fzf --bash)"


#export LS_COLORS



#Vim Mode
set -o vi

# Auto start plasma on tty1
if [[ "$(tty)" == "/dev/tty1" ]]
 then
  startplasma-wayland
fi
