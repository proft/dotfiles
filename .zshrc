# zsh config v0.2 by proft .:: http://proft.me ::.

# -[ prompt for centos ]-
autoload colors; colors
#PROMPT="%B[%{$fg[yellow]%}%n%{$reset_color%}%b@%B%{$fg[blue]%}%m%b%{$reset_color%}%B]%b "
#RPROMPT="%{$fg_bold[grey]%}%~/%{$reset_color%}%"
#export PS1="%B[%{$fg[yellow]%}%n%{$reset_color%}%b@%B%{$fg[blue]%}%m%b%{$reset_color%}:%B]%b "

# -[ prompt for ubuntu ]-

cjobs() {
    if [[ $(jobs | wc -l) -gt 0 ]]; then
        echo " J:%j"
    else
        echo ""
    fi
}

hg_branch() {
    hg branch 2> /dev/null | awk '{ print "[hg:" $1 }'
}

hg_dirty() {
    [ $(hg status 2> /dev/null | wc -l) != 0 ] && echo -e "%F{red}*%F{green}]"
    [ $(hg status 2>&1 | wc -l) = 0 ] && echo -e "]"
}

has_virtualenv() {
    if [ -e .venv ]; then
        workon `\cat .venv`
    fi
}
chpwd() {
    has_virtualenv
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable svn git
zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' unstagedstr "!"
zstyle ':vcs_info:*' formats '[%s:%b%F{red}%c%u%F{green}]'
setopt PROMPT_SUBST
precmd() { 
    vcs_info 
    HG="$(hg_branch)$(hg_dirty)"
}

# PROMPT='%{$fg_bold[yellow]%}%n@%m%{$reset_color%}'
PROMPT='%B%F{yellow}%n%b%F{magenta}@%m%F{green}${HG}${vcs_info_msg_0_}%F{blue}%(!.#.$)%F{magenta}%(?.. E:%?)$(cjobs)%f '
RPROMPT="%{$fg_bold[grey]%}%~/%{$reset_color%}%"

# -[ completion ]-
fpath=(~/.zshfuncs $fpath)
autoload -Uz compinit
compinit

zstyle ':completion:*' menu yes select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# -[ history ]-
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=1000

setopt append_history hist_ignore_all_dups hist_ignore_space autocd correct_all extendedglob
# export LS_COLORS='no=00;37:fi=00;37:di=01;36:ln=04;36:pi=33:so=01;35:do=01;35:bd=33;01:cd=33;01:or=31;01:su=37:sg=30:tw=30:ow=34:st=37:ex=01;31:'
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
export LS_COLORS='*.py=34:*.zip=31:*.rar=31:*.tar.gz=31:*.mp3=33:*.doc=32:*.pdf=32:*.txt=32:*.html=32:*.htm=32:*.jpg=36:*.png=36:*.gif=36'

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# -[ functions ]-
name() {
    name=$1
    vared -c -p 'rename to: ' name
    command mv $1 $name
}

mcd() { mkdir $1; cd $1 }
lcd() { cd "$1" && ls -l }

vack() {
    vim $(ack -g $@)
}

# alarm
a() {
    echo "notify-send -i ~/temp/img/img/alarm.png $2" | at $1
}

WORDCHARS=${WORDCHARS//[&=\/;!#%]}

# -[ alias ]-
alias j=jobs
alias t=htop
alias s='sudo systemctl'
alias nt='sudo nethogs wlan0'
alias it='sudo iotop -oa'
alias g=git
alias gc='git commit -a -m'
alias gp='git push'
alias gu='git pull'
alias gl='git log --oneline --decorate'
alias gw='git whatchanged'
alias gst='git status -sb'
alias pu=pushd
alias po=popd
alias h=history
alias grep='egrep --color'
alias gr='grep -rIn $1 **/*'
alias ll='ls -l'
alias la='ls -a'
alias ls='ls --classify --color --human-readable --group-directories-first'
alias lsd='ls -lhd *(-/DN)' # only dirs
alias l='less -N -M'
alias vl='/usr/share/vim/vim73/macros/less.sh'
alias cp='nocorrect cp --interactive --verbose --recursive --preserve=all'
alias mv='nocorrect mv --verbose --interactive'
alias rm='nocorrect rm -Irv'
alias mkdir='nocorrect mkdir'
alias naut='xdg-open $PWD'
alias pc='rsync -Pr'
alias d='pydf'
alias df='df -h'
alias ff='find . -iname'
alias pg='ps aux | grep -i'
alias v='vim'
alias sv='sudo vim'
alias svh='sudo vim /etc/hosts'
alias gv='gvim --remote-tab-silent'
alias vimup='cd ~/reps/dotfiles;git submodule foreach git pull origin master'
alias i='ipython'
alias ipl='ipython --pylab'
alias ur='unrar --enable-charset x'
alias pi='pip install $1 -U'
alias piz='pip freeze'
alias spi='sudo pip install $1 -U -i http://d.pypi.python.org/simple/ -M --mirrors=http://d.pypi.python.org/'
alias wheredj='python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"'
alias mcl='mysql --auto-rehash -uroot -pqwerty'
alias cdt='cd ~/temp/'
alias td='curl -I proft.me; ping -c2 proft.me'
alias phttp='python -m SimpleHTTPServer'
# alias ack='ack-grep'

alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

alias -g M='| more'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G="| grep"
alias -g A="| ccze -A"
alias -g F="&& notify-send --icon=/home/proft/temp/img/img/icons/checkmark.png Finished!"
[[ -f /usr/bin/xclip ]] && {
    alias -g C="| xclip"
}


[[ -f /usr/bin/grc ]] && {
    alias ping="grc --colour=auto ping"
    alias traceroute="grc --colour=auto traceroute"
    alias make="grc --colour=auto make"
    alias diff="grc --colour=auto diff"
    alias cvs="grc --colour=auto cvs"
    alias netstat="grc --colour=auto netstat"
    alias cat="grc cat"
    alias tail="grc tail"
    alias head="grc head"
    alias ll='grc ls --classify --color --human-readable --group-directories-first -l'
    alias du='grc du -h'
}

# apt
alias ai='sudo apt-get install'
alias ad='sudo apt-get remove'
alias au='sudo apt-get update'
alias aup='sudo apt-get upgrade'
alias upu='sudo apt-get update && sudo apt-get upgrade -u'
alias af='apt-cache search'
alias as='apt-cache show'
alias ap='apt-cache policy'
alias akey='sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys'
alias pfu='dpkg -l | grep'

# pacman && arch
alias p='pacman'
alias pi='sudo pacman -S'
alias pd='sudo pacman -R'
alias pf='pacman -Ss'
alias q='pacman -Q'
alias y='yaourt'
alias u='yaourt -Syua'
alias rc='sudo vim /etc/rc.conf'
alias pcfg='sudo vim /etc/pacman.conf'
alias n='sudo netcfg -r wlan'

# django
alias drs="python manage.py runserver"
alias ddb="python manage.py syncdb"
alias dml="python manage.py migrate --list"
alias ds="python manage.py shell"
alias dmn="python manage.py"
alias dt="python manage.py test"
alias dsm="python manage.py schemamigration $1 --auto"
alias dsmi="python manage.py schemamigration $1 --init"
alias dm="python manage.py migrate"
alias dms="python -m smtpd -n -c DebuggingServer localhost:1025"
alias dmm="python manage.py makemessages -a"
alias dcm="python manage.py compilemessages"

# tt
alias ta="tt -a"
alias tp="tt -c"
alias tl="tt -t"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

export EDITOR=vim

source ~/.zsh_local
