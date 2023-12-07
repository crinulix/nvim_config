vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("neo-tree").setup()

-- key binding for the neotree toggle 
vim.keymap.set('n', '<C-b>', '<Cmd>Neotree toggle<CR>')

