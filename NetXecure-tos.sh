#!/data/data/com.termux/files/usr/bin/bash

# =========================================================
#                NetXecure Quantum Framework
#               Developed By : RKS EHacker
# =========================================================

# ================= COLORS =================

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# ================= VARIABLES =================

BASE_DIR="$HOME/.netxecure"
LOG_DIR="$BASE_DIR/logs"
BACKUP_DIR="$BASE_DIR/backups"
PLUGIN_DIR="$BASE_DIR/plugins"

mkdir -p "$BASE_DIR"
mkdir -p "$LOG_DIR"
mkdir -p "$BACKUP_DIR"
mkdir -p "$PLUGIN_DIR"

# ================= UTILITIES =================

pause(){
    echo
    read -p " Press Enter To Continue..."
}

header(){
    clear
    echo -e "${CYAN}"
    echo "███╗   ██╗███████╗████████╗██╗  ██╗"
    echo "████╗  ██║██╔════╝╚══██╔══╝╚██╗██╔╝"
    echo "██╔██╗ ██║█████╗     ██║    ╚███╔╝ "
    echo "██║╚██╗██║██╔══╝     ██║    ██╔██╗ "
    echo "██║ ╚████║███████╗   ██║   ██╔╝ ██╗"
    echo "╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝"
    echo -e "${RESET}"
    echo -e "${GREEN}══════════════════════════════════════════════${RESET}"
    echo -e "${WHITE}        NETXECURE QUANTUM TERMINAL${RESET}"
    echo -e "${WHITE}        Author : RKS EHacker${RESET}"
    echo -e "${GREEN}══════════════════════════════════════════════${RESET}"
    echo
}

loader(){
    echo
    echo -ne "${CYAN}Initializing "
    for i in {1..25}; do
        echo -ne "▓"
        sleep 0.03
    done
    echo -e "${RESET}"
}

log_action(){
    echo "$(date) : $1" >> "$LOG_DIR/system.log"
}

# ================= SYSTEM STATUS =================

system_status(){

header

echo -e "${YELLOW}SYSTEM STATUS${RESET}"
echo

echo -e "${GREEN}User         :${WHITE} $(whoami)"
echo -e "${GREEN}Shell        :${WHITE} $SHELL"
echo -e "${GREEN}Kernel       :${WHITE} $(uname -r)"
echo -e "${GREEN}Architecture :${WHITE} $(uname -m)"
echo -e "${GREEN}Uptime       :${WHITE} $(uptime -p)"
echo -e "${GREEN}Storage      :${WHITE}"
df -h /data | tail -1

echo
pause
main_menu
}

# ================= FULL SETUP =================

full_setup(){

header
loader

pkg update -y && pkg upgrade -y

packages=(
git
curl
wget
zsh
python
python2
ruby
nano
vim
htop
neofetch
figlet
toilet
lolcat
openssh
tsu
proot
cmatrix
nmap
hydra
zip
unzip
tar
clang
)

for pkgname in "${packages[@]}"
do
    pkg install $pkgname -y
done

pip install requests
gem install lolcat

log_action "Full setup installed"

echo
echo -e "${GREEN}Framework Installation Complete.${RESET}"

pause
main_menu
}

# ================= AI TERMINAL =================

ai_terminal(){

header

while true
do
echo
echo -ne "${CYAN}NetXecure-AI ${WHITE}>> ${RESET}"
read cmd

case $cmd in

help)
echo "Available:"
echo "scan"
echo "matrix"
echo "status"
echo "exit"
;;

scan)
pkg install nmap -y
read -p "Target IP : " ip
nmap $ip
;;

matrix)
cmatrix
;;

status)
neofetch
;;

exit)
break
;;

*)
bash -c "$cmd"
;;

esac

done

main_menu
}

# ================= SECURITY VAULT =================

security_vault(){

header

read -sp "Create Quantum Password : " qpass
echo

HASH=$(echo "$qpass" | sha256sum | cut -d ' ' -f1)

echo "$HASH" > "$BASE_DIR/.vault"

echo
echo -e "${GREEN}Quantum Vault Enabled.${RESET}"

log_action "Vault Enabled"

pause
main_menu
}

# ================= VERIFY VAULT =================

verify_vault(){

header

if [ ! -f "$BASE_DIR/.vault" ]; then
echo -e "${RED}Vault Not Configured.${RESET}"
pause
main_menu
fi

read -sp "Enter Vault Password : " pass
echo

VERIFY=$(echo "$pass" | sha256sum | cut -d ' ' -f1)
SAVED=$(cat "$BASE_DIR/.vault")

if [ "$VERIFY" = "$SAVED" ]; then
echo -e "${GREEN}Access Granted.${RESET}"
else
echo -e "${RED}Access Denied.${RESET}"
fi

pause
main_menu
}

# ================= BACKUP ENGINE =================

backup_engine(){

header
loader

cp ~/.bashrc "$BACKUP_DIR/bashrc.backup" 2>/dev/null
cp ~/.zshrc "$BACKUP_DIR/zshrc.backup" 2>/dev/null

tar -czf "$BACKUP_DIR/home-backup.tar.gz" $HOME >/dev/null 2>&1

echo
echo -e "${GREEN}Backup Successfully Created.${RESET}"

log_action "Backup Created"

pause
main_menu
}

# ================= RAM BOOSTER =================

ram_booster(){

header

sync
echo 3 > /proc/sys/vm/drop_caches 2>/dev/null

pkg autoclean -y >/dev/null 2>&1

echo
echo -e "${GREEN}RAM Optimization Complete.${RESET}"

log_action "RAM Optimized"

pause
main_menu
}

# ================= CYBER THEME =================

cyber_theme(){

header

cat > ~/.bashrc << 'EOF'

clear
figlet "NetXecure" | lolcat
PS1='\[\e[1;32m\]┌──(NetXecure㉿RKS-EHacker)-[\w]
└─# \[\e[0m\]'

alias ll='ls -la'
alias update='pkg update && pkg upgrade -y'
alias cls='clear'
neofetch

EOF

echo
echo -e "${GREEN}Cyber Theme Activated.${RESET}"

log_action "Cyber Theme Enabled"

pause
main_menu
}

# ================= FILE ENCRYPTOR =================

file_encryptor(){

header

pkg install openssl -y >/dev/null 2>&1

read -p "File Path : " file
read -sp "Password : " pass
echo

openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc" -k "$pass"

echo
echo -e "${GREEN}Encrypted -> $file.enc${RESET}"

log_action "File Encrypted"

pause
main_menu
}

# ================= FILE DECRYPTOR =================

file_decryptor(){

header

read -p "Encrypted File : " file
read -sp "Password : " pass
echo

openssl enc -aes-256-cbc -d -in "$file" -out decrypted_output -k "$pass"

echo
echo -e "${GREEN}Decryption Completed.${RESET}"

log_action "File Decrypted"

pause
main_menu
}

# ================= NETWORK TOOLKIT =================

network_toolkit(){

header

echo "1. Ping Test"
echo "2. Port Scan"
echo "3. DNS Lookup"
echo

read -p "Select : " n

case $n in

1)
read -p "Host : " host
ping -c 4 $host
;;

2)
read -p "Target : " target
nmap $target
;;

3)
read -p "Domain : " domain
nslookup $domain
;;

*)
echo "Invalid"
;;

esac

pause
main_menu
}

# ================= PLUGIN MANAGER =================

plugin_manager(){

header

echo "Installed Plugins:"
echo

ls "$PLUGIN_DIR"

echo
pause
main_menu
}

# ================= UPDATE CORE =================

update_core(){

header
loader

pkg update -y
pkg upgrade -y

echo
echo -e "${GREEN}Quantum Core Updated.${RESET}"

log_action "Framework Updated"

pause
main_menu
}

# ================= ABOUT =================

about_framework(){

header

echo -e "${CYAN}Framework Name : ${WHITE}NetXecure Quantum"
echo -e "${CYAN}Developer      : ${WHITE}RKS EHacker"
echo -e "${CYAN}Platform       : ${WHITE}Termux"
echo -e "${CYAN}Security Layer : ${WHITE}Quantum Shield"
echo -e "${CYAN}Version        : ${WHITE}9.0"

echo
pause
main_menu
}

# ================= MAIN MENU =================

main_menu(){

header

echo -e "${GREEN}[01]${WHITE} Full Quantum Setup"
echo -e "${GREEN}[02]${WHITE} AI Interactive Terminal"
echo -e "${GREEN}[03]${WHITE} Security Vault"
echo -e "${GREEN}[04]${WHITE} Verify Vault"
echo -e "${GREEN}[05]${WHITE} Backup Engine"
echo -e "${GREEN}[06]${WHITE} RAM Booster"
echo -e "${GREEN}[07]${WHITE} Cyber Theme"
echo -e "${GREEN}[08]${WHITE} Encrypt File"
echo -e "${GREEN}[09]${WHITE} Decrypt File"
echo -e "${GREEN}[10]${WHITE} Network Toolkit"
echo -e "${GREEN}[11]${WHITE} Plugin Manager"
echo -e "${GREEN}[12]${WHITE} System Status"
echo -e "${GREEN}[13]${WHITE} Update Framework"
echo -e "${GREEN}[14]${WHITE} About"
echo -e "${RED}[00]${WHITE} Exit"

echo
read -p "Select Option : " option

case $option in

1|01)
full_setup
;;

2|02)
ai_terminal
;;

3|03)
security_vault
;;

4|04)
verify_vault
;;

5|05)
backup_engine
;;

6|06)
ram_booster
;;

7|07)
cyber_theme
;;

8|08)
file_encryptor
;;

9|09)
file_decryptor
;;

10)
network_toolkit
;;

11)
plugin_manager
;;

12)
system_status
;;

13)
update_core
;;

14)
about_framework
;;

0|00)
clear
exit
;;

*)
echo -e "${RED}Invalid Option.${RESET}"
sleep 1
main_menu
;;

esac
}

# ================= START =================

main_menu
