#!/bin/bash
# Zero-Trace Suite v1.0 - Official Professional Tool of r4ouf_s
# Developed by r4ouf_s

# Fix terminal colors and compatibility
export TERM=xterm-256color 2>/dev/null || true
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'

# Configuration
interfaces=("wlan0" "wlan1")

# --- [ Module: Help System ] ---
function show_help {
    echo -e "${CYAN}Zero-Trace Suite v1.0 - Manual${NC}"
    echo -e "${WHITE}The official professional tool of r4ouf_s${NC}"
    echo -e "${WHITE}Usage: sudo ./zero-trace.sh [option]${NC}\n"
    echo -e "${BLUE}Options:${NC}"
    echo -e "  -h, --help    Show this professional help menu"
    echo -e "\n${BLUE}Features Description:${NC}"
    echo -e "  ${CYAN}[1] Stealth Setup:${NC}  Kills processes, changes MAC to random, and sets monitor mode."
    echo -e "  ${CYAN}[2] Network Recon:${NC}  Quick access to airodump-ng for target scanning."
    echo -e "  ${RED}[3] Deep Clean:${NC}    Restores original MAC, wipes RAM/Swap, shreds logs."
    echo -e "  ${PURPLE}[4] Self-Destruct:${NC} Irreversibly deletes this script from the system."
    exit 0
}

# Check for help flags
case "$1" in
    -h|--help)
        show_help
        ;;
esac

# --- [ UI: Banner ] ---
function show_banner {
    clear
    echo -e "${CYAN}"
    echo "  __________                     ___________                     "
    echo "  \____    /___________  ____    \__    ___/___________    ____  "
    echo "    /     // __ \_  __ \/  _ \      |    |  \_  __ \__  \ _/ ___\ "
    echo "   /     /\  ___/|  | $  <_> )     |    |   |  | \// __ \\  \___ "
    echo "  /_______ \___  >__|   \____/      |____|   |__|  (____  /\___  >"
    echo "          \/   \/                                       \/     \/"
    echo -e "           ${WHITE}[ ${CYAN}Zero-Trace Suite v1.0${WHITE} ]${NC}"
    echo -e "    ${WHITE}[ ${PURPLE}The official professional tool of r4ouf_s${WHITE} ]${NC}"
}

# --- [ Module 1: Stealth Setup ] ---
function stealth_setup {
    echo -e "${BLUE}[!] Killing conflicting processes...${NC}"
    sudo airmon-ng check kill > /dev/null 2>&1
    
    summary=()
    success_count=0
    for iface in "${interfaces[@]}"; do
        if ! ip link show "$iface" > /dev/null 2>&1; then
            echo -e "${RED}[X] Interface $iface not found${NC}"
            continue
        fi
        
        echo -e "${BLUE}[*] Configuring: $iface${NC}"
        sudo ip link set "$iface" down
        sudo macchanger -r "$iface" > /dev/null 2>&1
        sudo ip link set "$iface" up
        sudo iw dev "$iface" set type monitor 2>/dev/null || sudo iwconfig "$iface" mode monitor 2>/dev/null
        sudo ip link set "$iface" up
        
        new_mac=$(ip link show "$iface" | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | head -1)
        [[ -z "$new_mac" ]] && new_mac=$(cat /sys/class/net/"$iface"/address 2>/dev/null)
        
        mode=$(iw dev "$iface" info 2>/dev/null | grep type | awk '{print $2}' || echo "monitor")
        summary+=("$iface|$new_mac|$mode")
        ((success_count++))
    done
    
    echo -e "\n${CYAN}[ RESULTS SUMMARY ]${NC}"
    printf "%-10s | %-17s | %-10s\n" "INTERFACE" "NEW MAC" "MODE"
    echo "---------------------------------------------------------"
    for line in "${summary[@]}"; do
        IFS='|' read -r iface mac mode <<< "$line"
        printf "%-10s | %-17s | %-10s\n" "$iface" "$mac" "$mode"
    done
    read -p "Press Enter to return..."
}

# --- [ Module 2: Forensic Wipe ] ---
function perform_full_wipe {
    echo -e "\n${RED}[!!!] Initiating Deep Sanitization...${NC}"
    for iface in "${interfaces[@]}"; do
        sudo ip link set "$iface" down 2>/dev/null
        sudo macchanger -p "$iface" >/dev/null 2>&1
        sudo iw dev "$iface" set type managed 2>/dev/null
        sudo ip link set "$iface" up 2>/dev/null
    done
    sudo systemctl restart NetworkManager 2>/dev/null
    sudo shred -u -n 10 ioom_capture* cracked.json *.cap *.netxml 2>/dev/null
    sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    
    logs=( "/var/log/auth.log" "/var/log/syslog" "/var/log/messages" "/var/log/kern.log" )
    for log in "${logs[@]}"; do
        [ -f "$log" ] && sudo truncate -s 0 "$log"
    done
    history -c && export HISTFILE=/dev/null
    echo -e "${GREEN}[✔] System Cleaned Successfully.${NC}"
    sleep 2
}

# --- [ Main Menu ] ---
function main_menu {
    while true; do
        show_banner
        VPN_IFACE=$(ip addr | grep -E 'tun|wg|proton' | grep 'UP' | awk '{print $2}' | sed 's/://' | head -1)

        if [[ -n "$VPN_IFACE" ]]; then
            echo -e "  ${GREEN}[✔] VPN: ACTIVE ($VPN_IFACE)${NC}" [cite: 20, 22]
        else
            echo -e "  ${RED}[!] VPN: INACTIVE${NC}"
        fi
        
        echo -e "\n${WHITE}  ┌─────────────────────────────┐${NC}"
        echo -e "  │ ${CYAN}[1] Stealth Setup${NC}             │"
        echo -e "  │ ${CYAN}[2] Network Recon${NC}             │"
        echo -e "  │ ${RED}[3] Deep Clean${NC}               │"
        echo -e "  │ ${PURPLE}[4] Self-Destruct${NC}            │"
        echo -e "  └─────────────────────────────┘${NC}"
        echo -en "  ${WHITE}Selection: ${NC}"
        read choice
        
        case $choice in
            1) stealth_setup ;;
            2) read -p "Enter Interface: " ifc; sudo airodump-ng "$ifc" ;;
            3) perform_full_wipe ;;
            4) 
               echo -e "${RED}[!] Self-Destructing...${NC}"
               sudo shred -u -z -n 10 "$0" 
               exit 0 ;;
            *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
        esac
    done
}

# Root Check
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[!] Please run with sudo.${NC}"
   exit 1
fi

main_menu
