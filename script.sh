#!/bin/bash

source colours.sh

# --- Variables ---

SCRIPT_DIR=$(dirname "$(realpath "$0")")

# --- Functions ---

# --- CTRL + C ---

trap ctrl_c INT

function ctrl_c(){
	echo -e "\n\n${RED}[!] Exiting...\n${RED}"
	exit 1
}

# --- Banner ---

banner () {

    echo ""
    echo -e "${GREEN}███████╗██╗  ██╗ ██████╗ ██╗  ██╗${GREEN}"
    echo -e "${GREEN}██╔════╝██║  ██║██╔════╝ ██║ ██╔╝${GREEN}"
    echo -e "${GREEN}███████╗███████║██║  ███╗█████╔╝${GREEN}"
    echo -e "${GREEN}╚════██║╚════██║██║   ██║██╔═██╗${GREEN}"
    echo -e "${GREEN}███████║     ██║╚██████╔╝██║  ██╗${GREEN}"
    echo -e "${GREEN}╚══════╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝${GREEN}"
    echo -e "${RESET}         s4gk Installer Script${RESET}"
    echo ""
    echo ""
    echo ""

}

# --- Install Requirements ---

install_bspwm () {

    echo -e "${BLUE}Installing requirements and dependencies of bspwm...${BLUE}"
    echo ""
    sudo apt update -y > /dev/null 2>&1 && sudo apt install bspwm sxhkd -y > /dev/null 2>&1
    
    echo ""
    echo -e "${BLUE}Configuring bspwm & sxhkd${BLUE}"
    echo ""

    rm -rf ~/.config/bspwm ~/.config/sxhkd ~/.config/wallpapers
    mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config/wallpapers
    cp -r "$SCRIPT_DIR/bspwm/"* ~/.config/bspwm
    cp -r "$SCRIPT_DIR/sxhkd/"* ~/.config/sxhkd
    cp -r "$SCRIPT_DIR/wallpapers/"* ~/.config/wallapapers

}

# --- Install Polybar, Picom. Rofi

install_polybar () {

    echo -e "${BLUE}Installing requirements and dependencies of polybar...${BLUE}"
    echo ""
    sudo apt update -y > /dev/null 2>&1 && sudo apt install pollybar picom rofi 2>&1
    
    echo ""
    echo -e "${BLUE}Configuring Polybar${BLUE}"
    echo ""

    rm -rf ~/.config/polybar ~/.config/picom ~/.config/rofi
    mkdir -p ~/.config/polybar ~/.config/picom ~/.config/rofi ~/.local/share/fonts
    cp -r "$SCRIPT_DIR/polybar/"* ~/.config/polybar
    cp -r "$SCRIPT_DIR/picom/"* ~/.config/picom
    cp -r "$SCRIPT_DIR/rofi/"* ~/.config/rofi
    cp -r "$SCRIPT_DIR/fonts/"* ~/.local/share/fonts

    fc-cache -fv

}

# --- Function to install zsh & powerlevel10k ---

install_zsh_p10k () {

    echo "Installing zsh and powerlevel10k..."
    sudo apt install zsh -y
    echo "Changing default shell to zsh..."
    chsh -s $(which zsh)

    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
    echo 'source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    
    echo "Installation complete! Restart your terminal to apply changes."

}

# --- Function to install Kitty, zsh & Powerlevel10k

install_custom_terminal () {

    echo "Installing Kitty & zsh & powerlevel10k..."
    echo ""
    sudo apt install kitty zsh
    echo ""

    # Configurating Kitty
    
    rm -rf ~/.config/kitty
    mkdir -p ~/.config/kitty
    cp -r "$SCRIPT_DIR/fonts/"* ~/.local/share/fonts
    cp -r "$SCRIPT_DIR/kitty/"* ~/.config/kitty
    
}

# -----------------------------------------

banner


echo -e "${BLUE}Welcome to the Kraken installer${BLUE}"

echo ""

echo -e "${RESET}[1] Install Bspmw & Sxhkd${RESET}"
echo -e "${RESET}[2] Install Polybar, Picom, Rofi${RESET}"
echo -e "${RESET}[3] Customization Terminal${RESET}"
echo -e "${RESET}[4] All Customization${RESET}"
echo -e "${RESET}[5] Exit${RESET}"

echo ""

read option

echo ""

if [ "$option" -eq 1 ]; then
    install_bspwm
elif [ "$option" -eq 2 ]; then
    install_polybar
elif [ "$option" -eq 3 ]; then
    install_custom_terminal
elif [ "$option" -eq 4 ]; then
    echo "Option 4"
elif [ "$option" -eq 5 ]; then
    echo "Option 5"
else
    echo "$option Not an option"
fi