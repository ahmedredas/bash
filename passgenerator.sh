#!/bin/bash


usage() {
    echo "Usage: $0 [-l <length>] [-u] [-d] [-s] [-h]"
    echo "Options:"
    echo "  -l <length>   Specify the length of the password (default: 12)"
    echo "  -u            Include uppercase letters in the password"
    echo "  -d            Include digits in the password"
    echo "  -s            Include special characters in the password"
    echo "  -h            Display this help message"
    exit 1
}

# Default values
length=12
use_uppercase=false
use_digits=false
use_special_chars=false


while getopts ":l:udsh" opt; do
    case $opt in
        l) length="$OPTARG" ;;
        u) use_uppercase=true ;;
        d) use_digits=true ;;
        s) use_special_chars=true ;;
        h) usage ;;
        \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    esac
done


if [ "$use_uppercase" = false ] && [ "$use_digits" = false ] && [ "$use_special_chars" = false ]; then
    echo "Error: At least one complexity option (-u, -d, -s) must be enabled."
    usage
fi

# Function to generate a random password
generate_password() {
    local complexity_options=""
    
    if [ "$use_uppercase" = true ]; then
        complexity_options+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    fi

    if [ "$use_digits" = true ]; then
        complexity_options+="0123456789"
    fi

    if [ "$use_special_chars" = true ]; then
        complexity_options+="!@#$%^&*()-=_+[]{}|;:'\",.<>/?"
    fi

    tr -dc "$complexity_options" < /dev/urandom | head -c "$length"
}

password=$(generate_password)
echo "Generated Password: $password"
