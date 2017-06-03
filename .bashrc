# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if test -x /bin/zsh -a -n "$SSH_TTY"; then
 exec /bin/zsh
fi

 alias ls='/bin/ls --color=auto --sort=version -F -T 0'
 alias l='ls -ABFbs'
 alias ll='l -BFabls'
 alias free='free -tok'
