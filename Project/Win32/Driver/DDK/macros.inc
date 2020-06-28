; Created by Ct757

; macro for calling fastcall functions
macro fastcall func, p1, p2, [px]
  {
    if ~ px eq
      reverse push px
    end if
    if ~ p1 eq
      mov ecx,p1
    end if
    if ~ p2 eq
      mov edx,p2
    end if
    call [func]
  }
  
; stupid "push 'string'" macro
macro pushsz string
{
  local .next
    call   .next
    db	   string,0
    .next:
}

; macro for assuming structs 
; (my old macro, now I use "virtual at .." - it is more evident I think...)
macro assume  reg, struct
{
  virtual at reg
    .#reg struct
  end virtual
}