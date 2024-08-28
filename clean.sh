#!/bin/bash

# root check
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run this script as root or with sudo."
        exit 1
    fi
}
# update 
update_system() {
    echo "Updating the list of packages..."
    apt update -y
    echo "Upgrading installed packages..."
    apt upgrade -y
}
# Cleaning the apt cache
clean_apt_cache() {
    echo "Cleaning the apt cache..."
    apt clean
}
# Removing unused packages
remove_unused_packages() {
    echo "Removing unused packages..."
    apt autoremove -y
}
# Cleaning the temporary directory
clean_tmp() {
    echo "Cleaning the /tmp directory..."
    rm -rf /tmp/*
}
# Cleaning system logs older than 7 days
clean_logs() {
    echo "Cleaning logs older than 7 days..."
    find /var/log -type f -name "*.log" -mtime +7 -exec rm -f {} \;
}
# Removal of unnecessary files (e.g. core dump)
remove_core_dumps() {
    echo "Deleting core dump files..."
    find / -type f -name "core" -exec rm -f {} \;
}
# Clearing the thumbnail cache
clean_thumbnails_cache() {
    echo "Clearing the thumbnail cache..."
    rm -rf ~/.cache/thumbnails/*
}
# Log compression (optional)
compress_logs() {
    echo "Compressing system logs..."
    find /var/log -type f -name "*.log" -exec gzip {} \;
}
# The main function that does all the work
main() {
    check_root
    update_system
    clean_apt_cache
    remove_unused_packages
    clean_tmp
    clean_logs
    remove_core_dumps
    clean_thumbnails_cache
    compress_logs
    echo "Cleaning completed!"
}
# Calling the main function
main
