#!/bin/bash

# Prompt the user for the repository URL
read -p "Enter the repository URL: " REPO_URL

# Prompt the user for the desired script name
read -p "Enter the desired script name (e.g., myscript.sh): " SCRIPT_NAME

# Prompt the user for the alias name
read -p "Enter the alias name (what you want to enter into CLI to launch): " ALIAS_NAME

# Extract repository name from the URL
REPO_NAME=$(basename $REPO_URL .git)

# Get the current username
username=$(whoami)

# Clone the repository
git clone $REPO_URL && \
cd $REPO_NAME && \

# Get the full path to the cloned directory
full_path=$(pwd) && \

# Example to install necessary dependencies
# sudo apt-get update && sudo apt-get install -y xclip && \

# Make the script executable
chmod +x "$SCRIPT_NAME" && \

# Example if need to modify the script to use the current directory
# sed -i 's|current_dir_tracker=$(pwd)|current_dir_tracker=$(pwd -P)|g' "$SCRIPT_NAME" && \

# Add the alias to .bashrc if it doesn't already exist
if ! grep -q "alias $ALIAS_NAME=" ~/.bashrc; then \
  echo 'alias '"$ALIAS_NAME"'="'"$full_path"'/'"$SCRIPT_NAME"'"' >> ~/.bashrc; \
fi && \

# Reload .bashrc to apply the new alias
source ~/.bashrc && \

# Final message
echo "Installation complete. You can now use '$ALIAS_NAME' to run the $REPO_NAME script from anywhere."
