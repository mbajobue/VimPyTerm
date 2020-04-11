# VimPyTerm

A Vim plugin that adds an interactive Python terminal to Vim.

[![Vim-Py-Term.png](https://i.postimg.cc/YCDCHP9y/Vim-Py-Term.png)](https://postimg.cc/BjD05M2x)

## Installation

You can use any plugin manager such as [Vim-Plug](https://github.com/junegunn/vim-plug) or just copy the `VimPyTerm.vim` file to the `~/.vim/plugin` directory.

## Usage

Use the command `:VimPyTerm` to open or close the Python terminal. You can use Python virtual environments by passing the path of the Python interpreter as an argument:

```
:VimPyTerm <path_to_virtualenv>/bin/python
```

The terminal can be used like any other Vim split. For example it can be resized using `Ctrl-w` and `Ctrl-w -`. Use `:help split` to learn more about about Vim splits. 

Use the space bar to send and execute Python code in the terminal:

- While on normal mode, the space key will send the current line where your cursor is positioned at (or the next non-blank line of code). If your cursor is located inside a piece of indented code, the whole block of code will be sent and executed (for example, a function). 
- While on visual mode, the selected text will be sent to the Python terminal.

Feel free to change the default key map in your `.vimrc` like so:

```
let g:VimPyTerm_map_keys = 0
map <space> :call SendCode()<CR>
vmap <space> :<c-u>call SendVisual()<CR>
```

To change the default terminal size add the following line to your `.vimrc` file:

```
let g:VimPyTerm_rows = 15
```

If you don want to type the `:VimPyTerm` command to open the Python terminal, just add a key map for it to you `.vimrc` file.

