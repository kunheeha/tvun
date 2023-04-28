# Tmux-Vim Unified Navigation

Navigate seamlessly between tmux and vim windows with just the tmux prefix key + hjkl

A barebones rewrite of [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator), differences are:
* uses <prefix>+key as keybinds for navigation instead of single keybinds as in vim-tmux-navigator (namely `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`)
* no need to sacrifice four separate keybinds just for navigation (eg. vim-tmux-navigator uses `<C-l>` to navigate to rigt pane, but this is already the readline keybind for clearing screen. There is a workaround to use `<prefix>`+`<C-l>` to clear screen instead, but if `<C-l>` to clear screen is already in your muscle memory then this takes a while to get used to)

## Usage

**Tmux**

Source the tvun.conf file from your tmux config
```
source-file PATH/TO/tvun.conf
```

**Vim**

Copy in contents of tvun.vim into your vimrc or source the file from your vimrc

```
source PATH/TO/tvun.vim
```

**Neovim**

Convert the contents of tvun.vim into lua in whichever way you prefer and add to your nvim config directory.

Eg. make a file called tvun.lua with the following:

```
vim.cmd([[
function! s:VimNavigate(direction)
  if winnr() !=# winnr(a:direction)
    execute 'wincmd ' . a:direction
  else
    if a:direction == 'h'
      call system('tmux select-pane -L')
    elseif a:direction == 'j'
      call system('tmux select-pane -D')
    elseif a:direction == 'k'
      call system('tmux select-pane -U')
    elseif a:direction == 'l'
      call system('tmux select-pane -R')
    endif
  endif
endfunction

command! Vnleft call s:VimNavigate('h')
command! Vnright call s:VimNavigate('l')
command! Vnup call s:VimNavigate('k')
command! Vndown call s:VimNavigate('j')
]])


keymap("n", "<C-q>h", ":Vnleft<CR>", opts)
keymap("n", "<C-q>j", ":Vndown<CR>", opts)
keymap("n", "<C-q>k", ":Vnup<CR>", opts)
keymap("n", "<C-q>l", ":Vnright<CR>", opts)
```

... and source it from your init.lua `require("mynvim.tvun")`
