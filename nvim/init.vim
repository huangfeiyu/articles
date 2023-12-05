call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'mfussenegger/nvim-jdtls'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'windwp/nvim-autopairs'
Plug 'ray-x/lsp_signature.nvim'
Plug 'folke/which-key.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
call plug#end()

" Enable line numbers
set number

" Enable syntax highlighting
syntax enable

" Enable auto-indentation and smart tab behavior
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamedplus
" Enable line wrapping
set wrap
packadd! matchit
" Enable relative line numbers (optional)
" set relativenumber

" Remap HOME key to work like ^
nnoremap <expr> <Home> col('.') == 1 ? '^' : "\<Home>"

nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
vnoremap <leader>rm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

" If using nvim-dap
" This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
nnoremap <leader>x :Telescope commands<CR>
inoremap <Home> <C-o>^

lua << EOF

-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_jdtls' },  -- Add Java language server source
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['jdtls'].setup {
    capabilities = capabilities
  }

  local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- This is your opts table
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  highlight = {
    enable = true,                -- Enable syntax highlighting
  },
}

require("nvim-treesitter.configs").setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,           -- Automatically jump forward to textobj, similar to targets.vim
    },
    move = {
      enable = true,
      set_jumps = true,           -- Whether to set jumps in the jumplist
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
-- Map to leader + t (you can change this according to your preference)
vim.api.nvim_set_keymap('x', '<leader>t', ':TSTextObjectSelect<CR>', { noremap = true, silent = true })
require("nvim-autopairs").setup {}
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

require("which-key").setup {}
require("nvim-dap-virtual-text").setup()
require('dapui').setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) - Remote",
    hostName = "localhost",
    port = 11550,
  },
}

-- Start or continue the debugging session
vim.api.nvim_set_keymap('n', '<F5>', "<Cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })

-- Stop the debugging session
vim.api.nvim_set_keymap('n', '<F4>', "<Cmd>lua require'dap'.disconnect(); require'dap'.close(); require'dapui'.close()<CR>", { noremap = true, silent = true })

-- Step over the next function call or statement
vim.api.nvim_set_keymap('n', '<F10>', "<Cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })

-- Step into the next function call or statement
vim.api.nvim_set_keymap('n', '<F11>', "<Cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })

-- Step out of the current function call
vim.api.nvim_set_keymap('n', '<F12>', "<Cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })

-- Toggle a breakpoint at the current line
vim.api.nvim_set_keymap('n', '<F9>', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })

-- Evaluate expression under the cursor
vim.api.nvim_set_keymap('n', '<Leader>de', "<Cmd>lua require'dap.ui.widgets'.hover()<CR>", { noremap = true, silent = true })

-- Restart debugging session
vim.api.nvim_set_keymap('n', '<Leader>dr', "<Cmd>lua require'dap'.run_last()<CR>", { noremap = true, silent = true })

-- Additional useful mappings
-- Open DAP REPL
vim.api.nvim_set_keymap('n', '<Leader>dr', "<Cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })

-- Close DAP REPL
vim.api.nvim_set_keymap('n', '<Leader>dq', "<Cmd>lua require'dap'.repl.close()<CR>", { noremap = true, silent = true })

-- Open/close DAP UI Widgets
vim.api.nvim_set_keymap('n', '<Leader>du', "<Cmd>lua require'dapui'.toggle()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>ch', '<Cmd>lua vim.lsp.buf.call_hierarchy()<CR>', { noremap = true, silent = true })

EOF
