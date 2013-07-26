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

if !exists(":AT")
  command AT :call s:Open(@%)
endif

let s:alt_patterns = {}
function! s:Open(file)
  let patterns = get(s:alt_patterns, getcwd())
  if !patterns
    let fn = getcwd() . "/.altrc"
    if filereadable(fn)
      let data = join(readfile(fn), "")
      let patterns = eval(data)
      let s:alt_patterns[getcwd()] = patterns
    else
      echo "no alternate patterns found"
      return
    endif
  endif

  for pattern in patterns
    if @% =~ pattern[0]
      let result = substitute(@%, pattern[0], pattern[1], "")
    endif
  endfor

  if exists("result")
    execute "tabe" result
  else
    echo "file didn't match any alternate patterns"
  endif
endfunction
