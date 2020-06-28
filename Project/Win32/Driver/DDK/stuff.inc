
; macro for static UNICODE_STRING definition
macro u_str name,string
  {
    _us_#name du #string
    _us_#name_len = ($ - _us_#name)
    dw 0
    #name UNICODE_STRING _us_#name_len,(_us_#name_len+2),_us_#name
  }

; macro for building driver import
macro syslibrary [name,string]
  { 
   forward
    local _label
    if ~ name#.needed
      dd RVA name,0,0,RVA _label,RVA name
    end if
   common
    dd 0,0,0,0,0
   forward
    if ~ name#.needed
      _label db string,0
    end if
  }

; macro for building driver import
macro import name,[label,string]
 { common
    name:
   forward
    if used label
     if string eqtype 0
	label dd 80000000h+string
     else
	local _label
	label dd RVA _label
     end if
    end if
   common
    if $ > name
     name#.needed = FALSE
     dd 0
    else
     name#.needed = TRUE
    end if
   forward
    if used label
       if ~ (string eqtype 0)
       _label dw 0
	   db string,0
       end if
    end if }
