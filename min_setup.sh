#!/usr/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "========================================"
echo "Ubuntu 24.04 + ROS 2 Jazzy full setup"
echo "(Gazebo, RViz, MoveIt, tooling)"
echo "========================================"

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
else
    echo "Cannot find /etc/os-release. Aborting."
    exit 1
fi

if [[ "${ID:-}" != "ubuntu" || "${VERSION_ID:-}" != "24.04" ]]; then
    echo "This script targets Ubuntu 24.04 only."
    echo "Detected: ${PRETTY_NAME:-unknown}"
    exit 1
fi

echo "[1/7] System update"
sudo apt update
sudo apt upgrade -y

echo "[2/7] Base packages"
sudo apt install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    gnupg \
    locales \
    lsb-release \
    python3-dev \
    python3-pip \
    python3-tk \
    python3-venv \
    software-properties-common \
    tesseract-ocr \
    unzip \
    wget \
    libfuse2t64 \
    libzbar-dev \
    libzbar0t64

echo "[3/7] Locale + apt source prep"
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

sudo add-apt-repository universe -y

ROS_APT_SOURCE_VERSION="$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')"
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.${UBUNTU_CODENAME}_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb
rm -f /tmp/ros2-apt-source.deb

sudo apt update
sudo apt install -y \
    python3-colcon-common-extensions \
    python3-rosdep

echo "[4/7] Install ROS 2 Jazzy + RViz + Gazebo + MoveIt"
sudo apt install -y \
    ros-jazzy-desktop \
    ros-jazzy-rviz2 \
    ros-jazzy-ros-gz \
    ros-jazzy-moveit \
    ros-jazzy-moveit-servo \
    ros-jazzy-joint-state-publisher-gui \
    ros-jazzy-xacro

echo "[5/7] Initialize rosdep"
if [[ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ]]; then
    sudo rosdep init
fi
rosdep update

echo "[6/7] Create Python venv + install Python libraries"
if [[ ! -d "$HOME/.venv" ]]; then
    python3 -m venv "$HOME/.venv"
fi

source "$HOME/.venv/bin/activate"
python -m pip install --upgrade pip wheel "setuptools<82"
python -m pip install \
    controlsim \
    gspread \
    ipykernel \
    ipython \
    lxml \
    matplotlib \
    numpy \
    opencv-python \
    openpyxl \
    pandas \
    pdf2image \
    pyqt5 \
    pyqtgraph \
    pytesseract \
    pyyaml \
    pyzbar \
    selenium \
    stable-baselines3 \
    sympy \
    typeguard \
    xlsxwriter
deactivate

echo "[7/7] Persist shell setup"
if ! grep -Fxq "source /opt/ros/jazzy/setup.bash" "$HOME/.bashrc"; then
    echo "source /opt/ros/jazzy/setup.bash" >> "$HOME/.bashrc"
fi

echo
echo "Setup complete. Open a new terminal or run:"
echo "source /opt/ros/jazzy/setup.bash"
echo
echo "Quick checks:"
echo "  ros2 --version"
echo "  rviz2"
echo "  ros2 launch ros_gz_sim gz_sim.launch.py"