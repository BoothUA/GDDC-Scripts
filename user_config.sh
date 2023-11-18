#!/bin/bash

# List of users
users=("cdo" "adminastrator" "scoring" "redteam" "notredteam" "blackteam" "notblackteam" "windmill" "solar" "nuclear" "gas" "hydro" "mdesocio" "mlanglois" "cfisher" "jborst" "jbadass" "boothbooth")

# Function to create users with home directories
create_users() {
    for user in "${users[@]}"; do
        if [[ "$user" != "cdo" ]]; then
            # Check if user already exists
            if id "$user" &>/dev/null; then
                echo "User $user already exists"
            else
                # Create user with home directory
                useradd -m "$user"
                echo "Created user: $user"
            fi
        fi
    done
}

# Function to create .ssh directory and change ownership
create_ssh_directory() {
    for user in "${users[@]}"; do
        if [[ "$user" != "cdo" ]]; then
            ssh_dir="/home/$user/.ssh"
            if [[ ! -d "$ssh_dir" ]]; then
                mkdir -p "$ssh_dir"
                chmod 700 "$ssh_dir"
                chown "$user:$user" "$ssh_dir"
                echo "Created .ssh directory and changed ownership for user: $user"
            else
                echo "User $user already has a .ssh directory"
            fi
        fi
    done
}

# Create users with home directories
create_users

# Create .ssh directory and change ownership for each user
create_ssh_directory
