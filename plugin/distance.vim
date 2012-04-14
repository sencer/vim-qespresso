nmap <silent> <Leader>d :echo Dist()<CR>
au CursorHold input.txt call UnHighl()
au InsertEnter input.txt call UnHighl()

function! Dist()
  if !exists("b:InputType")
    let b:InputType=GetEspressoInputType()
  endif
  if !exists("b:coor_old")
    let w:origin=[0,0,0]
    let b:coor_old=w:origin
  endif
  let coor=Read_line()
  let ln=getline(line("."))
  if !exists("b:ln_old")
    let b:ln_old=ln
  endif
  exe ":match IncSearch \"" . ln . "\"" 
  exe ":2match IncSearch \"" . b:ln_old . "\"" 
  let b:ln_old=ln

  if b:InputType=="Crystal"
    if !exists("b:celldm")
      let b:celldm=GetCellDim()
    endif
    for a in range(3)
      let coor[a]=MyCalc(b:celldm[a] . "*" . coor[a])
    endfor
  endif
  let result=Distance(coor,b:coor_old)
  let b:coor_old=coor
  return result
endfunction

function! UnHighl()
  match
  2match
  unlet b:ln_old
endfunction
