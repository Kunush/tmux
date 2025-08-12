# Ultimate tmux Configuration Manager

![tmux logo](https://github.com/tmux/tmux/blob/master/logo/tmux-logo-small.png)  <br>   
*A complete solution for professional tmux setup*

## 🚀 Features

### 🔧 Automated Setup
- One-command installation of tmux + dependencies
- Automatic configuration of optimal settings
- TPM (Tmux Plugin Manager) installation

### 🎨 Enhanced Interface
- **Smart status bar** with:
  - VPN status monitoring (IP display)
  - Network interface tracking
  - System clock
  - Hostname visibility
- True color support (24-bit colors)
- Vi-style keybindings

### ⚡ Performance
- 100,000 line scrollback buffer
- Session persistence (auto-save/restore)
- Optimized pane/window management

## 📦 Installation

```bash
# Download and execute setup script
curl -L https://raw.githubusercontent.com/yourusername/tmux-config/main/setup_tmux.sh -o setup_tmux.sh
chmod +x setup_tmux.sh
./setup_tmux.sh
```
## 🚀 Fast Installation
```bash
curl https://raw.githubusercontent.com/Kunush/tmux/refs/heads/main/tmux-config.sh | sh
```

* * *

## 🔌 Included Plugins

| Plugin             | Description                                    |
|--------------------|------------------------------------------------|
| [TPM](https://github.com/tmux-plugins/tmux-sensible)                | Tmux Plugin Manager                              |
| [tmux-sensible](https://github.com/christoomey/vim-tmux-navigator)  | Seamless navigation between Vim and tmux panes   |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)    | Persists tmux environment across system restarts |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)    | Auto-save sessions at regular intervals          |

* * *

## ⌨️ Key Bindings

### Navigation

| Key                | Action                                  |
|--------------------|-----------------------------------------|
| `Ctrl-a`           | New prefix (replaces `Ctrl-b`)          |
| `Alt-arrow`        | Move between panes                      |
| `Alt-j/k`          | Previous/next window                    |


### Window Management

| Key                | Action                                  |
|--------------------|-----------------------------------------|
| `"`                | Split vertically                        |
| `%`                | Split horizontally                      |
| `Ctrl-a r`        | Reload tmux configuration                |


* * *

## 🖥️ Status Bar Preview

```bash
[work] | 2025-11-20 14:30 | VPN: 10.8.0.2 | ETH0: 192.168.1.100 | dev-server
```

*   **Blue**: Session name
    
*   **White**: Date/time
    
*   **Magenta**: VPN status
    
*   **Cyan**: Ethernet IP
    
*   **Green**: Hostname
    

* * *

## 🛠️ Customization

You can easily customize your setup by editing the configuration file: `~/.config/tmux/tmux.conf`

```bash
# Example: Change status bar colors
set -g status-style bg=colour235,fg=white

# Example: Add CPU monitoring with the tmux-cpu plugin
set -g @plugin 'tmux-plugins/tmux-cpu'
```

* * *

## ⚠️ Troubleshooting

### **VPN IP Not Showing**

The configuration relies on the `ip` command. Check your VPN interface by running:

```bash
ip -4 addr show tun0
```

### **Plugin Issues**

To reinstall all plugins, delete the `tpm` directory and run the `setup_tmux.sh` script again.

```bash
rm -rf ~/.tmux/plugins/tpm
```

* * *

## 📜 License

This project is licensed under the MIT License.

© 2025 [Kunush]


