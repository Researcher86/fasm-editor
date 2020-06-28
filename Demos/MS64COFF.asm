format MS64 COFF 

extrn MessageBoxA 

section '.text' code readable executable 

  public main 

main: 
  mov r9d, 0          ; uType = MB_OK
  lea r8,  [_caption] ; LPCSTR lpCaption
  lea rdx, [_message] ; LPCSTR lpText
  mov rcx, 0          ; hWnd = HWND_DESKTOP
  call MessageBoxA
  ret

section '.data' data readable writeable 

  _caption db 'Win32 assembly', 0
  _message db 'Coffee time!', 0