#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e '\e[34m'
echo -e '$$\   $$\ $$$$$$$$\      $$$$$$$$\           $$\                                       $$\     '
echo -e '$$$\  $$ |\__$$  __|     $$  _____|          $$ |                                      $$ |    '
echo -e '$$$$\ $$ |   $$ |        $$ |      $$\   $$\ $$$$$$$\   $$$$$$\  $$\   $$\  $$$$$$$\ $$$$$$\   '
echo -e '$$ $$\$$ |   $$ |$$$$$$\ $$$$$\    \$$\ $$  |$$  __$$\  \____$$\ $$ |  $$ |$$  _____|\_$$  _|  '
echo -e '$$ \$$$$ |   $$ |\______|$$  __|    \$$$$  / $$ |  $$ | $$$$$$$ |$$ |  $$ |\$$$$$$\    $$ |    '
echo -e '$$ |\$$$ |   $$ |        $$ |       $$  $$<  $$ |  $$ |$$  __$$ |$$ |  $$ | \____$$\   $$ |$$\ '
echo -e '$$ | \$$ |   $$ |        $$$$$$$$\ $$  /\$$\ $$ |  $$ |\$$$$$$$ |\$$$$$$  |$$$$$$$  |  \$$$$  |'
echo -e '\__|  \__|   \__|        \________|\__/  \__|\__|  \__| \_______| \______/ \_______/    \____/ '
echo -e '\e[0m'
echo -e "Join our Telegram channel: https://t.me/NTExhaust"
sleep 5

CONFIG_FILE="docker-compose.yml"

# List of available Windows versions
echo "Select a Windows version from the list below:"
echo " Value  | Version                   | Size"
echo "--------------------------------------"
echo " 11     | Windows 11 Pro             | 5.4 GB"
echo " 11l    | Windows 11 LTSC            | 4.2 GB"
echo " 11e    | Windows 11 Enterprise      | 5.8 GB"
echo " 10     | Windows 10 Pro             | 5.7 GB"
echo " 10l    | Windows 10 LTSC            | 4.6 GB"
echo " 10e    | Windows 10 Enterprise      | 5.2 GB"
echo " 8e     | Windows 8.1 Enterprise     | 3.7 GB"
echo " 7e     | Windows 7 Enterprise       | 3.0 GB"
echo " ve     | Windows Vista Enterprise   | 3.0 GB"
echo " xp     | Windows XP Professional    | 0.6 GB"
echo " 2025   | Windows Server 2025       | 5.0 GB"
echo " 2022   | Windows Server 2022       | 4.7 GB"
echo " 2019   | Windows Server 2019       | 5.3 GB"
echo " 2016   | Windows Server 2016       | 6.5 GB"
echo " 2012   | Windows Server 2012       | 4.3 GB"
echo " 2008   | Windows Server 2008       | 3.0 GB"
echo " 2003   | Windows Server 2003       | 0.6 GB"

echo "Enter the value for the Windows version you want to use:"
read WINDOWS_VERSION

echo "Enter a username for Windows:"
read WINDOWS_USERNAME

echo "Enter a password for Windows:"
read -s WINDOWS_PASSWORD

echo "Enter RAM size (e.g., 8G):"
read RAM_SIZE

echo "Enter the number of CPU cores (e.g., 4):"
read CPU_CORES

echo "Enter disk size (e.g., 256G):"
read DISK_SIZE

cat > $CONFIG_FILE <<EOF
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "$WINDOWS_VERSION"
      USERNAME: "$WINDOWS_USERNAME"
      PASSWORD: "$WINDOWS_PASSWORD"
      RAM_SIZE: "$RAM_SIZE"
      CPU_CORES: "$CPU_CORES"
      DISK_SIZE: "$DISK_SIZE"
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    ports:
      - 8006:8006
      - 3389:3389/tcp
      - 3389:3389/udp
    volumes:
      - /home/user/example:/data
    restart: always
    stop_grace_period: 2m
EOF

# Run docker compose
docker compose up -d

PUBLIC_IP=$(curl -s ifconfig.me || curl -s icanhazip.com)

echo -e "${GREEN}Docker Compose started successfully!${NC}"
echo -e "${CYAN}Access your RDP on the website: http://$PUBLIC_IP:8009${NC}"
echo -e "${YELLOW}Created by Majikayo t.me/candraapn - VPS/RDP Store: https://t.me/candrapn${NC}"
