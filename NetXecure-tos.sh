#!/data/data/com.termux/files/usr/bin/bash

# =========================================================
#              NetXecure Quantum Framework
#               Developer : RKS EHacker
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

# ================= DIRECTORIES =================

BASE_DIR="$HOME/.netxecure"
LOG_DIR="$BASE_DIR/logs"
BACKUP_DIR="$BASE_DIR/backups"
PLUGIN_DIR="$BASE_DIR/plugins"
TEMP_DIR="$BASE_DIR/temp"

mkdir -p "$BASE_DIR"
mkdir -p "$LOG_DIR"
mkdir -p "$BACKUP_DIR"
mkdir -p "$PLUGIN_DIR"
mkdir -p "$TEMP_DIR"

# ================= SECURITY =================

trap 'echo -e "\n${RED}Interrupted.${RESET}"; exit' INT TERM

# ================= LOGGER =================

log_action(){
echo "[$(date '+%d-%m-%Y %H:%M:%S')] $1" >> "$LOG_DIR/system.log"
}

# ================= UI =================

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
echo -e "${WHITE}        Developer : RKS EHacker${RESET}"
echo -e "${GREEN}══════════════════════════════════════════════${RESET}"

echo
}

pause(){

echo
read -p " Press Enter To Continue..."
}

loader(){

echo
echo -ne "${CYAN}Loading "

for i in {1..25}
do
echo -ne "▓"
sleep 0.02
done

echo -e "${RESET}"
}

# ================= INPUT VALIDATION =================

validate_input(){

if [ -z "$1" ]
then
echo -e "${RED}Input Required.${RESET}"
return 1
fi

return 0
}

# ================= SYSTEM STATUS =================

system_status(){

header

echo -e "${YELLOW}SYSTEM STATUS${RESET}"
echo

echo -e "${GREEN}User         : ${WHITE}$(whoami)"
echo -e "${GREEN}Shell        : ${WHITE}$SHELL"
echo -e "${GREEN}Kernel       : ${WHITE}$(uname -r)"
echo -e "${GREEN}Architecture : ${WHITE}$(uname -m)"
echo -e "${GREEN}Uptime       : ${WHITE}$(uptime -p)"

echo
echo -e "${GREEN}Storage:${RESET}"
df -h /data | tail -1

echo
log_action "Checked System Status"

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
ruby
nano
vim
htop
neofetch
figlet
toilet
lolcat
openssh
proot
cmatrix
nmap
zip
unzip
tar
)

for package in "${packages[@]}"
do
pkg install "$package" -y >/dev/null 2>&1
done

pip install requests >/dev/null 2>&1
gem install lolcat >/dev/null 2>&1

echo
echo -e "${GREEN}Quantum Setup Completed.${RESET}"

log_action "Full Setup Installed"

pause
main_menu
}

# ================= SAFE AI TERMINAL =================

safe_ai_terminal(){

header

ALLOWED_COMMANDS=(
ls
pwd
clear
whoami
date
uname
ping
ifconfig
df
free
neofetch
cat
echo
)

while true
do

echo
echo -ne "${CYAN}NetXecure-AI ${WHITE}>> ${RESET}"
read cmd

validate_input "$cmd" || continue

if [[ "$cmd" =~ [\;\&\|\`\$\<\>] ]]
then
echo -e "${RED}Special Characters Blocked.${RESET}"
continue
fi

command=$(echo "$cmd" | awk '{print $1}')

case $command in

help)

echo
echo -e "${GREEN}Allowed Commands:${RESET}"

for c in "${ALLOWED_COMMANDS[@]}"
do
echo " - $c"
done

echo
echo "Special Commands:"
echo " matrix"
echo " status"
echo " exit"

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

if [[ " ${ALLOWED_COMMANDS[@]} " =~ " ${command} " ]]
then

echo "$(date) : $cmd" >> "$LOG_DIR/ai.log"

bash -c "$cmd"

else

echo -e "${RED}Command Not Allowed.${RESET}"

fi
;;

esac

done

main_menu
}

# ================= SECURITY VAULT =================

security_vault(){

header

read -sp "Create Vault Password : " pass1
echo

validate_input "$pass1" || return

read -sp "Confirm Password : " pass2
echo

if [ "$pass1" != "$pass2" ]
then
echo -e "${RED}Password Mismatch.${RESET}"
pause
main_menu
fi

HASH=$(echo "$pass1" | sha256sum | cut -d ' ' -f1)

echo "$HASH" > "$BASE_DIR/.vault"

chmod 600 "$BASE_DIR/.vault"

echo
echo -e "${GREEN}Vault Enabled Successfully.${RESET}"

log_action "Vault Created"

pause
main_menu
}

# ================= VERIFY VAULT =================

verify_vault(){

header

if [ ! -f "$BASE_DIR/.vault" ]
then
echo -e "${RED}Vault Not Configured.${RESET}"
pause
main_menu
fi

read -sp "Enter Password : " input
echo

HASH=$(echo "$input" | sha256sum | cut -d ' ' -f1)
SAVED=$(cat "$BASE_DIR/.vault")

if [ "$HASH" = "$SAVED" ]
then
echo -e "${GREEN}Access Granted.${RESET}"
log_action "Vault Access Granted"
else
echo -e "${RED}Access Denied.${RESET}"
log_action "Vault Access Failed"
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

tar \
--exclude="$HOME/storage" \
--exclude="$HOME/.cache" \
-czf "$BACKUP_DIR/home-backup.tar.gz" "$HOME" >/dev/null 2>&1

echo
echo -e "${GREEN}Backup Created Successfully.${RESET}"

log_action "Backup Created"

pause
main_menu
}

# ================= RAM BOOSTER =================

ram_booster(){

header
loader

pkg autoclean -y >/dev/null 2>&1

rm -rf ~/.cache/* >/dev/null 2>&1

echo
echo -e "${GREEN}RAM Optimization Completed.${RESET}"

log_action "RAM Optimized"

pause
main_menu
}

# ================= CYBER THEME =================

cyber_theme(){

header

cp ~/.bashrc "$BACKUP_DIR/bashrc.theme.backup" 2>/dev/null

cat >> ~/.bashrc << 'EOF'

clear
figlet "NetXecure" | lolcat

PS1='\[\e[1;32m\]┌──(NetXecure㉿RKS-EHacker)-[\w]
└─# \[\e[0m\]'

alias ll='ls -la'
alias cls='clear'
alias update='pkg update && pkg upgrade -y'

neofetch

EOF

echo
echo -e "${GREEN}Cyber Theme Enabled.${RESET}"

log_action "Cyber Theme Enabled"

pause
main_menu
}

# ================= FILE ENCRYPTION =================

file_encryptor(){

header

pkg install openssl -y >/dev/null 2>&1

read -p "Enter File Path : " file

validate_input "$file" || return

if [ ! -f "$file" ]
then
echo -e "${RED}File Not Found.${RESET}"
pause
main_menu
fi

read -sp "Password : " pass
echo

openssl enc -aes-256-cbc -salt \
-in "$file" \
-out "$file.enc" \
-k "$pass"

echo
echo -e "${GREEN}Encrypted : $file.enc${RESET}"

log_action "File Encrypted"

pause
main_menu
}

# ================= FILE DECRYPTION =================

file_decryptor(){

header

read -p "Encrypted File : " file

validate_input "$file" || return

if [ ! -f "$file" ]
then
echo -e "${RED}Encrypted File Not Found.${RESET}"
pause
main_menu
fi

read -sp "Password : " pass
echo

openssl enc -aes-256-cbc -d \
-in "$file" \
-out decrypted_output \
-k "$pass"

echo
echo -e "${GREEN}File Decrypted Successfully.${RESET}"

log_action "File Decrypted"

pause
main_menu
}

# ================= NETWORK TOOLKIT =================

network_toolkit(){

header

echo -e "${GREEN}[1]${WHITE} Ping Test"
echo -e "${GREEN}[2]${WHITE} DNS Lookup"

echo
read -p "Select : " net

case $net in

1)

read -p "Host : " host

validate_input "$host" || return

ping -c 4 "$host"

;;

2)

read -p "Domain : " domain

validate_input "$domain" || return

nslookup "$domain"

;;

*)

echo -e "${RED}Invalid Option.${RESET}"

;;

esac

pause
main_menu
}

# ================= PLUGIN MANAGER =================

plugin_manager(){

header

echo -e "${YELLOW}Installed Plugins:${RESET}"
echo

ls "$PLUGIN_DIR"

echo
log_action "Viewed Plugins"

pause
main_menu
}

# ================= UPDATE FRAMEWORK =================

update_framework(){

header
loader

pkg update -y >/dev/null 2>&1
pkg upgrade -y >/dev/null 2>&1

echo
echo -e "${GREEN}Framework Updated Successfully.${RESET}"

log_action "Framework Updated"

pause
main_menu
}

# ================= ABOUT =================

about_framework(){

header

echo -e "${CYAN}Framework Name : ${WHITE}NetXecure Quantum"
echo -e "${CYAN}Developer      : ${WHITE}RKS EHacker"
echo -e "${CYAN}Version        : ${WHITE}10.0 Secure"
echo -e "${CYAN}Platform       : ${WHITE}Termux"
echo -e "${CYAN}Security Layer : ${WHITE}Quantum Shield"

echo
pause
main_menu
}

# ================= MAIN MENU =================

main_menu(){

header

echo -e "${GREEN}[01]${WHITE} Full Quantum Setup"
echo -e "${GREEN}[02]${WHITE} Safe AI Terminal"
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
safe_ai_terminal
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
update_framework
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
