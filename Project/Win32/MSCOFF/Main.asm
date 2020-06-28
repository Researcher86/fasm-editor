format MS COFF

extrn '__imp__MessageBoxA@16' as MessageBox: dword

section '.text' code readable executable

  public main
                                                      
main:
  push 0
  push _caption
  push _message
  push 0
  call [MessageBox]
  ret

section '.data' data readable writeable

  _caption db 'Win32 assembly', 0
  _message db 'Coffee time!', 0