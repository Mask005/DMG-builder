#!/bin/bash

# Call user in terminal
    read -p "Drop input folder: " folder_path
    read -p "Do you want to encrypt the DMG? (y/n): " encrypt_dmg

    if [ "$encrypt_dmg" = "y" ]; then
        read -s -p "Enter password for DMG encryption: " encryption_password
    fi
    
# Variables
    # folder_path="/Users/maximerosette/Desktop/TESTFOLDER"
    # encrypt_dmg=y
    # encryption_password=""

# Extract the folder name from its path
folder_name="$(basename "$folder_path")"

# Get the parent folder of the path
parent_folder="$(dirname "$folder_path")"

# Set the DMG output path and name using the folder name variable
dmg_output_path="$parent_folder/$folder_name"

# Prompt for encryption and password options
if [ "$encrypt_dmg" = "y" ]; then
    encryption_type="AES-128"
else
    encryption_type="none"
fi

# Create the compressed DMG with optional encryption and the folder name as the volume name
if [ "$encryption_type" = "none" ]; then
    hdiutil create -volname "$folder_name" -srcfolder "$folder_path" -ov -format UDBZ -o "$dmg_output_path"
else
    echo -n $encryption_password | hdiutil create -encryption $encryption_type -stdinpass -volname "$folder_name" -srcfolder "$folder_path" -ov -format UDBZ -o "$dmg_output_path"
fi