function! GetEspressoInputType()
  set ignorecase
  if search("ATOMIC_POSITIONS\\s*(\\s*CRYSTAL\\s*)",'n')>0
    let InputType = "Crystal" 
  else
    let InputType = "Angstrom"
  endif
  set noignorecase
  return InputType
endfunction

function GetCellDim()
    let celldm=["0.52918",1,1]
    for a in range(3)
      let i=a+1
      let b=split(substitute(getline(search("^\\s*celldm(" . i . ")\\s*=\\s*\\(\\d\\+\\),*",'n')),',',"",""),"=")
      let celldm[a] = MyCalc(celldm[0] . "*" . b[1])
    endfor
    return celldm
endfunction

