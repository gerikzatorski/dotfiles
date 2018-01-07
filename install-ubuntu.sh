# chrome install
# https://askubuntu.com/a/79284
sudo apt install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb

# Add repos and update
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update

# general packages
sudo apt-get install -y vlc git xclip cmake markdown byobu silversearcher-ag
# emacs stuff
sudo apt-get install -y clang libclang-dev virtualenv
# python stuff
sudo apt install -y python-pip python-numpy python-scipy python-matplotlib

# emacs config
git clone https://github.com/gerikzatorski/.emacs.d
rm -rf ~/.emacs.d/
sudo apt install emacs25
# bash config
git clone https://github.com/gerikzatorski/dotfiles
rm ~/.bashrc
sudo ln -s ~/dotfiles/.bashrc
# git config
git config --global core.excludesfile ~/dotfiles/.gitignore

## Gnome dconf settings ##
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.shell.extensions.classic-overrides workspaces-only-on-primary false
gsettings set org.gnome.shell.window-switcher.app-icon-mode 'app-icon-only'
# Timeout for blanking the screen (seconds; 0 = never):
gsettings set org.gnome.desktop.session idle-delay 300
# Timeout for locking the screen after blanking (seconds; 0 = instant):
gsettings set org.gnome.desktop.screensaver lock-delay 900

