#!/bin/bash

ROOTUID="0"
if [ "$(id -u)" -eq "$ROOTUID" ]; then
    echo -e "just call the script without sudo, it will ask your pass when needed"
    exit 1
fi

# Colors variables
end="\e[0m"
red="\e[31m"
green="\e[32m"
bold="\e[1m"

update_progress() {
    task=$((task + 1))
    progress=$((progress + step))
    # echo $task
    # echo $progress
}

progress_bar() {
    update_progress
    (
        echo "$progress"
        echo -e "# $1."
        notify-send "$1 - Progress: $progress%"
        sleep 3
        # =================================================================
        # Command for task with supressed output goes here.

        # =================================================================
    ) |
        zenity --progress \
            --title="Progress Status" \
            --text="First Task." \
            --width=300 --height=200 \
            --percentage=0 \
            --auto-close \
            --auto-kill
    # (($? != 0)) && zenity --error --text="Error in zenity command."

}

suc_fail_func() {
    if [ $? -eq 0 ]; then
        echo -e $green"\nSuccess on installing $1\n"$end
    else
        echo -e $red"Failure on installing $1"$end | tee -a ~/errors.log
    fi
}
# ================================================
# Step 1
echo -e $bold"Making a backup from original apt sources"$end
sleep 2
cat /etc/apt/sources.list | sudo tee /etc/apt/sources.list.bak

echo -e $bold"Redirecting to the main server sources in apt to avoid errors"$end
sleep 2
sudo sed -i 's|http://\w\w[.]|http://|g' /etc/apt/sources.list

echo -e $bold"Updating the repositories with the Main Server"$end
sleep 2
sudo apt-get clean
sudo apt-get update

# ================================================
# Step 2
echo -e $bold"\nInstalling packages for the GUI\n"$end
sleep 2
sudo apt install zenity dialog libncurses5-dev -y
suc_fail_func "GUI pacakages"

start=0
step=3
task=3

# ================================================
# Step 3
progress_bar "Starting the First APT batch on your new Ubuntu!"

#Adding Python PPA
sudo add-apt-repository ppa:deadsnakes/ppa -y
suc_fail_func "Python PPA"

# Adding TimeShift PPA
sudo add-apt-repository ppa:teejee2008/timeshift -y
suc_fail_func "TimeShift"

# ================================================
# Step 4
progress_bar "Updating the repositories for PPAs."
sudo apt-get update

# ================================================
# Step 5
progress_bar "Installing many usefull packages."
sudo apt install gcc g++ make gconf2 gconf-service dos2unix rsync xterm htop vim vim-scripts emacs initramfs-tools binutils numlockx kernel-package pdfshuffler ubuntu-restricted-extras fonts-firacode libxml2-dev geany cups cups-pdf git apt-file gparted gnome-tweak-tool ffmpeg build-essential zlib1g-dev libbz2-dev liblzma-dev libreadline6-dev libsqlite3-dev libssl-dev libgdbm-dev liblzma-dev lzma lzma-dev libgdbm-dev libffi-dev uuid-dev libgdbm-dev libgdbm-compat-dev python2.7 python3-tk libnss3-dev libssl-dev libreadline-dev wget linux-headers-$(uname -r) tilix curl filezilla alacarte lsb-core gnome-shell-extensions snap snapd python3 python3-pip copyq guake firefox fish transmission nmap iptraf net-tools screen -y && sudo apt-get upgrade -y
suc_fail_func "many usefull pacakages"

# ================================================
# Step 6
progress_bar "Setting up variable for this program."

### Global Variables
gitrepo="https://raw.githubusercontent.com/jcesarprog/first-apt/master"
user=$(who | awk '{print $1}')
user_home="/home/$user"
name=$(lsb_release -sc)
u_18_name="bionic"


echo -e $bold"\nThis distribution codename is $name\nUser: $user"$end
sleep 2

# ================================================
# Step 7
progress_bar "Installing other utility packages."

if [ "$name" != "$u_18_name" ]; then
    echo -e $bold"\nInstalling python2 due to some dependencies\n"$end
    sudo apt install libpython2-stdlib python-is-python2 python2 python2-minimal tk8.6-dev -y
    if [ $? -eq 0 ]; then
        echo -e $green"\nSuccess on installing python2\n"$end
    else
        echo -e $red"Failure on installing python2"$end | tee -a ~/errors.log
    fi

else
    sudo apt install tk8.5-dev

fi

# ================================================
# Step 8
progress_bar "Setting up the system."

echo -e $bold"\nRemoving the error for Tilix terminal for user and root\n"$end
sleep 2
echo "\nif [ \$TILIX_ID ] || [ \$VTE_VERSION ]; then\n\tsource /etc/profile.d/vte*.sh\nfi" | tee -a ~/.bashrc
echo "\nif [ \$TILIX_ID ] || [ \$VTE_VERSION ]; then\n\tsource /etc/profile.d/vte*.sh\nfi" | sudo tee -a /root/.bashrc

echo -e $bold"\nEnabling bash autocompletion for user and root\n"$end
sleep 2
echo "\n. /etc/bash_completion" | tee -a ~/.bashrc
echo "\n. /etc/bash_completion" | sudo tee -a /root/.bashrc

echo -e $bold"\nEnabling Color prompt on terminal for user and root\n"$end
sleep 2
sed -i "s/#force_color_prompt/force_color_prompt/g" ~/.bashrc
sed -i "s/#export GCC_COLORS/export GCC_COLORS/g" ~/.bashrc
sudo sed -i "s/#force_color_prompt/force_color_prompt/g" /root/.bashrc
sudo sed -i "s/#export GCC_COLORS/export GCC_COLORS/g" /root/.bashrc

echo -e $bold"\nPutting python on user path to avoid warnings\n"$end
sleep 2
echo "\nexport PATH=/home/$user/.local/bin:\$PATH" >>~/.bashrc

echo -e $bold"\nEnabling numlock on lightdm start\n"$end
sleep 2
echo "greeter-setup-script=/usr/bin/numlockx on" | sudo tee -a /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf

echo -e $bold"\nChoose the default editor for the system\n"$end
sleep 3
sudo update-alternatives --config editor

echo -e $bold"\nChoose the default terminal emulator for the system\n"$end
sleep 3
sudo update-alternatives --config x-terminal-emulator

# ================================================
# Step 9
progress_bar "Installing packages for audio, video, drawing, streaming, math and virtualbox."
sudo apt install vlc gimp pinta blender krita simplescreenrecorder obs-studio cheese audacity geogebra octave wireshark virtualbox -y
suc_fail_func "packages for audio, video, drawing, streaming, math and virtualbox"

# ================================================
# Step 10
progress_bar "Adding VsCode to sources."
echo -e "#VsCode\ndeb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# ================================================
# Step 11
progress_bar "Adding Sublime-Text to sources."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# ================================================
# Step 12
progress_bar "Adding AnyDesk to sources."
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list

# ================================================
# Step 13
progress_bar "Adding Insync to sources."
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
echo "deb http://apt.insync.io/ubuntu $name non-free contrib" | sudo tee -a /etc/apt/sources.list.d/insync.list

# ================================================
# Step 14
progress_bar "Installing Google Chrome."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
suc_fail_func "Google Chrome"

# ================================================
# Step 15
progress_bar "Installing chrome-gnome-shell, code, sublime-text, anydesk, grub-customizer, insync."
sudo apt-get update
sudo apt install chrome-gnome-shell code sublime-text anydesk grub-customizer insync libcanberra-gtk-module -y
suc_fail_func "chrome-gnome-shell, code, sublime-text, anydesk, grub-customizer, insync"

# ================================================
# Step 16
progress_bar "Installing Nautilus Actions."
sudo apt install nautilus-actions -y
suc_fail_func "Nautilus Actions"

# ================================================
# Step 17
progress_bar "Installing Telegram."
sudo snap install telegram-desktop
sudo snap install telegram-cli
suc_fail_func "Telegram"

# ================================================
# Step 18
progress_bar "Installing Discord."
sudo snap install discord
suc_fail_func "Discord"

# ================================================
# Step 19
progress_bar "Installing Skype."
sudo snap install skype --classic
suc_fail_func "Skype"

# ================================================
# Step 20
progress_bar "Installing Slack."
sudo snap install slack --classic
suc_fail_func "Slack"

# ================================================
# Step 21
progress_bar "Installing MailSpring."
sudo snap install mailspring
suc_fail_func "MailSpring"

# ================================================
# Step 22
progress_bar "Installing GitKraken."
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb
suc_fail_func "Git-Kraken"

# ================================================
# Step 23
progress_bar "Installing TimeShift for Restoring Points Backups."
sudo apt install timeshift -y
suc_fail_func "TimeShift"

# ================================================
# Step 24
progress_bar "Installing Steam."
sudo add-apt-repository multiverse
sudo apt-get update
sudo apt install steam -y
suc_fail_func "Steam"

# ================================================
# Step 25
progress_bar "Installing Umake."
sudo snap install ubuntu-make --classic
suc_fail_func "Ubuntu-Make"

# ================================================
# Step 26
progress_bar "Installing Arduino IDE."
echo -e $bold"\nAdvisable to leave the default path given\n"$end
sleep 2
umake electronics arduino
suc_fail_func "Arduino IDE"

echo -e $bold"Adding user to dialout group for Arduino"$end
sleep 2
sudo usermod -a -G dialout $user

# ================================================
# Step 27
progress_bar "Installing Dropbox."
sudo wget -O /usr/local/bin/dropbox "https://www.dropbox.com/download?dl=packages/dropbox.py"
sudo chmod +x /usr/local/bin/dropbox
dropbox start -i
dropbox autostart y
sudo apt install nautilus-dropbox -y
dropbox start
suc_fail_func "Dropbox"

# ================================================
# Step 28
progress_bar "Setting up vi theme.\nInstalling vimrc template."

echo -e $bold"Installing vimrc template"$end
sleep 2
echo -e $bold"Downloading vimrc template"$end
wget -P $user_home/ $gitrepo/vimrc
suc_fail_func "Downloading vimrc template"

version=$(ls /usr/share/vim/ | grep -P "vim[0-9]{2}")
echo -e $bold"vim-script version: $version"$end
echo -e $bold"Installing vimrc"$end
sed -i -E "s/vim[0-9]{2}/$version/g" ~/vimrc
mv ~/vimrc ~/.vimrc
sudo cp $user_home/.vimrc /root/.vimrc
suc_fail_func "vimrc template"

# ================================================
# Step 29
progress_bar "Installing Python-3.7.7 from python.org"
file="https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tar.xz"
echo -e $bold"Downloading Python-3.7.7 from python.org"$end
wget -P $user_home/ $file
suc_fail_func "Downloading Python-3.7.7 from python.org"
# dir=$(echo $1 | sed 's|.tar.*||g')
tar xvf Python-3.7.7.tar.xz
cd ~/Python-3.7.7
sudo ./configure
sudo make
sudo make test
sudo make install
suc_fail_func "Python3.7.7"

# ================================================
# Step 30
progress_bar "Setting up system variables for Python-3.7.7"
PYTHON_HOME=$(pwd)
echo "" | sudo tee -a /etc/profile
echo "PYTHON_HOME=$PYTHON_HOME" | sudo tee -a /etc/profile
echo -e "PATH=\$PYTHON_HOME:\$PATH" | sudo tee -a /etc/profile
echo "export PYTHON_HOME PATH" | sudo tee -a /etc/profile
sudo ln -s /home/$user/Python-3.7.7/python /usr/bin/python3.7
suc_fail_func "Python3.7.7 variables"

# ================================================
# Step 31
progress_bar "Installing Docker."
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# sudo apt-get update
# sudo apt install docker-ce docker-ce-cli containerd.io
sudo snap install docker
suc_fail_func "Docker"
echo -e $bold"Verifying docker instalation"$end
sudo docker run hello-world
suc_fail_func "Docker"

# ================================================
# Step 32
progress_bar "Installing mlocate."
sudo apt install mlocate
suc_fail_func "mlocate"

# ================================================
# Step 33
progress_bar "Cleaning apt cache files."
sudo apt-get clean

# ================================================
# Step 34
progress_bar "Updating Apt-File database."
sudo apt-file update
suc_fail_func "Apt-File"

echo -e "\n\n"
echo -e $bold"#####################################"$end
echo -e $bold"# YOU SHOULD REBOOT YOUR SYSTEM NOW #"$end
echo -e $bold"#####################################"$end

echo -e $bold"\nIF ANY ERRORS OCCURRED, THEY WILL BE LOGGED IN FILE:"$end "~/errors.log"
notify-send "first_apt-get.sh script completed"
spd-say "COMPLETED"
