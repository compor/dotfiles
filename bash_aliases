
alias c='clear'
alias mkdir='mkdir -vp'
alias mount='mount | column -t'

# safety first
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -i'

if [[ $OPSYS_DISTRO == "ubuntu" ]]; then
    alias sysupd='sudo apt-get update'
    alias sysinst='sudo apt-get install'
elif [[ $OPSYS_DISTRO == "apple" ]]; then
    alias sysupd='brew update && brew cask update'
    alias sysinst='brew install'
fi

