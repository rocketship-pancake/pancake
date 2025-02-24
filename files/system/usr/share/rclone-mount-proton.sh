#!/bin/bash

set -e  # Exit immediately if a command fails

# Define remote name and mount point
REMOTENAME="proton"
MOUNTPOINT="$HOME/ProtonDrive"

# Function to check dependencies
check_dependencies() {
    for cmd in rclone keyring fusermount; do
        if ! command -v "$cmd" &>/dev/null; then
            echo "Error: Required command '$cmd' is not installed." >&2
            exit 1
        fi
    done
}

# Function to retrieve Rclone password
get_password() {
    PASSWORD=$(keyring get rclone "$REMOTENAME" 2>/dev/null)
    if [ -z "$PASSWORD" ]; then
        echo "Error: Rclone config password not found in keyring." >&2
        exit 1
    fi
    echo "$PASSWORD"
}

# Function to mount Proton Drive
mount_drive() {
    # Ensure dependencies are installed
    check_dependencies

    # Retrieve password
    export RCLONE_CONFIG_PASS=$(get_password)

    # Ensure mount point exists
    mkdir -p "$MOUNTPOINT"

    # Check if already mounted
    if mountpoint -q "$MOUNTPOINT"; then
        echo "Proton Drive is already mounted at $MOUNTPOINT."
        exit 0
    fi

    # Unmount in case of previous failed mount
    fusermount -u "$MOUNTPOINT" 2>/dev/null || true  # Ignore errors if it's not mounted

    # Use expect to enter the password automatically
    rclone mount $REMOTENAME: "$MOUNTPOINT" --vfs-cache-mode writes

    # Verify if mount was successful
    if mountpoint -q "$MOUNTPOINT"; then
        echo "Mount successful."
        exit 0
    else
        echo "Mount failed." >&2
        exit 1
    fi
}

# Function to unmount Proton Drive
unmount_drive() {
    if mountpoint -q "$MOUNTPOINT"; then
        fusermount -u "$MOUNTPOINT"
        echo "Proton Drive unmounted."
        exit 0
    else
        echo "Proton Drive is not mounted." >&2
        exit 1
    fi
}

# Function to show help
show_help() {
    echo "Usage: $0 {mount|unmount|status|help}"
    echo ""
    echo "Commands:"
    echo "  mount     Mount the Proton Drive"
    echo "  unmount   Unmount the Proton Drive"
    echo "  status    Check if the drive is mounted"
    echo "  help      Show this help message"
}

# Main script logic
case "$1" in
    mount)
        mount_drive
        ;;
    unmount)
        unmount_drive
        ;;
    status)
        if mountpoint -q "$MOUNTPOINT"; then
            echo "Proton Drive is mounted at $MOUNTPOINT."
            exit 0
        else
            echo "Proton Drive is not mounted."
            exit 1
        fi
        ;;
    -h|--help|help)
        show_help
        exit 0
        ;;
    *)
        echo "Error: Invalid command. Use '$0 help' for usage information." >&2
        exit 1
        ;;
esac