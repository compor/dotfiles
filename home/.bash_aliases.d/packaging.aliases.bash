if [[ $OPSYS_DISTRO == "ubuntu" ]]; then
  alias pkgupd='sudo apt update'
  alias pkgupg='sudo apt upgrade'
  alias pkgins='sudo apt install'
  alias pkgfnd='apt search'
elif [[ $OPSYS_DISTRO == "fedora" ]]; then
  alias pkgupd='dnf check-update'
  alias pkgupg='dnf upgrade'
  alias pkgins='dnf install'
  alias pkgfnd='dnf search'
elif [[ $OPSYS_DISTRO == "apple" ]]; then
  alias pkgupd='brew update && brew cask update'
  alias pkgupg='brew upgrade'
  alias pkgins='brew install'
  alias pkgfnd='brew search'
fi
