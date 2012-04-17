
function! Distance(coor1,coor2)
  let calc_str="sqrt("
  for a in range(3)
    let calc_str= calc_str . "(" . a:coor1[a] . "-" . a:coor2[a] . ")^2+"
  endfor
  let calc_str= calc_str . "0)"
  let calc_str= substitute(calc_str,"--","+","")
  return MyCalc(calc_str)
endfunction

function! Read_line()
  let current_line=split(getline("."))
  return [current_line[1],current_line[2],current_line[3]]
endfunction
