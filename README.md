# VimPyTerm

A Vim pluggin that adds an interactive Python terminal to Vim.

## Installation

You can use any plugin manager such as Vim-Plug or just copy the `VimPyTerm.vim` file to the `~/.vim/plugin` directory.

## Usage

Use the command `:VimPyTerm` to open or close the Python terminal. Use the space bar to send and execute Python code in the terminal:

- While on normal mode, the space key will send the current line where your cursor is positioned at. If your cursor is located inside a piece of indented code, the whole block of code will be sent and executed (for example, a function). 
- While on visual mode, the selected text will be sent to the Python terminal.

Feel free to change the default key map in your `.vimrc` like so:

```
let g:VimPyTerm_map_keys = 0
map <space> :call SendCode()<CR>
vmap <space> :<c-u>call SendVisual()<CR>
```

If you don want to type the `:VimPyTerm` command to open the Python terminal, just add a key map for it to you `.vimrc` file.


## To Do list

- [ ] Enable support for Python virtual environments
