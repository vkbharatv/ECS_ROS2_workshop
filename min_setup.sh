#!/bin/bash

sudo apt update && sudo apt upgrade -y

PACKAGES=(
    build-essential
    curl
    git
    python3-venv
    unzip
    wget
    tesseract-ocr
    libzbar-dev
    libfuse2
    libzbar0
    python3-tk
python3-dev
python3-pip
    colcon

)

for package in "${PACKAGES[@]}"; do
    echo "Installing $package..."
    sudo apt install -y "$package" --upgrade
done




# Create python virtual environment and install python packages
sudo apt install -y python3-venv
if [ ! -d "$HOME/.venv" ]; then
    echo "================================"
    echo "Creating Python virtual environment..."
    echo "================================"
    python3 -m venv "$HOME/.venv"
else
    echo "==========================================="
    echo "Python virtual environment already exists."
    echo "============================================"
fi

source "$HOME/.venv/bin/activate"
pip install --upgrade pip
pip install numpy pyzbar matplotlib sympy xlsxwriter pandas
pip install stable_baselines3 selenium pytesseract
pip install pyqt5 pyqtgraph pyzbar pyyaml 
pip install openpyxl
pip install opencv-python
pip install pdf2image lxml
pip install controlsim gspread Ipython ipykernel
deactivate


/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
sudo apt update && sudo apt upgrade

# install ros2 Jazzy

locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings


sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb

sudo apt update && sudo apt install ros-jazzy-desktop -y
sudo apt install ros-jazzy-ros-gz

if ! grep -Fxq "source /opt/ros/jazzy/setup.bash" "$HOME/.bashrc"; then
    echo "source /opt/ros/jazzy/setup.bash" >> "$HOME/.bashrc"
fi

source /opt/ros/jazzy/setup.bash