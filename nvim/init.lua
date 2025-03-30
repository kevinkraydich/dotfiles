----- START OPTIONS -----

local opt = vim.opt

-- Disable default Vim startup message
opt.shortmess:append('I')

--[[
    This enables relative line numbering mode. With both number and
    relativenumber enabled, the current line shows the true line number, while
    all other lines (above and below) are numbered relative to the current line.
    This is useful because you can tell, at a glance, what count is needed to
    jump up or down to a particular line, by {count}k to go up or {count}j to go
    down.
--]]
opt.relativenumber = true
opt.number         = true
 
-- Always show the status line at the bottom, even if you only have one window open.
opt.laststatus = 2

--[[
    The backspace key has slightly unintuitive behavior by default. For example,
    by default, you can't backspace before the insertion point set with 'i'.
    This configuration makes backspace behave more reasonably, in that you can
    backspace over anything.
]]--
opt.backspace = "indent,eol,start"
 
--[[
    By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
    shown in any window) that has unsaved changes. This is to prevent you from "
    forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
    hidden buffers helpful enough to disable this protection. See `:help hidden`
    for more information on this.
]]--
opt.hidden = true

--[[
    This setting makes search case-insensitive when all characters in the string
    being searched are lowercase. However, the search becomes case-sensitive if
    it contains any capital letters. This makes searching more convenient.
]]--
opt.ignorecase = true
opt.smartcase  = true

-- Enable searching as you type, rather than waiting till you press enter
opt.incsearch = true

-- Disable audible bell
opt.belloff = "all"

-- Enable magic search
opt.magic = true

-- Change tab key to instead be 4 spaces
opt.tabstop     = 4
opt.shiftwidth  = 4
opt.expandtab   = true

-- Enable copy/paste to OS clipboard
opt.clipboard = "unnamed"       --Windows/macOS
--opt.clipboard="unnamedplus"   --Linux

-- Highlight search matches everywhere in the current file
opt.hlsearch = true

-- Use block cursor in insert mode
opt.guicursor = "i:block"

------ END OPTIONS ------

--- START KEYBINDINGS ---

local keymap = vim.keymap

--[[
    Rebind HJKL for faster navigation.
    H -> Jump to start of line
    J -> Jump down half a screen
    K -> Jump up half a screen
    L -> Jump to end of line
]]--
keymap.set({'n','v'}, 'H', '^')
keymap.set({'n','v'}, 'J', '<c-d>')
keymap.set({'n','v'}, 'K', '<c-u>')
keymap.set({'n','v'}, 'L', '$')

--[[
    Try to prevent bad habits like using the arrow keys for movement. This is
    not the only possible bad habit. For example, holding down the h/j/k/l keys
    for movement, rather than using more efficient movement commands, is also a
    bad habit. The former is enforceable through a .vimrc, while we don't know
    how to prevent the latter.
]]--
function get_command(preferred_key, nonpreferred_key)
    return string.format('<cmd>echo "Use %s instead of %s"<cr>', preferred_key, nonpreferred_key)
end

keymap.set({'i','n'}, '<left>',  get_command("h", "left arrow"))
keymap.set({'i','n'}, '<right>', get_command("l", "right arrow"))
keymap.set({'i','n'}, '<up>',    get_command("k", "up arrow"))
keymap.set({'i','n'}, '<down>',  get_command("j", "down arrow"))

---- END KEYBINDINGS ----

----- START PLUGINS -----

local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug('nvim-treesitter/nvim-treesitter', { ['do']=':TSUpdate' })
    Plug('neovim/nvim-lspconfig') --, { ['do']=':TSUpdate' })
    --Plug('zbirenbaum/copilot.lua')
vim.call('plug#end')

-- Treesitter
require'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
        enable = true
    }
}

local lspconfig = require('lspconfig')

-- Python
lspconfig.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
}

-- Terraform
--lspconfig.terraformls.setup{}
--lspconfig.tflint.setup{}

--vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
--vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
--vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
--vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
--vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

------ END PLUGINS ------

