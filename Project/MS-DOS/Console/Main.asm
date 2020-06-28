use16
org 100h

  mov ah, 9
  mov dx, mes
  int 21h

  mov ah, 0Ah
  mov dx, key
  int 21h                     
                                       
  mov ax, 4C00h
  int 21h

mes   db 'Hello World!$'
key   db 2, 0, 0, 0