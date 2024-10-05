#!/bin/bash
# BEFORE MODIFCATION, SELLING, COPYING, ETC. PLEASE CHECK OUR LICENSE
# LICENSES ARE NOT LEGAL ADVICE.
# There are 4 error codes. if you get a error, please report it with their code.


function menu() {
    clear
    echo "==========================="
    echo "    Welcome to DPI 1.0     "
    echo "==========================="
    echo "1) Start"
    echo "2) Help"
    echo "3) Exit"
    read -rp "Choose an option: " inp
    case $inp in
        1)
            dpi
            ;;
        2)
            hlp
            ;;
        3)
            exit 0
            ;;
        *) 
            echo "[!] Invalid option! (Error code: 1)"
            sleep 2
            menu
            ;;
    esac
}

function dpi() {
    echo "To copy and paste, DO CTRL-Shift-C, then CTRL-Shift-V."
    echo
    read -rp "Enter the name of the Debian package (including .deb): " pkg

    if [[ -f "$pkg" ]]; then
        echo "Extracting $pkg..."
        dpkg-deb -x "$pkg" ~/packages
        sleep 2
        execute_desktop_file
    else
        echo "[!] Unable to find '$pkg' Debian package (Error code: 2)"
        sleep 2
        menu
    fi
}

function execute_desktop_file() {
# You may want to change the search directory below for error code 3 and 4
    search_dir=~/.local/share/applications/
    desktop_file=$(find "$search_dir" -name "*.desktop" | head -n 1)

    if [[ -n $desktop_file ]]; then
        echo "Getting your packages ready, please wait..."
        if xdg-open "$desktop_file"; then
            echo "Successfully installed $pkg. You should see your package folder in your home directory."
            echo "To execute the file again, you can run this at your terminal: xdg-open \"$desktop_file\""
            xdg-open "$desktop_file"
        else
            echo "[!] Unable to execute $desktop_file. (Error code: 3)"
            sleep 2
            menu
        fi
    else
        echo "[!] Unable to execute or find .desktop file in $search_dir. You may find it yourself. (Error code: 4)"
        echo "Files successfully extracted, but unable to execute."
        sleep 2 
        menu
    fi
}

function hlp() {
    echo "DPI stands for Debian Package Installer; it installs applications from Debian packages for you."
    echo "1) Starts installation."
    echo "2) This help screen."
    echo "3) Exits DPI."
    sleep 4
    menu
}

menu

