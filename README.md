# Neovim Programming Configuration

A comprehensive Neovim setup optimized for multi-language development with LSP support, debugging capabilities, and modern tooling. Designed for C++, PHP, Python, JavaScript/TypeScript, and web development.

## Features

- **Multi-language LSP support** with auto-completion
- **Integrated debugging** for C++ (GDB) and PHP (Xdebug)
- **Smart code formatting** with language-specific formatters
- **Fuzzy finding** and project navigation
- **Git integration** with visual indicators
- **Tree-sitter** syntax highlighting
- **File explorer** with icons
- **Transparent theme** (GitHub Dark)

## Supported Languages

| Language | LSP | Formatter | Debugger | Syntax |
|----------|-----|-----------|----------|--------|
| C/C++ | clangd | clang-format | GDB | Treesitter |
| PHP | intelephense | Intelephense LSP | Xdebug | Treesitter |
| Python | pyright | LSP fallback | - | Treesitter |
| JavaScript/TypeScript | ts_ls | prettier | - | Treesitter |
| HTML/CSS | - | prettier | - | Treesitter |
| Lua | lua_ls | - | - | Treesitter |

## Installation

### Prerequisites

**Required:**
```bash
# Arch Linux
sudo pacman -S neovim git nodejs npm gcc gdb

# Ubuntu/Debian
sudo apt install neovim git nodejs npm gcc gdb

# Verify Neovim version (0.8+ required)
nvim --version
```

### Terminal Setup (Recommended: Kitty)

Kitty is the recommended terminal for this config due to its performance and proper color support.

**Install Kitty:**
```bash
# Arch Linux
sudo pacman -S kitty

# Ubuntu/Debian
sudo apt install kitty

# macOS
brew install kitty
```

**Configure Kitty** (`~/.config/kitty/kitty.conf`):
```conf
# Font configuration - JetBrains Mono + Nerd Font symbols fallback
font_family JetBrains Mono
bold_font JetBrains Mono Bold
italic_font JetBrains Mono Italic
bold_italic_font auto
font_size 14.0

# Add Nerd Font symbols as fallback
symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+F8FF Symbols Nerd Font

# GitHub Dark color scheme
foreground #e6edf3
background #0f0f0f

# Cursor colors
cursor #58a6ff
cursor_text_color #0d1117

# Selection colors
selection_foreground #0d1117
selection_background #58a6ff

# Normal colors
color0 #484f58
color1 #ff7b72
color2 #3fb950
color3 #d29922
color4 #58a6ff
color5 #bc8cff
color6 #39c5cf
color7 #b1bac4

# Bright colors
color8 #6e7681
color9 #ffa198
color10 #56d364
color11 #e3b341
color12 #79c0ff
color13 #d2a8ff
color14 #56d4dd
color15 #f0f6fc

# Window settings
background_opacity 0.9
hide_window_decorations yes
remember_window_size yes
initial_window_width 80c
initial_window_height 24c

# Padding
window_padding_width 10

# Performance and features
repaint_delay 10
input_delay 3
sync_to_monitor yes
```

**Install a Nerd Font** (required for icons):
```bash
# Download from: https://www.nerdfonts.com/
# Recommended: JetBrainsMono Nerd Font or FiraCode Nerd Font

# Arch Linux (via AUR)
yay -S ttf-jetbrains-mono-nerd

# Or manually:
# 1. Download from nerdfonts.com
# 2. Extract to ~/.local/share/fonts/
# 3. Run: fc-cache -fv
```

### Alternative Terminals

If you prefer other terminals, here are basic configurations:

**Alacritty** (`~/.config/alacritty/alacritty.yml`):
```yaml
font:
  normal:
    family: JetBrainsMono Nerd Font
  size: 12.0

window:
  opacity: 0.95

colors:
  primary:
    background: '#0d1117'
    foreground: '#c9d1d9'
```

**GNOME Terminal:**
1. Install a Nerd Font
2. Edit → Preferences → Profile → Colors
3. Use transparency and dark theme
4. Set custom font to your installed Nerd Font

**Windows Terminal** (`settings.json`):
```json
{
  "profiles": {
    "defaults": {
      "font": {
        "face": "JetBrainsMono Nerd Font",
        "size": 12
      },
      "opacity": 95,
      "useAcrylic": true
    }
  }
}
```

### Install Neovim Configuration

1. **Backup existing configuration:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone or copy this configuration:**
   ```bash
   mkdir -p ~/.config/nvim
   # Copy init.lua to ~/.config/nvim/init.lua
   ```

3. **Start Neovim:**
   ```bash
   nvim
   ```

4. **Wait for plugins to install automatically** (lazy.nvim will bootstrap and install everything)

5. **Restart Neovim and verify setup:**
   ```vim
   :checkhealth
   ```

### Language-Specific Setup

#### C/C++ Development
```bash
# Arch Linux
sudo pacman -S clang gdb

# Ubuntu/Debian
sudo apt install clang gdb clangd
```

#### PHP Development with Xdebug
```bash
# Install PHP and Xdebug
sudo pacman -S php xdebug  # Arch
# or
sudo apt install php php-xdebug  # Ubuntu

# Configure Xdebug (add to /etc/php/php.ini)
sudo nvim /etc/php/php.ini
```

Add at the end of `php.ini`:
```ini
[xdebug]
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.start_with_request=yes
xdebug.client_port=9003
```

Verify Xdebug is loaded:
```bash
php -m | grep xdebug
```

#### Python Development
```bash
sudo pacman -S python python-pip
```

#### JavaScript/TypeScript Development
```bash
npm install -g typescript typescript-language-server prettier
```

## Complete Keybindings Reference

### Leader Key
- **Leader**: `Space`

### File Management
| Key | Action |
|-----|--------|
| `Space + e` | Toggle file explorer (nvim-tree) |
| `Space + ff` | Find files (Telescope) |
| `Space + fg` | Live grep search (Telescope) |
| `Space + fb` | Find buffers (Telescope) |

### Window Navigation
| Key | Action |
|-----|--------|
| `Ctrl + h` | Move to left window |
| `Ctrl + j` | Move to bottom window |
| `Ctrl + k` | Move to top window |
| `Ctrl + l` | Move to right window |

### Buffer Navigation
| Key | Action |
|-----|--------|
| `Shift + l` | Next buffer |
| `Shift + h` | Previous buffer |

### Editing
| Key | Action |
|-----|--------|
| `Space + h` | Clear search highlights |
| `<` (visual mode) | Indent left (maintains selection) |
| `>` (visual mode) | Indent right (maintains selection) |

### Code Formatting
| Key | Action |
|-----|--------|
| `Space + f` | Format current buffer |

### LSP Features (Active when LSP attaches)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `Space + D` | Type definition |
| `Space + ds` | Document symbols |
| `Space + ws` | Workspace symbols |
| `Space + rn` | Rename symbol |
| `Space + ca` | Code actions |

### Documentation Generation
| Key | Action |
|-----|--------|
| `Space + d` | Generate documentation |
| `Space + df` | Generate function documentation |
| `Space + d0` | Generate class documentation |

### C++ Specific
| Key | Action |
|-----|--------|
| `F5` | Compile and run with debug symbols |
| `F6` | Run already compiled program |
| `Space + cc` | Compile with debug info only |
| `Space + cr` | Run compiled program |
| `Space + cm` | Compile with AddressSanitizer (memory leak detection) |

### Debugging (C++ and PHP)
| Key | Action |
|-----|--------|
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `Space + dc` | Start/Continue debugging |
| `Space + du` | Toggle debug UI |
| `Space + dr` | Open debug REPL |

### Code Snippets
| Key | Action |
|-----|--------|
| `Space + html` | Insert HTML5 boilerplate |
| `Space + af` | Insert arrow function template |

### Terminal
| Key | Action |
|-----|--------|
| `Esc` (in terminal mode) | Exit terminal mode to normal mode |

## Debugging Workflows

### C++ Debugging
1. Compile with debug symbols: `F5` or `Space + cc`
2. Set breakpoints: `F9` on desired lines
3. Start debugger: `Space + dc`
4. When prompted, enter path to executable (e.g., `./myprogram`)
5. Use `F10` (step over), `F11` (step into), `F12` (step out)
6. Hover over variables to inspect values

### PHP Debugging (Xdebug)
1. Ensure Xdebug is installed and configured
2. Open your PHP file in Neovim
3. Set breakpoints: `F9` on desired lines
4. Start debugger listening: `Space + dc`
5. Run your PHP script: `php script.php` (CLI) or visit page in browser (web)
6. Debugger will pause at breakpoints
7. Use `F10`, `F11`, `F12` to step through code

### Memory Leak Detection (C++)
1. Compile with AddressSanitizer: `Space + cm`
2. Run the program
3. AddressSanitizer will report any memory leaks with exact line numbers

## Plugins Included

- **lazy.nvim** - Plugin manager (auto-installs on first run)
- **github-nvim-theme** - Color scheme
- **dashboard-nvim** - Start screen
- **nvim-tree.lua** - File explorer
- **telescope.nvim** - Fuzzy finder
- **nvim-treesitter** - Syntax highlighting
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/tool installer
- **mason-lspconfig.nvim** - LSP integration
- **nvim-cmp** - Autocompletion
- **LuaSnip** - Snippet engine
- **conform.nvim** - Code formatting
- **nvim-dap** - Debug Adapter Protocol
- **nvim-dap-ui** - Debug UI
- **nvim-dap-virtual-text** - Inline variable values during debugging
- **lualine.nvim** - Status line
- **gitsigns.nvim** - Git integration
- **nvim-autopairs** - Auto-close brackets
- **Comment.nvim** - Easy commenting
- **neogen** - Documentation generation

## Customization

### Change Indentation
Edit the indentation section in `init.lua`:
```lua
vim.opt.tabstop = 4      -- Change to your preference
vim.opt.shiftwidth = 4   -- Should match tabstop
vim.opt.softtabstop = 4  -- Should match tabstop
```

### Change Theme
Replace the colorscheme section with another theme:
```lua
{
  'folke/tokyonight.nvim',
  config = function()
    vim.cmd('colorscheme tokyonight-night')
  end,
}
```

### Add Language Support
1. Add to Treesitter `ensure_installed`
2. Add LSP to Mason `ensure_installed`
3. Configure the LSP in lspconfig section
4. Add formatter to conform.nvim

### Disable Transparency
In the theme config, change:
```lua
transparent = false,  -- Change from true
```

## Troubleshooting

### LSP Not Working
```vim
:Mason          " Check if language servers are installed
:LspInfo        " See active language servers
:checkhealth    " Comprehensive health check
```

### Icons Not Showing
- Verify you have a Nerd Font installed
- Check your terminal is using the Nerd Font
- Run: `fc-list | grep -i "nerd"`

### Debugging Not Working

**C++:**
- Ensure GDB is installed: `gdb --version`
- Compile with `-g` flag (done automatically with `F5`)

**PHP:**
- Verify Xdebug is loaded: `php -m | grep xdebug`
- Check Xdebug port: `php -i | grep xdebug.client_port`
- Start debugger BEFORE running PHP script

### Performance Issues
- Run `:checkhealth` to identify problems
- Reduce Treesitter languages if not needed
- Disable unused plugins

### Mason Installation Failures
```bash
# Ensure Node.js and npm are installed and up to date
node --version
npm --version

# Clear Mason cache
rm -rf ~/.local/share/nvim/mason
```

## File Structure
```
~/.config/nvim/
└── init.lua  (main configuration file)
```

## Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason Registry](https://mason-registry.dev/)
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)

## Credits

Built with modern Neovim plugins and configured for an optimal development experience across multiple languages.
