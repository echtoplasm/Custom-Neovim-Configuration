-- Basic Neovim Configuration for Programming

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Show relative line numbers
vim.opt.mouse = 'a'               -- Enable mouse
vim.opt.showmode = false          -- Don't show mode since we have statusline
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.breakindent = true        -- Enable break indent
vim.opt.undofile = true           -- Save undo history
vim.opt.ignorecase = true         -- Case insensitive searching
vim.opt.smartcase = true          -- Case sensitive if uppercase present
vim.opt.signcolumn = 'yes'        -- Keep signcolumn on by default
vim.opt.updatetime = 250          -- Decrease update time
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect' -- Better completion experience
vim.opt.termguicolors = true             -- Enable 24-bit RGB colors

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
    -- Colorscheme
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                options = {
                    -- Compiled file's destination location
                    compile_path = vim.fn.stdpath('cache') .. '/github-theme',
                    compile_file_suffix = '_compiled', -- Compiled file suffix
                    hide_end_of_buffer = true,         -- Hide the '~' character at the end of the buffer for a cleaner look
                    hide_nc_statusline = true,         -- Override the underline style for non-active statuslines
                    transparent = true,                -- Disable setting bg (make neovim's background transparent)
                    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                    dim_inactive = false,              -- Non focused panes set to alternative background
                    module_default = true,             -- Default enable value for modules
                    styles = {                         -- Style to be applied to different syntax groups
                        comments = 'NONE',             -- Value is any valid attr-list value `:help attr-list`
                        functions = 'NONE',
                        keywords = 'NONE',
                        variables = 'NONE',
                        conditionals = 'NONE',
                        constants = 'NONE',
                        numbers = 'NONE',
                        operators = 'NONE',
                        strings = 'NONE',
                        types = 'NONE',
                    },
                    inverse = { -- Inverse highlight for different types
                        match_paren = false,
                        visual = false,
                        search = false,
                    },
                    darken = { -- Darken floating windows and sidebar-like windows
                        floats = true,
                        sidebars = {
                            enable = true,
                            list = {}, -- Apply dark background to specific windows
                        },
                    },
                    modules = { -- List of various plugins and additional options
                        -- ...
                    },
                },
                palettes = {},
                specs = {},
                groups = {},
            })

            vim.cmd('colorscheme github_dark_default')
        end,
    },

    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            local logo = [[
⠀⠀⠀⠀⠀⠀⠀⣠⡤⠶⡄⠀⠀⠀⠀⠀⠀⠀⢠⠶⣦⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣴⣿⡟⠀⠈⣀⣾⣝⣯⣿⣛⣷⣦⡀⠀⠈⢿⣿⣦⡀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣿⣿⡇⠀⢼⣿⣽⣿⢻⣿⣻⣿⣟⣷⡄⠀⢸⣿⣿⣾⣄⠀⠀⠀
⠀⠀⣞⣿⣿⣿⣿⣷⣤⣸⣟⣿⣿⣻⣯⣿⣿⣿⣿⣀⣴⣿⣿⣿⣿⣯⣆⠀⠀
⠀⡼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿=⣿⣿⣿=⣿⣿⣿⣿⣿⣿⣿⣿⣿⣜⡆⠀
⢠⣟⣯⣿⣿⣿⣷⢿⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣟⠿⣿⣿⣿⣿⡷⣾⠀
⢸⣯⣿⣿⡏⠙⡇⣾⣟⣿⡿⢿⣿⣿⣿⣿⣿⢿⣟⡿⣿⠀⡟⠉⢹⣿⣿⢿⡄
⢸⣯⡿⢿⠀⠀⠱⢈⣿⢿⣿⡿⣏⣿⣿⣿⣿⣿⣿⣿⣿⣀⠃⠀⢸⡿⣿⣿⡇
⢸⣿⣇⠈⢃⣴⠟⠛⢉⣸⣇⣹⣿⣿⠚⡿⣿⣉⣿⠃⠈⠙⢻⡄⠎⠀⣿⡷⠃
⠈⡇⣿⠀⠀⠻⣤⠠⣿⠉⢻⡟⢷⣝⣷⠉⣿⢿⡻⣃⢀⢤⢀⡏⠀⢠⡏⡼⠀
⠀⠘⠘⡅⠀⣔⠚⢀⣉⣻⡾⢡⡾⣻⣧⡾⢃⣈⣳⢧⡘⠤⠞⠁⠀⡼⠁⠀⠀
⠀⠀⠀⠸⡀⠀⢠⡎⣝⠉⢰⠾⠿⢯⡘⢧⡧⠄⠀⡄⢻⠀⠀⠀⢰⠁⠀⠀⠀
⠀⠀⠀⠀⠁⠀⠈⢧⣈⠀⠘⢦⠀⣀⠇⣼⠃⠰⣄⣡⠞⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢤⠼⠁⠀⠀⠳⣤⡼⠀⠀⠀⠀⠀⠀
    ]]
            logo = string.rep("\n", 2) .. logo .. "\n\n"

            require('dashboard').setup({
                theme = 'doom',
                config = {
                    header = vim.split(logo, "\n"),
                    center = {
                        {
                            icon = " ",
                            icon_hl = "Title",
                            desc = "Find File           ",
                            desc_hl = "String",
                            key = "f",
                            keymap = "SPC f f",
                            key_hl = "Number",
                            action = "lua print(2)"
                        },
                        {
                            icon = " ",
                            desc = "New file            ",
                            key = "n",
                            keymap = "SPC f n",
                            action = "enew"
                        },
                        {
                            icon = " ",
                            desc = "Recent files        ",
                            key = "r",
                            keymap = "SPC f r",
                            action = "lua print(3)"
                        },
                        {
                            icon = " ",
                            desc = "Config              ",
                            key = "c",
                            keymap = "SPC f c",
                            action = "lua print(4)"
                        },
                        {
                            icon = " ",
                            desc = "Quit Neovim         ",
                            key = "q",
                            keymap = "SPC q",
                            action = "qa"
                        },
                    },
                    footer = function()
                        return { "Abandon All Hope Ye Who Enter Here" }
                    end,
                }
            })
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup()
        end,
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup()
        end,
    },

    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require('neogen').setup({
                enabled = true,
                input_after_comment = true, -- Enter insert mode after generating
                languages = {
                    javascript = {
                        template = {
                            annotation_convention = "jsdoc" -- or "tsdoc"
                        }
                    },
                    typescript = {
                        template = {
                            annotation_convention = "tsdoc" -- or "jsdoc"
                        }
                    }
                }
            })
        end,
    },



    -- Treesitter for syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "json", "sql", "cpp", "c", "php" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- LSP Support
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "clangd", "intelephense", "ts_ls" }
            })

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true
                },
            })


            lspconfig.intelephense.setup({
                settings = {
                    intelephense = {
                        files = {
                            maxSize = 1000000,
                        },
                        completion = {
                            fullyQualifyGlobalConstantsAndFunctions = true,
                        },
                    },
                },
            })
            lspconfig.ts_ls.setup({})
        end,
    },

    -- C++ Debugging
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- C++ debugging configuration
            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = '/usr/bin/gdb',
                args = {}
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = true,
                },
            }

            dapui.setup()

            -- Debug keymaps
            vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle debug UI" })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
            })
        end,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end,
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- Comment toggling
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    -- Code formatting
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    html = { 'prettier' },
                    css = { 'prettier' },
                    scss = { 'prettier' },
                    javascript = { 'prettier' },
                    typescript = { 'prettier' },
                    json = { 'prettier' },
                    vue = { 'prettier' },
                    svelte = { 'prettier' },
                    cpp = { 'clang_format' },
                    c = { 'clang_format' },
                    php = { 'prettier' },
                    sql = { 'pg_format' }
                },
                formatters = {
                    prettier = {
                        prepend_args = { '--config-precedence', 'prefer-file', '--parser', 'php' },
                    },
                },
            })

            -- Manual formatting keybind
            vim.keymap.set('n', '<leader>f', function()
                local filetype = vim.bo.filetype
                if filetype == 'php' then
                    vim.lsp.buf.format({ timeout_ms = 2000 })
                else
                    require('conform').format({ lsp_fallback = true })
                end
            end, { desc = 'Format buffer' })
        end,
    }
})

-- Key mappings
local keymap = vim.keymap.set

-- Terminal mode escape
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- File explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Clear search highlights
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better indenting
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- C++ compilation and execution
keymap("n", "<F5>",
    ":w<CR>:!alacritty -e bash -c 'g++ -std=c++17 -Wall -Wextra -O2 -o %:r % && ./%:r && echo && echo Press ENTER to exit && read'<CR>",
    { desc = "Compile and run C++" })
keymap("n", "<F6>", ":!./%:r<CR>", { desc = "Run compiled C++ program" })
keymap("n", "<leader>cc", ":w<CR>:!g++ -std=c++17 -Wall -Wextra -g -o %:r %<CR>",
    { desc = "Compile C++ with debug info" })
keymap("n", "<leader>cr", ":!./%:r<CR>", { desc = "Run C++ program" })

--HTML boilerplate
vim.keymap.set('n', '<leader>html', function()
    local lines = {
        '<!DOCTYPE html>',
        '<html lang="en">',
        '<head>',
        '    <meta charset="UTF-8">',
        '    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
        '    <title>Document</title>',
        '</head>',
        '<body>',
        '    ',
        '</body>',
        '</html>'
    }
    vim.api.nvim_put(lines, 'l', true, true)
    -- Position cursor in body
    vim.api.nvim_win_set_cursor(0, { 9, 4 })
end)

vim.keymap.set('n', '<leader>af', function()
    local lines = {
        'const sumFunc = () => {}'
    }
    vim.api.nvim_put(lines, 'l', true, false)

    -- Find and position between parentheses
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_get_current_line()
    local paren_pos = line:find('%(%)')                    -- finds "()"
    if paren_pos then
        vim.api.nvim_win_set_cursor(0, { row, paren_pos }) -- between the ()
    end
end)                                                       --JSdoc keymaps
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>d", ":lua require('neogen').generate()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>df", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>dc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)

-- LSP keymaps (set up when LSP attaches)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            keymap('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
        map('gr', require('telescope.builtin').lsp_references, 'Goto References')
        map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    end,
})

-- Add Node.js and npm to PATH for Mason
if vim.fn.has('win32') == 1 then
    vim.env.PATH = 'C:\\nvm4w\\nodejs;C:\\Users\\zacha\\AppData\\Roaming\\npm;' .. vim.env.PATH
end
