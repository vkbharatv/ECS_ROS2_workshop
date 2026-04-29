#!/usr/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

ASSUME_YES="false"
if [[ "${1:-}" == "--yes" || "${1:-}" == "-y" ]]; then
    ASSUME_YES="true"
fi

echo "==============================================="
echo "ECS ROS2 Workshop - Full Uninstall (Ubuntu 24.04)"
echo "This will remove ROS 2 Jazzy, Gazebo bridge, MoveIt,"
echo "workshop apt packages, rosdep setup, and ~/.venv."
echo "==============================================="

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
else
    echo "Cannot find /etc/os-release. Aborting."
    exit 1
fi

if [[ "${ID:-}" != "ubuntu" ]]; then
    echo "This script supports Ubuntu only."
    echo "Detected: ${PRETTY_NAME:-unknown}"
    exit 1
fi

confirm() {
    if [[ "$ASSUME_YES" == "true" ]]; then
        return 0
    fi

    read -r -p "Proceed with full uninstall? [y/N]: " ans
    case "$ans" in
        y|Y|yes|YES) return 0 ;;
        *)
            echo "Uninstall cancelled."
            exit 0
            ;;
    esac
}

confirm

echo "[1/8] Removing ROS 2 Jazzy, MoveIt, Gazebo integration"
sudo apt purge -y \
    'ros-jazzy-*' \
    ros2-apt-source || true

echo "[2/8] Removing workshop tooling packages"
sudo apt purge -y \
    python3-colcon-common-extensions \
    python3-rosdep \
    tesseract-ocr \
    libzbar-dev \
    libzbar0t64 \
    python3-tk \
    libfuse2t64 || true

echo "[3/8] Removing ROS apt source package leftovers"
if dpkg -s ros2-apt-source >/dev/null 2>&1; then
    sudo apt purge -y ros2-apt-source || true
fi

if [[ -f /etc/apt/sources.list.d/ros2.list ]]; then
    sudo rm -f /etc/apt/sources.list.d/ros2.list
fi
if [[ -f /usr/share/keyrings/ros-archive-keyring.gpg ]]; then
    sudo rm -f /usr/share/keyrings/ros-archive-keyring.gpg
fi

echo "[4/8] Removing rosdep initialization state"
sudo rm -f /etc/ros/rosdep/sources.list.d/20-default.list
rm -rf "$HOME/.ros/rosdep" || true

echo "[5/8] Cleaning user ROS/Gazebo runtime files"
rm -rf "$HOME/.ros" || true
rm -rf "$HOME/.gz" || true
rm -rf "$HOME/.ignition" || true

echo "[6/8] Removing Python virtual environment"
if [[ -d "$HOME/.venv" ]]; then
    rm -rf "$HOME/.venv"
fi

echo "[7/8] Removing shell setup lines"
if [[ -f "$HOME/.bashrc" ]]; then
    sed -i '/^source \/opt\/ros\/jazzy\/setup\.bash$/d' "$HOME/.bashrc"
fi

echo "[8/8] Autoremove and clean apt cache"
sudo apt autoremove -y --purge
sudo apt clean
sudo apt update

echo
echo "Full uninstall complete."
echo "Open a new terminal to ensure environment changes are applied."
