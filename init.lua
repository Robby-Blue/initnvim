vim.cmd [[packadd packer.nvim]]

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"

vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true

vim.g.mapleader = " "

-- files
vim.api.nvim_set_keymap('n', '<leader>ff', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
-- find name
vim.api.nvim_set_keymap('n', '<leader>fn', ':Telescope git_files<CR>', {noremap = true, silent = true})
-- find text
vim.api.nvim_set_keymap('n', '<leader>ft', ':Telescope live_grep<CR>', {noremap = true, silent = true})

-- git
vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', {noremap = true, silent = true})
-- barbar
vim.api.nvim_set_keymap('n', '<leader>,', ':BufferPrevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>.', ':BufferNext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader><backspace><CR>', ':BufferClose<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader><backspace><backspace><CR>', ':BufferCloseAllButCurrent<CR>', {noremap = true, silent = true})

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {'nvim-tree/nvim-web-devicons'},
        config = function() require'nvim-tree'.setup {} end
    }

    -- use {
    --     'catppuccin/nvim',
    --     as = 'catppuccin',
    --     config = function() vim.cmd('colorscheme catppuccin-mocha') end
    -- }

    use {
        'Mofiqul/vscode.nvim',
        config = function() vim.cmd('colorscheme vscode') end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "query", "python", "javascript"
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                }
            })
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = {'nvim-lua/plenary.nvim'}
    }

    -- use {
    --     'dyng/ctrlsf.vim',
    --     as="CtrlSF"
    -- }

    -- use {
    --     '~/example_plugin'
    -- }

    -- use {
    --     'mhinz/vim-grepper',
    --     config = function()
    --     end
    -- }

    -- use {
    --     'Shougo/denite.nvim',
    --     requires = {
    --         'roxma/nvim-yarp',
    --         'roxma/vim-hug-neovim-rpc'
    --     },
    --     config = function()
    --         vim.call('denite#custom#var', 'file/rec', 'command', {'rg', '--files', '--glob', '!.git'})
    --         vim.call('denite#custom#var', 'grep', 'command', {'rg'})

    --         local denite_options = {
    --             default = {
    --               split = 'floating',
    --               start_filter = 1,
    --               auto_resize = 1,
    --               source_names = 'short',
    --               prompt = 'λ ',
    --               highlight_matched_char = 'QuickFixLine',
    --               highlight_matched_range = 'Visual',
    --               highlight_window_background = 'Visual',
    --               highlight_filter_background = 'DiffAdd',
    --               winrow = 1,
    --               vertical_preview = 1
    --             }
    --           }

    --         for fname, opt in pairs(denite_options) do
    --             for dopt, value in pairs(opt) do
    --               vim.call('denite#custom#option', fname, dopt, value)
    --             end
    --           end
    --     end
    -- }

    use {'kdheepak/lazygit.nvim', requires = {'nvim-lua/plenary.nvim'}}

    use {
        'romgrk/barbar.nvim',
        requires = {'nvim-tree/nvim-web-devicons', 'lewis6991/gitsigns.nvim'},
        config = function()
            require("barbar").setup({
                sidebar_filetypes = {['NvimTree'] = {event = 'BufWipeout'}}
            })
        end
    }

    use({
        'MeanderingProgrammer/markdown.nvim',
        as = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        after = { 'nvim-treesitter' },
        requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
        -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
        -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
        config = function()
            require('render-markdown').setup({})
        end,
    })

    -- use {
    --     "neovim/nvim-lspconfig",
    --     requires = {
    --         "hrsh7th/nvim-cmp",
    --         "hrsh7th/cmp-nvim-lsp", -- use suggestions from the LSP
    --         -- "L3MON4D3/LuaSnip", -- snippet engine
    --         -- "saadparwaiz1/cmp_luasnip" -- adapter for the snippet engine
    --     },
    --     config = function()
    --         local cmp = require("cmp")
    --         cmp.setup({
    --             -- snippet = {
    --             --     expand = function(args)
    --             --         require("luasnip").lsp_expand(args.body)
    --             --     end
    --             -- },
    --             mapping = cmp.mapping.preset.insert({
    --                 ["<CR>"] = cmp.mapping.confirm({select = true}), -- true = autoselect first entry
    --                 ["<Tab>"] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_next_item()
    --                     else
    --                         fallback()
    --                     end
    --                 end, {"i", "s"}),
    --                 ["<S-Tab>"] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_prev_item()
    --                     else
    --                         fallback()
    --                     end
    --                 end, {"i", "s"}),
    --                 ["<C-i>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    --                 ["<C-e>"] = cmp.mapping({
    --                     i = cmp.mapping.abort(),
    --                     c = cmp.mapping.close()
    --                 })
    --             }),
    --             sources = {
    --                 {name = 'nvim_lsp'}, {name = 'luasnip'}
    --                 -- More sources can be added here
    --             }
    --         })

    --         -- LSP settings to use nvim-cmp
    --         local capabilities = require('cmp_nvim_lsp').default_capabilities()
    --         require('lspconfig')['pyright'].setup {capabilities = capabilities}
    --         -- Additional LSP server setups can go here
    --     end
    -- }

    -- use {
    --     'NeogitOrg/neogit',
    --     requires = {
    --       'nvim-lua/plenary.nvim',
    --       'sindrets/diffview.nvim',
    --       'nvim-telescope/telescope.nvim'
    --     },
    --     config = function()
    --         require("neogit").setup{}
    --     end
    -- }

    -- use {
    --   'neovim/nvim-lspconfig',
    --   requires = {
    --       {'williamboman/mason.nvim'},
    --       {'williamboman/mason-lspconfig.nvim'},
    --       {'hrsh7th/nvim-cmp'},
    --       {'hrsh7th/cmp-nvim-lsp'},
    --   },
    --   config = function()
    --       require('mason').setup()

    --       require('mason-lspconfig').setup {
    --           ensure_installed = {"pyright"},
    --       }

    --       local cmp = require('cmp')
    --       local cmp_nvim_lsp = require('cmp_nvim_lsp')

    --       local capabilities = vim.lsp.protocol.make_client_capabilities()
    --       capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    --       vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    --           vim.lsp.diagnostic.on_publish_diagnostics, {
    --               update_in_insert = true,
    --           }
    --       )

    --       require('lspconfig').pyright.setup {
    --           capabilities = capabilities,
    --       }
    --   end
    --   }

    if packer_bootstrap then require('packer').sync() end
end)
