sudo -v # make sudo never ask me for a password
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_PID=$!

# Install extra packages
sudo pacman -S --needed --noconfirm fzf bitwarden kvantum pamac-aur
paru -S --noconfirm --needed fnm cloudflare-warp-bin

# Clone my Hyprland config
git clone https://github.com/SoyAlejandroCalixto/arch4devs $HOME/arch4devs
cd $HOME/arch4devs
./install.sh
sudo rm -rf $HOME/arch4devs && sudo rm -rf $HOME/.git && sudo rm -rf $HOME/README.md && sudo rm -rf $HOME/LICENSE && sudo rm -rf $HOME/.gitignore # Clean repo trash

# Remove unused packages
sudo pacman -Rns --noconfirm dolphin vim kitty alacritty eog

# Add fnm to path
echo -e "\neval \"\$(fnm env --use-on-cd --shell zsh)\"" >> $HOME/.zshrc

# Hyprland monitors settings
cat << EOF > $HOME/.config/hypr/monitors.conf
monitor=HDMI-A-1,1920x1080@75,0x0,1
monitor=DP-2,1920x1080@60,1920x0,1
EOF

# Ranger config and plugins
mkdir -p $HOME/.config/ranger/plugins
git clone https://github.com/alexanderjeurissen/ranger_devicons $HOME/.config/ranger/plugins/ranger_devicons
echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf
git clone https://github.com/maximtrp/ranger-archives.git $HOME/.config/ranger/plugins/ranger-archives
echo "set preview_images true" >> $HOME/.config/ranger/rc.conf
echo "set preview_images_method iterm2" >> $HOME/.config/ranger/rc.conf

# Cloudflare Warp config
sudo systemctl enable warp-svc
sudo systemctl start warp-svc
warp-cli registration new

echo -e "\e[32mFinished.\e[0m\n"

trap "kill $SUDO_PID 2>/dev/null" EXIT # kill the process that keeps sudo without password