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

active_iface() {
    echo `ip route show | grep default | awk '{print $5}'`
}
IFACE=`active_iface`

myip() {
    local=`ifconfig $IFACE | grep "inet[^6]" | awk '{ print $2 }'`
    external=`curl -s icanhazip.com`
    echo "Local: " $local
    echo "External: " $external
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

preexec () { print -Pn "\e]0;$1\a" }

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

# less colors for man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# source highligh for less
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS=' -R '

# -[ functions ]-
name() {
    name=$1
    vared -c -p 'rename to: ' name
    command mv $1 $name
}

vack() {
    vim $(ack -g $@)
}

# alarm
a() {
    echo "notify-send -i ~/temp/img/img/alarm.png $2" | at $1
}

# example: extract file
extract () {
 if [ -f $1 ] ; then
 case $1 in
 *.tar.bz2)   tar xjf $1        ;;
 *.tar.gz)    tar xzf $1     ;;
 *.bz2)       bunzip2 $1       ;;
 *.rar)       unrar x $1     ;;
 *.gz)        gunzip $1     ;;
 *.tar)       tar xf $1        ;;
 *.tbz2)      tar xjf $1      ;;
 *.tbz)       tar -xjvf $1    ;;
 *.tgz)       tar xzf $1       ;;
 *.zip)       unzip $1     ;;
 *.Z)         uncompress $1  ;;
 *.7z)        7z x $1    ;;
 *)           echo "I don't know how to extract '$1'..." ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi
}

# example: pk tar file
pk () {
 if [ $1 ] ; then
 case $1 in
 tbz)       tar cjvf $2.tar.bz2 $2      ;;
 tgz)       tar czvf $2.tar.gz  $2       ;;
 tar)      tar cpvf $2.tar  $2       ;;
 bz2)    bzip $2 ;;
 gz)        gzip -c -9 -n $2 > $2.gz ;;
 zip)       zip -r $2.zip $2   ;;
 7z)        7z a $2.7z $2    ;;
 *)         echo "'$1' cannot be packed via pk()" ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi
}

WORDCHARS=${WORDCHARS//[&=\/;!#%]}

# -[ alias ]-
alias j=jobs
alias t=htop
alias m=mutt
alias s='sudo systemctl'
alias sr='sudo systemctl start'
alias si='sudo systemctl status'
alias nt='sudo nethogs $IFACE'
alias it='sudo iotop -oa'
alias g=git
alias gc='git commit -a -m'
alias gp='git push'
alias gu='git pull'
alias gd='git diff'
alias gl='git log --oneline --decorate'
alias gll="git log --pretty=format:'%C(yellow)%h %Cblue%an %Cred%ad %Cgreen%d %Creset%s' --date=short"
alias gw='git whatchanged'
alias gst='git status -sb'
alias gcl='git clone'
alias gch='git checkout'
alias h=hg
alias hl='hg lg'
alias hu='hg up'
alias hp='hg push'
alias hs='hg st'
alias hd='hg diff'
alias hc='hg cm'
alias hi='hg sin'
alias grep='egrep --color'
alias gr='grep -rIn $1 **/*'
alias ll='ls -l'
alias la='ls -la'
alias ls='ls --classify --color --human-readable --group-directories-first'
alias sls='sudo ls -l --classify --color --human-readable --group-directories-first'
alias sc='sudo cat'
alias sl='sudo less'
alias lsd='ls -lhd *(-/DN)' # only dirs
alias l='less -N -M'
alias c='cat'
alias ccat='pygmentize -f terminal -g'
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
alias pcpu='ps -eo pid,pcpu,comm --sort pcpu | tail -n 20 | ccze -A'
alias pmem='ps -eo pid,rss,comm --sort rss | tail -n 20 | ccze -A'
alias v='vim'
alias sv='sudo vim'
alias svh='sudo vim /etc/hosts'
alias gv='gvim --remote-tab-silent'
#alias vimup='cd ~/reps/dotfiles;git submodule foreach git pull origin master'
alias p='python'
alias i='ipython'
alias ipl='ipython --pylab'
alias ur='unrar --enable-charset x'
alias pu='pip install $1 -U'
alias piz='pip freeze'
alias spi='sudo pip install $1 -U -i http://d.pypi.python.org/simple/ -M --mirrors=http://d.pypi.python.org/'
alias wheredj='python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"'
alias mcl='mysql --auto-rehash -uroot -pqwerty'
alias cdt='cd ~/temp/'
alias cdr='cd ~/reps/'
alias td='curl -I proft.me; ping -c2 proft.me'
alias phttp='python2 -m SimpleHTTPServer'
alias cal='cal -m'
alias ns='sudo netstat -tulpn'
alias listen="lsof -P -i -n" 
alias va='vagrant'
alias iwl='sudo iw wlan0 scan | egrep "signal|SSID"'

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
    alias la='grc ls --classify --color --human-readable --group-directories-first -la'
    alias du='grc du -h'
}

mcd() { mkdir -p $1; cd $1 }
lcd() { cd "$1" && ll }

alias -s {avi,mpeg,mpg,mov,m2v}=smplayer
alias -s {odt,doc,sxw,rtf}=lowriter
alias -s {ogg,mp3,wav,wma}=deadbeef
autoload -U pick-web-browser
alias -s {html,htm}=chromium

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
alias pm='pacman'
alias pi='sudo pacman -S'
alias pd='sudo pacman -R'
alias pf='pacman -Ss'
alias q='pacman -Q'
alias y='yaourt'
alias yi='yaourt -S --noconfirm'
alias u='yaourt -Syua --noconfirm'
alias yr='yaourt -Rs'
alias rc='sudo vim /etc/rc.conf'
alias pcfg='sudo vim /etc/pacman.conf'
alias n='sudo netctl restart wlan'
alias utime='sudo ntpd -qg; sudo hwclock -w'
alias pclr='sudo pacman -Sc'
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'

# django
alias f=fab
alias rs="sudo djrs"
alias rsp="sudo djrsp"
alias drs="python manage.py runserver"
alias ddb="python manage.py syncdb"
alias dml="python manage.py migrate --list"
alias ds="python manage.py shell"
alias dsp="python manage.py shell_plus"
alias dmn="python manage.py"
alias dt="python manage.py test"
alias dsm="python manage.py schemamigration $1 --auto"
alias dsmi="python manage.py schemamigration $1 --init"
alias dm="python manage.py migrate"
alias dms="python -m smtpd -n -c DebuggingServer localhost:1025"
alias dmm="python manage.py makemessages -a"
alias dcm="python manage.py compilemessages"
alias dcs="python manage.py collectstatic --noinput"
alias gve="echo $VIRTUAL_ENV/lib/python2.7/site-packages/ | xclip -i"

# meteor
alias mr="source env.sh; meteor --settings settings.json"

# tt
alias ta="tt -a"
alias tp="tt -c"
alias tl="tt -t"
alias tw="tt -w"
alias tg="tt -g; chromium /tmp/tt.svg"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

export EDITOR=vim

source ~/.zsh_local
#source /usr/share/zsh/site-contrib/powerline.zsh
#VIRTUAL_ENV_DISABLE_PROMPT=true
