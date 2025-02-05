export TMPDIR=$HOME/tmp

PATHxPRE="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/go/bin"

if [ -x "$HOME/bin/addpath" ]; then
    PATH="$($HOME/bin/addpath --prefix PATH $PATHxPRE)"
else
    PATH="$PATHxPRE:$PATH"
fi


if [ ${+prompt} = 1 ] ; then

function powerline_precmd() {
   PL="powerline-go"
   PROMPT="%m-%B%T%b-%?-$($PL -shell zsh -mode compatible -modules=ssh,perms,root)%E"
   RPROMPT="$($PL -shell zsh -mode flat -modules=cwd,git --priority root,user,host,ssh,perms,git-branch,git-status,hg,cwd,jobs,exit --cwd-max-depth 8 -right-prompt -max-width 85)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}
install_powerline_precmd

 if [ ! -d $TMPDIR ]; then
  mkdir -p $TMPDIR
 fi

 export LESSOPEN="|$HOME/bin/lesspipe.sh %s"

 if [ -d ~/.zshfunc ]; then
    fpath=( ~/.zshfunc $fpath )
    autoload periodic chpwd 
 fi

 autoload -U promptinit
 promptinit

 TMOUT=16
 TRAPALRM() {
    zle reset-prompt
 }

 # PROMPT="%m-%B%T%b-%02c-%!:%?-%# %E"
 PROMPT="%m-%B%T%b-%?-%# %E"
 # RPROMPT=" %02c"
 RPROMPT=" %~"

 # prompt2="%m-%B%T%b-%_-%# %E"
 # prompt3="%m-%B%T%b-%_-%# %E"
 # prompt4="-> %E"
 # SPROMPT="Correct-> %R -- %B%r%b%E (y, n, e)? [n]: %E"

 READNULLCMD=/bin/less
 export EDITOR=`which vim`
 export PAGER=`which less`

 # MAILCHECK=600	# every min.

 HISTFILE=~/tmp/.history
 HISTORY=1024
 SAVEHIST=$((1024 * 1024 * 4))

 export PERIOD=600

 export MAN=-sw

 # export FSP_PORT=21
 # export FSP_HOST=128.174.240.63
 # export FSP_DIR=/
 # export FSP_TRACE=
 # export FSP_DELAY=3000

#--------------------------------------------------------------
# zsh options

 setopt always_last_prompt
 setopt append_history
 setopt always_to_end
 # setopt auto_cd
 setopt auto_name_dirs
 setopt auto_param_keys
 setopt cdable_vars
 setopt chase_links
# setopt no_clobber
 setopt correct
 setopt correct_all
 setopt extended_history
 setopt extended_glob
 # setopt glob_complete
# setopt hash_cmds
# setopt hash_dirs
 setopt hist_ignore_dups
 setopt hist_ignore_space
 setopt hist_no_store
 setopt no_list_beep
 setopt list_types
 setopt long_list_jobs
 setopt LIST_ROWS_FIRST
 setopt mark_dirs
 setopt menu_complete
 setopt no_nomatch
 setopt print_exit_value
# setopt rec_exact
# setopt rc_quotes
 setopt TRANSIENT_RPROMPT

#--------------------------------------------------------------
# bindings

 bindkey -e
 bindkey '\C-z' reverse-menu-complete
#--------------------------------------------------------------

# New style complete - completion... Stolen from google.
if zstyle >& /dev/null; then
  # cdpath=( ./ ../ ~/ / )
  zstyle ':completion:*:*:(^rm):*:*' ignored-patterns '*?.o' '*?~' \
    '*?.bak' '*?.tmp'

  setopt NUMERIC_GLOB_SORT
  setopt LIST_TYPES
  setopt COMPLETE_IN_WORD
  setopt NO_CDABLE_VARS

  # General completion technique
  zstyle ':completion:*' completer _complete _prefix _approximate
  zstyle ':completion:*' completer _complete:case _prefix _approximate
  zstyle ':completion::approximate-2:*' completer _complete:case _ignored

  # match uppercase from lowercase
  zstyle ':completion:foo:*' matcher-list 'm:{a-z}={A-Z}'

  # Separate matches into groups
  # zstyle ':completion:*:matches' group 'yes'

  # Describe each match group.
  zstyle ':completion:*:descriptions' format "%B---- %d%b"

  # Messages/warnings format
  zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
  zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
   
  # Describe options in full
  zstyle ':completion:*:options' description 'yes'
  zstyle ':completion:*:options' auto-description '%d'

  zstyle ':completion:*' list-colors "$LS_COLORS"
  zstyle ':completion:*' format 'Completing %d'
  zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
  zstyle ':completion:*' menu select=long
  zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

  autoload compinit
  compinit -i
else
 cdpath=( ./ )
 fignore=( .o ~ )

# *(*) = executable
# *(/) = dir
# *(-/) = dir or symlink to dir
# *(@) = symlink

 compctl -g '*(*)' + -g '*(-/)' + -g '.*(*)' + -g '.*(-/)' \
    strip gprof adb gbb xxgdb which whence where
 compctl -x 'p[1]' -g '*(-/)' + -g '.*(-/)' -- cd rmdir mkdir
 compctl -f -x 'R[-*d,^*]' -g '*.gz .*.gz *.z .*.z *.Z .*.Z' + -g '*(-/)'+ -g '.*(-/)' -- gzip
 compctl -g '*.gz .*.gz *.z .*.z *.Z .*.Z' + -g '*(-/)' + -g '.*(-/)' gunzip
 compctl -f -x 'R[-*d,^*]' -g '*.tz .*.tz' + -g '*(-/)'+ -g '.*(-/)' -- tzip
 compctl -g '*.tz .*.tz' + -g '*(-/)' + -g '.*(-/)' tunzip
 compctl -g '*.Z' + -g '*(-/)' uncompress zmore
# compctl -f -x 'C[-1,*f*] p[2]' -g "*.tar" -- tar
 compctl -j -P % fg bg wait jobs disown
 compctl -e disable
 compctl -d enable
fi

#--------------------------------------------------------------
# aliases

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
# alias telnetob='telnet orangey-beard.csc.stu.mmu.ac.uk'
# alias telob='telnetob'
# alias ftpob='ftp orangey-beard.csc.stu.mmu.ac.uk'
# alias telm='tel mayfair.netkonect.net'
# alias telnetm=telm
 alias h=history
 alias npurge='npurge -v'
# alias xfishtank='xfishtank -i 0.1 -b 64 -f 32 -r 0.1 -d'
 alias xfishtank='xfishtank -d'
# alias telnet=tel
 alias j=jobs
 alias where='whence -a'

 if [ "x$(uname -s)" = "xDarwin" ]; then
   alias jls_=gls
 else
   alias jls_=/bin/ls
 fi
 alias jls="jls_ --block-size=\'1 --color=auto --sort=version --time-style=long-iso -F -T 0"
 alias l='jls -ABFbhs'
 alias ll='jls -BFabhl'
 alias lsz='l --sort=size -r'
 alias llsz='ll --sort=size -r'
 alias free='free -tk'
 alias t='tree -h'
 alias tsz='tree -h --sort=size'


 alias cd.='cd .'
 alias cd..='cd ..'
 alias cd...='cd ../..'
 alias cd....='cd ../../..'
 alias cd.....='cd ../../../..'

 alias egrep='egrep --color=auto -d skip'
 alias fgrep='fgrep --color=auto -d skip'
 alias grep='grep --color=auto -d skip'
 alias pgrep='pcre2grep --color=auto -d skip'


 alias rpmsrc='rpm -Uvh --define "_sourcedir `pwd`" --define "_specdir `pwd`"'

 # Base rsync cmds
 _rsync_cmd_archive='rsync --partial --info=progress2 --archive'
 _rsync_opt_new_archive='--acls --xattrs'
 _rsync_exclude='--exclude="**/.git" --exclude="*.pyc" --exclude="*.pyo" --exclude="*.o" --exclude="*~"'
 # Merge rsync
 alias lrms="$_rsync_cmd_archive $_rsync_opt_new_archive"
 alias lrmsx="lrms $_rsync_exclude"
 alias rms='lrms -e ssh'
 alias rmsx="lrms -e ssh $_rsync_exclude"
 alias orms="$_rsync_cmd_archive -e ssh"
 alias ormsx="orms $_rsync_exclude"
 # Destructive/delete rsync
 alias rds='rms --del'
 alias rdsx='rmsx --del'
 alias lrds='lrms --del'
 alias lrdsx='lrmsx --del'
 alias ords='orms --delete'
 alias ordsx='ormsx --delete'

 alias gmpush='git push origin main'
 alias gmpull='git pull origin main'
 alias gfgrep='git grep -F'
 alias g0gover='TZ=UTC git --no-pager show --quiet --abbrev=12 \
                           --date='format-local:%Y%m%d%H%M%S' \
                           --format="v0.0.0-%cd-%h"'

 alias mockb='nice nice mock'

 alias drun1='docker run --rm -it'
 alias drun1lvm='docker run --rm -v $(pwd):/mnt -it'
 alias prun1='podman run --rm -it'
 alias prun1lvm='podman run --rm -v $(pwd):/mnt -it'


 # alias bcppoker='~/work/PokerHands/bcp2sqlite.py --player=illiterat --color'
 alias bcppoker='~/work/PokerHands/bcp2sqlite.py --player=Ih8plo8 --color'
 alias bcppoker2d='bcppoker Documents/HandHistory/Carbon/$(date +"%Y%m%d")/*.xml'
 alias bcppoker3d='bcppoker Documents/HandHistory/Carbon/$(date +"%Y%m%d")/*.xml Documents/HandHistory/Carbon/$(date -v-1d +"%Y%m%d")/*.xml Documents/HandHistory/Carbon/$(date -v-2d +"%Y%m%d")/*.xml'
 alias bcppoker-1d='bcppoker Documents/HandHistory/Carbon/$(date -v-1d +"%Y%m%d")/*.xml'
 alias bcppoker2m='bcppoker Documents/HandHistory/Carbon/$(date +"%Y%m")*/*.xml'
 alias bcppoker-1m='bcppoker Documents/HandHistory/Carbon/$(date -v-1m +"%Y%m")*/*.xml'

# -r == released
# rhts-reserve -f RedHatEnterpriseLinuxServer5 -r -a x86_64


# Make these functions, common to other languages, available in the shell
ord() { printf "0x%x\n" "'$1"; }
chr() { printf $(printf '\\%03o\\n' "$1"); }


# what most people want from od (hexdump)
alias hd='od -Ax -tx1z -v'

# canonicalize path (including resolving symlinks)
alias realpath='readlink -f'

# make and change to a directory
mkcd () { mkdir -p "$1" && cd "$1"; }

 export DEV_CVS_RSH=krsh
 export CVS_RSH=$DEV_CVS_RSH

 export OLDHOME_CVSROOT=$HOME/work/cvsroot
 export SEG_CVSROOT=:ext:jantill@seg.rdu.redhat.com:/export/cvs
 export DEV_CVSROOT=:ext:jantill@cvs.devel.redhat.com:/cvs/dist
 export CVSROOT=$DEV_CVSROOT

 # Stupid fucking VPN
 unset http_proxy

  # Setup the terminal title...
 if [ -d ~/.zshfunc ]; then
   chpwd
 fi

 if [ -f ~/bin/goto.sh ]; then
   source ~/bin/goto.sh
 fi

LANG=en_US.UTF-8
LC_TIME=en_GB.UTF-8

 # export GOARCH=amd64
 # export GOROOT=~/work/external/go-lang
 export GOPATH=$HOME/work/external/go-lang
 PATH="$PATH:$GOPATH/bin"

 # if [ -e /Users/james/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/james/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

fi
