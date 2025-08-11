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
    echo "Backing up existing config to $config_file.bak"
    cp "$config_file" "$config_file.bak"
else
    echo "tmux configuration file '$filename' does not exist in directory '$directory'. Creating now..."
    mkdir -p "$directory"
fi

# Installing TPM (tmux package manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Create/overwrite the tmux config file with the complete configuration
cat > "$config_file" << 'EOL'
# Created by Kunush
##### --- TPM Plugin Manager ---
# Load tmux plugin manager and essential plugins
set -g @plugin 'tmux-plugins/tpm'             # Tmux Plugin Manager (required)
set -g @plugin 'tmux-plugins/tmux-sensible'   # Sensible default settings
set -g @plugin 'christoomey/vim-tmux-navigator' # Seamless navigation between vim and tmux
set -g @plugin 'tmux-plugins/tmux-resurrect'  # Save/restore tmux sessions
set -g @plugin 'tmux-plugins/tmux-continuum'  # Automatic session saving

##### --- Terminal Settings ---
# Configure terminal compatibility and colors
set -g default-terminal "xterm-256color"      # Use 256-color terminal
set -ga terminal-overrides ',xterm*:Tc'       # Enable true color support
# Prevent OSC color query leaks over SSH (security)
set -g allow-passthrough off

##### --- Mouse & Navigation ---
set -g mouse on                  # Enable mouse support
setw -g mode-keys vi            # Use vi-style keybindings in copy mode
# Meta-key navigation between panes (Alt+arrow equivalent)
bind -n M-h select-pane -L      # Move left
bind -n M-l select-pane -R      # Move right
bind -n M-k select-pane -U      # Move up
bind -n M-j select-pane -D      # Move down
# Meta-key navigation between windows
bind -n M-j previous-window     # Previous window
bind -n M-k next-window         # Next window

##### --- Prefix Key ---
# Change the default prefix from Ctrl-b to Ctrl-a
unbind C-b                      # Unbind default prefix
set -g prefix C-a               # Set new prefix to Ctrl-a
bind C-a send-prefix            # Send prefix when pressed twice

##### --- Pane & Window Management ---
# Numbering starts at 1 instead of 0
set -g base-index 1             # Window numbering starts at 1
set -g pane-base-index 1        # Pane numbering starts at 1
set-option -g renumber-windows on # Keep window numbers sequential
# Split window bindings that preserve current directory
bind '"' split-window -v -c "#{pane_current_path}"  # Vertical split
bind % split-window -h -c "#{pane_current_path}"    # Horizontal split
# Pane joining commands
bind-key j command-prompt -p "Join pane from:" "join-pane -s :'%%'"
bind-key s command-prompt -p "Send pane to:" "join-pane -t :'%%'"

##### --- History ---
set -g history-limit 100000      # Increase scrollback buffer size

##### --- Status Bar ---
# Status bar design and configuration
set -g status on                # Enable status bar
set -g status-interval 1        # Update every second
set -g status-justify left      # Left-align status items
set -g status-style bg=black,fg=white # Status bar colors
set -g status-left-length 200   # Left status length
set -g status-right-length 200  # Right status length

# Left status section shows session name
set -g status-left "#[fg=blue,bold]#S #[fg=colour240]| "

# Right status shows date/time, VPN status, and network
set -g status-right "#[fg=colour240]| #[fg=white]%Y-%m-%d %H:%M #[fg=colour240]| #[fg=magenta,bold]VPN: #(ip -4 addr show tun0 2>/dev/null | awk '/inet/ {print $2}' | cut -d'/' -f1 || echo 'OFF') #[fg=colour240]| #[fg=cyan]ETH0: #(ip route get 1 2>/dev/null | awk '{print $7;exit}' || hostname -I | awk '{print $1}') #[fg=colour240]| #[fg=green]#h"

# Window tabs styling
set -g window-status-format "#[fg=colour240]|#[fg=white] #I:#W "          # Inactive window format
set -g window-status-current-format "#[fg=colour240]|#[fg=yellow,bold] #I:#W " # Active window format
set -g window-status-separator ""     # No separator between window tabs

##### --- Pane Borders ---
# Pane border styling
set -g pane-border-status off   # Don't show title in pane borders
set -g pane-border-style fg=colour240,bg=default # Inactive pane border color
set -g pane-active-border-style fg=green,bg=default # Active pane border color
set -g pane-border-lines single # Single-line borders

##### --- Copy Mode ---
# Vi-style copy mode keybindings
bind -T copy-mode-vi v send -X begin-selection          # Start selection
bind -T copy-mode-vi y send -X copy-selection           # Yank selection
bind -T copy-mode-vi r send -X rectangle-toggle         # Toggle rectangle mode
bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-selection-and-cancel # Mouse copy

##### --- Mouse Support ---
set -g mouse on          # Enable mouse for pane/window selection

##### --- Reload Config ---
# Reload configuration with prefix + r
bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

##### --- Session Persistence ---
set -g @continuum-restore 'on'  # Automatically restore sessions

##### --- Initialize TPM ---
# Run TPM to manage plugins (must be at bottom of file)
run '~/.tmux/plugins/tpm/tpm'
EOL

echo "tmux configuration has been set up in '$config_file'."
echo "You can now start tmux and press 'Prefix + I' (Ctrl-a I) to install the configured plugins."
