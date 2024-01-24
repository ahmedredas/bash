#!/bin/bash


WARP_EMAIL="your_email@example.com"
THM_USERNAME="your_thm_username"
THM_PASSWORD="your_thm_password"

# Function to display script usage
usage() {
    echo "Usage: $0 -w <warp_email> -t <thm_username> -p <thm_password>"
    exit 1
}

# Parse command-line arguments
while getopts ":w:t:p:" opt; do
    case $opt in
        w) WARP_EMAIL="$OPTARG" ;;
        t) THM_USERNAME="$OPTARG" ;;
        p) THM_PASSWORD="$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    esac
done

# Function to connect to Warp
connect_warp() {
    echo "Connecting to Warp..."
    warp-cli quick-connect
    sleep 5 # Adjust sleep time as needed

    # Check if an IP has been assigned
    warp_ip=$(curl -s ifconfig.me)
    if [ -n "$warp_ip" ]; then
        echo "Warp connected. Assigned IP: $warp_ip"
    else
        echo "Error: Warp connection failed. Exiting."
        exit 1
    fi
}

# Function to connect to THM using OpenVPN
connect_thm() {
    echo "Connecting to THM using OpenVPN..."
    openvpn --config /path/to/thm.ovpn --daemon

    # Wait for the connection to be established
    sleep 10 # Adjust sleep time as needed

    # Check if an IP has been assigned
    thm_ip=$(curl -s ifconfig.me)
    if [ -n "$thm_ip" ]; then
        echo "THM OpenVPN connected. Assigned IP: $thm_ip"
    else
        echo "Error: THM OpenVPN connection failed. Exiting."
        exit 1
    fi

    
    ping -c 3 10.10.10.10
}

# Function to disconnect from Warp
disconnect_warp() {
    echo "Disconnecting from Warp..."
    warp-cli disconnect
}

# Main script execution
connect_warp
connect_thm
disconnect_warp

echo "completed successfully."
