sudo -v # Prevent sudo from asking for your password again
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_PID=$!

# -- Package installation --
sudo pacman -Rns --noconfirm vim kitty wofi grim # Remove unused

sudo pacman -S --noconfirm --needed git github-cli neovim hyprland hyprpaper lua lua54 lua54-lgi playerctl socat zsh noto-fonts-emoji adobe-source-han-sans-jp-fonts ttf-cascadia-code-nerd mpv eog polkit-kde-agent xdg-desktop-portal-hyprland xdg-desktop-portal-gtk gnome-themes-extra fastfetch wl-clipboard wtype yazi dolphin zoxide atuin zsh-autosuggestions zsh-syntax-highlighting ghostty discord dunst fontconfig lsd bat fzf bitwarden
paru -S --noconfirm --needed brave-bin eww rofi-wayland rofimoji cliphist hyprshot pear-desktop fnm

mkdir -p ~/.local/share/fonts # Install fonts that do not exist as a package
git clone https://github.com/simpals/onest.git /tmp/onest
mv /tmp/onest/fonts/ttf/*.ttf "$HOME/.local/share/fonts/"
rm -rf /tmp/onest

# -- Cloning dotfiles --
git clone https://github.com/SoyAlejandroCalixto/arch4devs $HOME/arch4devs
cp -r ~/arch4devs/. ~/
sudo rm -rf ~/.git && sudo rm -rf ~/README.md && sudo rm -rf ~/install.sh && sudo rm -rf ~/LICENSE && sudo rm -rf ~/.gitignore # Clean repo trash

# -- Files --
cat << EOF > $HOME/.config/hypr/monitors.conf # Monitors settings
monitor=HDMI-A-1,1920x1080@75,0x0,1
monitor=DP-2,1920x1080@60,1920x0,1
EOF

cat << EOF > $HOME/.gitconfig # Git config
[credential "https://github.com"]
	helper =
	helper = !/usr/bin/gh auth git-credential
[credential "https://gist.github.com"]
	helper =
	helper = !/usr/bin/gh auth git-credential
[user]
	email = soyalejandrocalixto@gmail.com
	name = soyalejandrocalixto
[core]
	editor = antigravity --wait
	autocrlf = input
EOF

# -- Others tweaks --
chsh -s /bin/zsh

trap "kill $SUDO_PID 2>/dev/null" EXIT # kill the process that keeps sudo without password
