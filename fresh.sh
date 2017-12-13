# chrome install
# https://askubuntu.com/a/79284
sudo apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb

# Add repos and update
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update

# 
sudo apt install emacs25

# packages
sudo apt-get install -y vlc git python-pip

git clone https://github.com/gerikzatorski/.emacs.d
git clone https://github.com/gerikzatorski/dotfiles
rm ~/.bashrc
ln -s ~/dotfiles/.bashrc


