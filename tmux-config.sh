#!/bin/bash

# Check if tmux is installed

if command -v tmux &> /dev/null; then
    echo "tmux is already installed."
else
    echo "tmux is not installed. Installing now..."

    # Install tmux:
    sudo apt-get update
    sudo apt-get install -y tmux

    # Verify the installation
    if command -v tmux &> /dev/null; then
        echo "tmux is now installed."
    else
        echo "Installation of tmux failed. Please install tmux manually."
        exit 1
    fi
fi

# Checking if git is installed

if command -v git &> /dev/null; then
    echo "Git is already installed."
else
    echo "Git is not installed. Installing now..."

    # Installing git
    sudo apt-get update
    sudo apt-get install -y git

    # Verify the installation
    if command -v git &> /dev/null; then
        echo "Git is now installed."
    else
        echo "Installation of Git failed. Please install Git manually."
        exit 1
    fi
fi

# Checking tmux directory and config file
directory="$HOME/.config/tmux"
filename="tmux.conf"
config_file="$directory/$filename"

if [ -e "$config_file" ]; then
    echo "tmux configuration file '$filename' already exists in directory '$directory'."
else
    echo "tmux configuration file '$filename' does not exist in directory '$directory'. Creating now..."

    # Creating tmux directory and config file
    mkdir -p "$directory" && touch "$config_file"

    # Installing TPM (tmux package manager)
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

# Adding configuration to the tmux config file
cat <<EOL >> "$config_file"
# Lines to add to the configuration file

# Plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Theme
#set -g @plugin 'catppuccin/tmux'

# vim navigation for panels JHKL
set -g @plugin 'christoomy/vim-tmux-navigator' 

# Key Bindings
bind -n M-j previous-window # navigation between windows
bind -n M-k next-window # navigation between windows

# changing the prefix key
#unbind C-b 
#set -g prefix C-a 
#bind C-Space send-prefix 

# Mouse Support
set -g mouse on # Mouse Support

# Sending and receaving panels 
bind-key j command-prompt -p "Join pane from:" "join-pane -s :'%%'"
bind-key s command-prompt -p "Send pane to:" "join-pane -t :'%%'"

# Changing the editor to vi
setw -g mode-keys vi

# Start windows and panes at 1, not 0
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# Open panes in the current directory
bind '"' split-window -v -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"

run '~/.tmux/plugins/tpm/tpm'
EOL

echo "tmux configuration has been set up. Lines added to '$config_file'."
echo "You can now start tmux and press 'Ctrl-b' + 'I' to install the configured plugins."
