#!/bin/bash

# BEFORE MODIFICATION, SELLING, COPYING, ETC. PLEASE CHECK OUR LICENSE
# LICENSES ARE NOT LEGAL ADVICE.
# There are 4 error codes. if you get an error, please report it with their code.

function show_menu() {
    dialog --clear --title "Welcome to DPI 1.0" \
    --menu "Choose an option:" 15 50 3 \
    1 "Start" \
    2 "Help" \
    3 "Exit" \
    2>tempfile

    choice=$(<tempfile)
    case $choice in
        1) dpi ;;
        2) hlp ;;
        3) exit 0 ;;
        *) 
            dialog --msgbox "[!] Invalid option! \(Error code: 1\)" 5 40
            show_menu
            ;;
    esac
}

function dpi() {
    dialog --msgbox "To copy and paste, DO CTRL-Shift-C, then CTRL-Shift-V." 7 50
    pkg=$(dialog --inputbox "Enter the name of the Debian package (including .deb):" 8 50 3>&1 1>&2 2>&3)

    if [[ -f "$pkg" ]]; then
        dialog --title "Extracting Package" --infobox "Extracting $pkg..." 3 30
        dpkg-deb -x "$pkg" ~/packages
        sleep 2
        execute_desktop_file
    else
        dialog --msgbox "[!] Unable to find '$pkg' Debian package \(Error code: 2\)" 5 40
        show_menu
    fi
}

function execute_desktop_file() {
    search_dir=~/.local/share/applications/
    desktop_file=$(find "$search_dir" -name "*.desktop" | head -n 1)

    if [[ -n $desktop_file ]]; then
        dialog --title "Executing Package" --infobox "Getting your packages ready, please wait..." 3 40
        if xdg-open "$desktop_file"; then
            dialog --msgbox "Successfully installed $pkg. You should see your package folder in your home directory." 7 60
            xdg-open "$desktop_file"
        else
            dialog --msgbox "[!] Unable to execute $desktop_file. \(Error code: 3\)" 5 40
            show_menu
        fi
    else
        dialog --msgbox "[!] Unable to execute or find .desktop file in $search_dir. You may find it yourself. \(Error code: 4\)" 7 60
        dialog --msgbox "Files successfully extracted, but unable to execute." 5 40
        show_menu
    fi
}

function hlp() {
    dialog --msgbox "DPI stands for Debian Package Installer; it installs applications from Debian packages for you.\n\n1) Starts installation.\n2) This help screen.\n3) Exits DPI." 10 60
    show_menu
}

show_menu

