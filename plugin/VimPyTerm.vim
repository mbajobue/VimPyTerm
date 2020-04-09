" VimPyTerm: interactive Python terminal inside Vim
" Maintainer:   Manuel Bajo Buenestado <lolobajo@gmail.com>
" License:      MIT LICENSE


set splitbelow
set splitright
let s:vimpyterm = 0

if !exists('g:VimPyTerm_map_keys')
    let g:VimPyTerm_map_keys = 1
endif

if !exists('g:VimPyTerm_rows')
    let g:VimPyTerm_rows = 15
endif


" Open and close the Python console

function! VimPyTerm(...)
    if s:vimpyterm == 0
	if a:0 > 0 
            let s:term = a:1
	else
            let s:term = "python"
	endif
        execute "term ++rows=".g:VimPyTerm_rows." ++close ".s:term
        let s:currentWindow=winnr()
        let s:vimpyterm = 1
        wincmd p
	
	" Mappings. Feel free to change them in your vimrc file.
	if g:VimPyTerm_map_keys
	    map <space> :call SendCode()<CR>
	    vmap <space> :<c-u>call SendVisual()<CR>
	endif
    else
        exe s:currentWindow . "wincmd w"
        call term_sendkeys(s:term, "quit()\<CR>")	
        let s:vimpyterm = 0
	if g:VimPyTerm_map_keys
	    map <space> <space>
	    vmap <space> <space>
	endif
    endif
endfunction

command -nargs=* VimPyTerm call VimPyTerm(<f-args>)


" Send lines of code

function! s:ExecuteLine()
    let currentLine   = getline(".")
    call term_sendkeys(s:term, currentLine)
    call term_sendkeys(s:term, "\<CR>")	
    call cursor(nextnonblank(line(".") +1 ), 1)
endfunction

function! s:SendEnter()
    call term_sendkeys(s:term, "\<CR>")	
    call cursor(nextnonblank(line(".") +1 ), 1)
endfunction

function! SendCode()
    let ind = 0
    call cursor(nextnonblank(line(".")), 1)
    while strpart(getline('.'),0,1)==' ' || strpart(getline('.'),0,1)=='	'
        call cursor(prevnonblank(line(".") - 1 ), 1)
    endwhile
    call s:ExecuteLine()
    while strpart(getline('.'),0,1)==' ' || strpart(getline('.'),0,1)=='	'
        call s:ExecuteLine()
        let ind = 1
    endwhile
    if ind == 1
        call s:SendEnter()
    endif
endfunction


" Functions for visual mode

" A function to get the selected text in the visual mode, 
" courtesy of xolox (https://stackoverflow.com/users/788200/xolox)
function! s:GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! SendVisual()
    let selectedLine  = s:GetVisualSelection()
    call term_sendkeys(s:term, selectedLine)
    call term_sendkeys(s:term, "\<CR>")	
endfunction


