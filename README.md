# Neovim Programming Configuration

A comprehensive Neovim setup optimized for multi-language development with LSP support, debugging, and modern tooling.

## Supported Languages

### C/C++
- **LSP**: `clangd` with advanced features
- **Formatter**: `clang_format`
- **Debugger**: GDB integration via nvim-dap
- **Syntax**: Treesitter

**Individual Setup:**
```bash
# Install clangd
sudo pacman -S clang  # Arch Linux
# or
sudo apt install clangd  # Ubuntu

# Install clang-format
sudo pacman -S clang
```

### Python
- **LSP**: `pyright`
- **Formatter**: LSP fallback
- **Syntax**: Treesitter

**Individual Setup:**
```bash
npm install -g pyright
```

### JavaScript/TypeScript
- **LSP**: `ts_ls` (TypeScript Language Server)
- **Formatter**: `prettier`
- **Syntax**: Treesitter

**Individual Setup:**
```bash
npm install -g typescript typescript-language-server prettier
```

### PHP
- **LSP**: `intelephense`
- **Formatter**: LSP formatting (intelephense)
- **Syntax**: Treesitter

**Individual Setup:**
```bash
npm install -g intelephense
```

### Lua
- **LSP**: `lua_ls`
- **Formatter**: LSP fallback
- **Syntax**: Treesitter

**Individual Setup:**
Mason will handle this automatically.

### Web Technologies
- **HTML/CSS/SCSS**: Prettier formatting, Treesitter syntax
- **JSON**: Prettier formatting, Treesitter syntax
- **Vue/Svelte**: Prettier formatting

## Key Bindings

### Leader Key
- **Leader**: `Space`

### File Management
- `Space + e` - Toggle file explorer (nvim-tree)
- `Space + ff` - Find files (Telescope)
- `Space + fg` - Live grep search (Telescope)  
- `Space + fb` - Find buffers (Telescope)

### Code Formatting
- `Space + f` - Format current buffer (PHP uses LSP, others use Prettier/clang-format)

### Window Navigation
- `Ctrl + h/j/k/l` - Move between windows (left/down/up/right)

### Buffer Navigation
- `Shift + l` - Next buffer
- `Shift + h` - Previous buffer

### LSP Features (Active when LSP attaches)
- `gd` - Go to definition
- `gr` - Find references
- `gI` - Go to implementation
- `K` - Hover documentation
- `gD` - Go to declaration
- `Space + D` - Type definition
- `Space + ds` - Document symbols
- `Space + ws` - Workspace symbols
- `Space + rn` - Rename symbol
- `Space + ca` - Code actions

### C++ Specific
- `F5` - Compile and run in external terminal
- `F6` - Run already compiled program
- `Space + cc` - Compile with debug info
- `Space + cr` - Run program

### Debugging (C++)
- `F9` - Toggle breakpoint
- `F10` - Step over
- `F11` - Step into
- `F12` - Step out
- `Space + dc` - Continue debugging
- `Space + du` - Toggle debug UI

### Terminal
- `Esc` (in terminal mode) - Exit terminal mode

### Editing
- `Space + h` - Clear search highlights
- `</>` (in visual mode) - Indent left/right while maintaining selection

## Installation Requirements

### Base Requirements
```bash
# Neovim (0.8+)
sudo pacman -S neovim  # Arch
# or
sudo snap install nvim --classic  # Ubuntu

# Node.js and npm (for language servers)
sudo pacman -S nodejs npm

# Git
sudo pacman -S git

# A Nerd Font for icons
# Download from: https://www.nerdfonts.com/
```

### Language-Specific Tools

#### C/C++
```bash
sudo pacman -S gcc clang gdb
```

#### Python
```bash
sudo pacman -S python python-pip
```

#### PHP
```bash
sudo pacman -S php
```

#### Formatters
```bash
npm install -g prettier
```

## Plugin Manager

This configuration uses **lazy.nvim** as the plugin manager. It will automatically install when you first start Neovim.

## Plugins Included

- **tokyonight.nvim** - Color scheme
- **nvim-tree.lua** - File explorer
- **telescope.nvim** - Fuzzy finder
- **nvim-treesitter** - Syntax highlighting
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP installer
- **nvim-cmp** - Autocompletion
- **conform.nvim** - Code formatting
- **nvim-dap** - Debugging support
- **lualine.nvim** - Status line
- **gitsigns.nvim** - Git integration
- **nvim-autopairs** - Auto-close brackets
- **Comment.nvim** - Easy commenting

## Setup Instructions

1. **Backup existing configuration:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Create new configuration:**
   ```bash
   mkdir -p ~/.config/nvim
   # Copy the configuration file to ~/.config/nvim/init.lua
   ```

3. **Start Neovim:**
   ```bash
   nvim
   ```
   
4. **Wait for plugins to install automatically**

5. **Restart Neovim and run `:checkhealth` to verify setup**

## Customization Notes

### Indentation
- Default: 4 spaces for all languages
- PHP follows PSR-12 standard (4 spaces)
- Modify the indentation section at the top of the config to change defaults

### Theme
- Uses Tokyo Night (moon variant) with transparency
- To change themes, modify the colorscheme section

### Additional Languages
To add support for new languages:

1. Add to Treesitter `ensure_installed` list
2. Add LSP to Mason `ensure_installed` list  
3. Configure the LSP in the lspconfig section
4. Add formatter to conform.nvim `formatters_by_ft`

## Troubleshooting

### LSP Not Working
- Run `:Mason` to check if language servers are installed
- Run `:LspInfo` to see active language servers
- Check `:checkhealth` for issues

### Formatting Not Working
- Ensure prettier is installed globally: `npm list -g prettier`
- Check conform.nvim log: `:ConformInfo`

### Performance Issues
- Run `:checkhealth` to identify problems
- Consider reducing Treesitter languages if not needed

## File Structure
```
~/.config/nvim/
└── init.lua  (main configuration file)
```
