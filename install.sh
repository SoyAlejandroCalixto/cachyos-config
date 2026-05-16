sudo -v # Prevent sudo from asking for your password again
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_PID=$!

# Dotfiles
mv dots/. $HOME/

# -- Package installation --
sudo pacman -Rns --noconfirm vim alacritty # Remove unused

sudo pacman -S --noconfirm --needed git github-cli neovim zsh ttf-cascadia-code-nerd fastfetch yazi zoxide atuin zsh-autosuggestions zsh-syntax-highlighting ghostty flatpak discord lsd bat fzf mise direnv bitwarden
paru -S --noconfirm --needed brave-bin pear-desktop

mkdir -p ~/.local/share/fonts # Install fonts that do not exist as a package
git clone https://github.com/simpals/onest.git /tmp/onest
mv /tmp/onest/fonts/ttf/*.ttf "$HOME/.local/share/fonts/"
rm -rf /tmp/onest

# -- Others tweaks --
chsh -s /bin/zsh

trap "kill $SUDO_PID 2>/dev/null" EXIT # kill the process that keeps sudo without password
