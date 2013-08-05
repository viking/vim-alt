" Vim global plugin for opening alternate files
"
" Looks for the '.altrc' file in the current working directory for file
" patterns. The file is eval'd by Vim and should be a list of lists, where
" each sub-list contains two strings. The first string is a pattern, and the
" second string is used in substitute() to return the desired alternate
" filename that is opened in a new tab.
"
" Maintainer: Jeremy Stephens <viking@pillageandplunder.net>
" License: MIT

if exists("g:loaded_alt")
  finish
endif
let g:loaded_alt = 1

if !exists(":A")
  command A :call s:Open(expand("%:p"), 'ex')
endif

if !exists(":AS")
  command AS :call s:Open(expand("%:p"), 'sp')
endif

if !exists(":AV")
  command AV :call s:Open(expand("%:p"), 'vs')
endif

if !exists(":AT")
  command AT :call s:Open(expand("%:p"), 'tabe')
endif

let s:alt_patterns = {}
function! s:Open(file, cmd)
  if a:file !~ '^'.getcwd()
    echo "file is not in the current directory tree"
    return
  endif
  let fn = substitute(a:file, '^'.getcwd().'/\?', '', '')
  echo fn

  if index(keys(s:alt_patterns), getcwd()) < 0
    let altrc = getcwd() . "/.altrc"
    if filereadable(altrc)
      let data = join(readfile(altrc), "")
      let s:alt_patterns[getcwd()] = eval(data)
    else
      echo "no alternate patterns found"
      return
    endif
  endif

  let patterns = get(s:alt_patterns, getcwd())
  for pattern in patterns
    if fn =~ pattern[0]
      let result = substitute(fn, pattern[0], pattern[1], "")
    endif
  endfor

  if exists("result")
    execute a:cmd result
  else
    echo "file didn't match any alternate patterns"
  endif
endfunction
