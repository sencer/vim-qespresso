nmap <silent> <Leader>d :echo Dist()<CR>
au CursorHold input.txt call UnHighl()
au InsertEnter input.txt call UnHighl()

function! Dist()
  if !exists("b:InputType")
    let b:InputType=s:GetEspressoInputType()
  endif
  if !exists("b:coor_old")
    let w:origin=[0,0,0]
    let b:coor_old=w:origin
  endif
  let coor=s:Read_line()
  let ln=getline(line("."))
  if !exists("b:ln_old")
    let b:ln_old=ln
  endif
  exe ":match IncSearch \"" . ln . "\"" 
  exe ":2match IncSearch \"" . b:ln_old . "\"" 
  let b:ln_old=ln

  if b:InputType=="Crystal"
    if !exists("b:celldm")
      let b:celldm=s:GetCellDim()
    endif
    for a in range(3)
      let coor[a]=MyCalc(b:celldm[a] . "*" . coor[a])
    endfor
  endif
  let result=s:Distance(coor,b:coor_old)
  let b:coor_old=coor
  return result
endfunction

function! UnHighl()
  if exists("b:ln_old")
    match
    2match
    unlet b:ln_old
  endif
endfunction

function! s:Distance(coor1,coor2)
  let calc_str="sqrt("
  for a in range(3)
    let calc_str= calc_str . "(" . a:coor1[a] . "-" . a:coor2[a] . ")^2+"
  endfor
  let calc_str= calc_str . "0)"
  let calc_str= substitute(calc_str,"--","+","")
  return MyCalc(calc_str)
endfunction

function! s:Read_line()
  let current_line=split(getline("."))
  return [current_line[1],current_line[2],current_line[3]]
endfunction

function! s:GetEspressoInputType()
  " set ignorecase!
  if search("ATOMIC_POSITIONS\\s*(\\s*CRYSTAL\\s*)",'n')>0
    let InputType = "Crystal" 
  else
    let InputType = "Angstrom"
  endif
  " set noignorecase
  return InputType
endfunction

function! s:GetCellDim()
    let celldm=["0.52918",1,1]
    for a in range(3)
      let i=a+1
      let b=split(substitute(getline(search("^\\s*celldm(" . i . ")\\s*=\\s*\\(\\d\\+\\),*",'n')),',',"",""),"=")
      let celldm[a] = MyCalc(celldm[0] . "*" . b[1])
    endfor
    return celldm
endfunction

