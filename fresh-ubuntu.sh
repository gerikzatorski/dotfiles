#### Install Ubuntu Packages ####

# Add repos and update
sudo add-apt-repository ppa:kelleyk/emacs # emacs25
sudo apt update

# emacs25 and plugin dependencies
sudo apt install -y emacs25 clang libclang-dev virtualenv
# python stuff
sudo apt install -y python-pip python-numpy python-scipy python-matplotlib
# general packages
sudo apt install -y git vlc xclip cmake markdown byobu silversearcher-ag

#### Replace System Configs ####

cd ~
# .emacs.d
rm -rf ~/.emacs.d/
git clone https://github.com/gerikzatorski/.emacs.d
# dotfiles (.bashrc)
rm ~/.bashrc
git clone https://github.com/gerikzatorski/dotfiles
sudo ln -s ~/dotfiles/.bashrc

#### Change/Set Settings ####

# gnome dconf
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.shell.extensions.classic-overrides workspaces-only-on-primary false
gsettings set org.gnome.desktop.session idle-delay 300 # Timeout for blanking the screen (seconds; 0 = never):
gsettings set org.gnome.desktop.screensaver lock-delay 900 # Timeout for locking the screen after blanking (seconds; 0 = instant):

# git
git config --global user.email "gerikzatorski@gmail.com"
git config --global core.excludesfile ~/dotfiles/.gitignore
git config color.ui true
git config format.pretty oneline

#### Misc ####

# chrome install
# https://askubuntu.com/a/79284
# sudo apt install libxss1 libappindicator1 libindicator7
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo dpkg -i google-chrome*.deb
