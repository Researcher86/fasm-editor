format PE GUI 4.0
entry Start

include 'win32a.inc'

SERVICE_NO_CHANGE                    = 0FFFFFFFFh
SERVICE_ACTIVE                       = 1h
SERVICE_INACTIVE                     = 2h
SERVICE_STATE_ALL                    = SERVICE_ACTIVE or SERVICE_INACTIVE
SERVICE_CONTROL_STOP                 = 1h
SERVICE_CONTROL_PAUSE                = 2h
SERVICE_CONTROL_CONTINUE             = 3h
SERVICE_CONTROL_INTERROGATE          = 4h
SERVICE_CONTROL_SHUTDOWN             = 5h
SERVICE_STOPPED                      = 1h
SERVICE_START_PENDING                = 2h
SERVICE_STOP_PENDING                 = 3h
SERVICE_RUNNING                      = 4h
SERVICE_CONTINUE_PENDING             = 5h
SERVICE_PAUSE_PENDING                = 6h
SERVICE_PAUSED                       = 7h
SERVICE_ACCEPT_STOP                  = 1h
SERVICE_ACCEPT_PAUSE_CONTINUE        = 2h
SERVICE_ACCEPT_SHUTDOWN              = 4h

DELETE                               = 10000h
SERVICE_KERNEL_DRIVER                = 00000001h
SERVICE_DEMAND_START                 = 00000003h
SERVICE_ERROR_IGNORE                 = 00000000h

SERVICE_QUERY_CONFIG                 = 1h
SERVICE_CHANGE_CONFIG                = 2h
SERVICE_QUERY_STATUS                 = 4h
SERVICE_ENUMERATE_DEPENDENTS         = 8h
SERVICE_START                        = 10h
SERVICE_STOP                         = 20h
SERVICE_PAUSE_CONTINUE               = 40h
SERVICE_INTERROGATE                  = 80h
SERVICE_USER_DEFINED_CONTROL         = 100h
SERVICE_ALL_ACCESS                   = STANDARD_RIGHTS_REQUIRED OR SERVICE_QUERY_CONFIG OR SERVICE_CHANGE_CONFIG OR SERVICE_QUERY_STATUS or SERVICE_ENUMERATE_DEPENDENTS or SERVICE_START or SERVICE_STOP or SERVICE_PAUSE_CONTINUE or SERVICE_INTERROGATE or SERVICE_USER_DEFINED_CONTROL


SC_MANAGER_CONNECT                   = 1h
SC_MANAGER_CREATE_SERVICE            = 2h
SC_MANAGER_ENUMERATE_SERVICE         = 4h
SC_MANAGER_LOCK                      = 8h
SC_MANAGER_QUERY_LOCK_STATUS         = 10h
SC_MANAGER_MODIFY_BOOT_CONFIG        = 20h
SC_MANAGER_ALL_ACCESS                = STANDARD_RIGHTS_REQUIRED OR SC_MANAGER_CONNECT OR SC_MANAGER_CREATE_SERVICE OR SC_MANAGER_ENUMERATE_SERVICE OR SC_MANAGER_LOCK or SC_MANAGER_QUERY_LOCK_STATUS or SC_MANAGER_MODIFY_BOOT_CONFIG
SC_MANAGER_CREATE_SERVICE = 2h

NUM_DATA_ENTRY			= 4
DATA_SIZE			    	= 4 * NUM_DATA_ENTRY
METHOD_BUFFERED     = 0
FILE_DEVICE_UNKNOWN = 22h
FILE_ANY_ACCESS     = 0
IOCTL_IO          	=  (FILE_DEVICE_UNKNOWN shl 16) or (800h shl 14) or (FILE_ANY_ACCESS shl 2) or METHOD_BUFFERED

struct SERVICE_STATUS
  dwServiceType             dd      ?
  dwCurrentState            dd      ?
  dwControlsAccepted        dd      ?
  dwWin32ExitCode           dd      ?
  dwServiceSpecificExitCode dd      ?
  dwCheckPoint              dd      ?
  dwWaitHint                dd      ?
ends

section '.text' code readable executable

Start:
  invoke GetModuleHandle, 0
  mov [wc.hInstance], eax
  invoke LoadIcon, 0, IDI_APPLICATION
  mov [wc.hIcon], eax
  invoke LoadCursor, 0, IDC_ARROW                    
  mov [wc.hCursor], eax
  invoke RegisterClass, wc                            
  test eax, eax
  jz error
  
  invoke SystemParametersInfo, SPI_GETWORKAREA, 0, rect, 0      
  mov edx, [rect.bottom]
  mov eax, 256
  shr edx, 1
  shr eax, 1
  sub edx, eax
  mov eax, [rect.right]
  mov ecx, 192
  shr eax, 1
  shr ecx, 1
  sub eax, ecx                         

  invoke CreateWindowEx, 0, _class, _title, WS_VISIBLE + WS_DLGFRAME + WS_SYSMENU,\
                         eax, edx, 256, 192, NULL, NULL, [wc.hInstance], NULL
  test eax, eax
  jz error

msg_loop:
  invoke GetMessage, msg, NULL, 0, 0
  cmp eax, 1
  jb end_loop
  jne msg_loop
  invoke TranslateMessage, msg
  invoke DispatchMessage, msg
  jmp msg_loop

error:
  invoke MessageBox, NULL, _error, NULL, MB_ICONERROR + MB_OK

end_loop:
  invoke ExitProcess, [msg.wParam]

proc WindowProc uses ebx esi edi, hwnd, wmsg, wparam, lparam
  cmp [wmsg], WM_CREATE
  je .wmcreate 
  
  cmp [wmsg], WM_DESTROY
  je .wmdestroy
  
  cmp [wmsg], WM_COMMAND
  jne .defwndproc

  mov	eax, [wparam]
  cmp eax, 0
  je .defwndproc
  
  cmp ax, BtnID
  jne .defwndproc
  
  shr eax,16
  cmp ax, BN_CLICKED 
  jne .defwndproc

;-------------------------------------------------------------------------------
   ; Button OnCLICK
   
  cmp [CrtFil], 0
  jz .next
  
; Driver will receive IRP of type IRP_MJ_DEVICE_CONTROL  
	invoke DeviceIoControl, [hDevice], IOCTL_IO, adwInBuffer,\
              lenAdwInBuffer, adwOutBuffer, lenAdwOutBuffer,\ 
              dwBytesReturned, NULL   
              
  jmp .defwndproc 

.next:  
  invoke MessageBox, [hwnd], TextBtn, 0, MB_ICONINFORMATION
  

;-------------------------------------------------------------------------------
  
.defwndproc:
  invoke DefWindowProc, [hwnd], [wmsg], [wparam], [lparam]
  jmp .finish
  
.wmcreate:
  mov edx, 192
  mov eax, 80
  shr edx, 1
  shr eax, 1
  sub edx, eax
  mov eax, 256
  mov ecx, 96
  shr eax, 1
  shr ecx, 1
  sub eax, ecx 
  
  invoke CreateWindowEx, 0, BtnClName, TextBtn,\
      WS_CHILD or BS_DEFPUSHBUTTON or WS_VISIBLE,\
      eax, edx, 75, 25, [hwnd], BtnID, [wc.hInstance], 0

	mov	[hwndBtn], eax
  
  call RegDrv
  jmp .finish
  
.wmdestroy:
  call DelDrv
  invoke PostQuitMessage, 0
  xor eax, eax
  
.finish:
  ret
endp

;===============================================================================

proc RegDrv
	invoke OpenSCManager, NULL, NULL, SC_MANAGER_ALL_ACCESS
	cmp eax, NULL
  jz .error1

  mov [openSCM], 1
  mov [hSCManager], eax
  
  push eax
  invoke GetFullPathName, sYs, 255, acDriverPath, esp
  pop eax
  
  ; Install service
  invoke CreateService, [hSCManager], nam, nam, \
                SERVICE_START + SERVICE_STOP + DELETE, SERVICE_KERNEL_DRIVER,\
                SERVICE_DEMAND_START, SERVICE_ERROR_IGNORE, acDriverPath,\
                NULL, NULL, NULL, NULL, NULL
  
  cmp eax, NULL
  jz .error2
  mov [CrtSrv], 1
  
  mov [hService], eax
  
  ; Driver's DriverEntry procedure will be called
  invoke StartService, [hService], 0, NULL
  cmp eax, NULL
  jz .error3
  mov [StrSrv], 1
  
  invoke CreateFile, link, GENERIC_READ + GENERIC_WRITE, \
                     0, NULL, OPEN_EXISTING, 0, NULL
          
  cmp eax, INVALID_HANDLE_VALUE
  jz .error4
  
  mov [CrtFil], 1
  mov [hDevice], eax
  
  jmp .exit
      
.error4:
  invoke MessageBox, NULL, er4, NULL, MB_ICONSTOP
  jmp .exit

.error3:
  invoke MessageBox, NULL, er3, NULL, MB_OK + MB_ICONSTOP
  jmp .exit
  
.error2:
  invoke MessageBox, NULL, er2, NULL, MB_OK + MB_ICONSTOP
  jmp .exit
  
.error1:
  invoke MessageBox, NULL, er1, NULL, MB_OK + MB_ICONSTOP

.exit:
  ret
endp

;===============================================================================

proc DelDrv
  cmp [CrtFil], 1
  jnz .exit
 
  invoke CloseHandle, [hDevice]
  
  cmp [StrSrv], 1
  jnz .exit

  invoke ControlService, [hService], SERVICE_CONTROL_STOP, _ss
  
  cmp [CrtSrv], 1
  jnz .exit
  
  invoke DeleteService, [hService]
	invoke CloseServiceHandle, [hService]
  
  cmp [openSCM], 1
  jnz .exit
  invoke CloseServiceHandle, [hSCManager]
  
.exit:  
  ret
endp

;===============================================================================

section '.data' data readable writeable

  _class       TCHAR 'FASMWIN32', 0
  _title       TCHAR 'Test win32 driver', 0
  _error       TCHAR 'Startup failed.', 0
  BtnClName		 db 'button', 0
  TextBtn 		 db 'Test', 0
  BtnID		     =  1
  hwndBtn	  	 dd 0
  
  hSCManager   dd 0
  hService     dd 0
  hDevice      dd 0
  link         db '\\.\sYsDriver', 0
  sYs          db 'sYs.sys', 0
  nam          db 'sYs', 0
  acDriverPath db 100h dup (?)
  er1          db "Can't connect to Service Control Manager.", 0
  er2          db "Can't register driver.", 0
  er3          db "Can't start driver.", 0
  er4          db 'Device is not present.', 0
  _ss          SERVICE_STATUS
  
  adwInBuffer        db 'Hello', 0
  lenAdwInBuffer     = $ - adwInBuffer
  adwOutBuffer       db 5 dup(0)
  lenAdwOutBuffer    =  5
  dwBytesReturned    db 5 dup(0)
  lendwBytesReturned =  5
  
; Boolean
  openSCM      db 0
  CrtSrv       db 0 
  StrSrv       db 0
  CrtFil       db 0

  wc WNDCLASS 0, WindowProc, 0, 0, NULL, NULL, NULL, COLOR_BTNFACE + 1, NULL, _class

  msg MSG
  rect RECT 

section '.idata' import data readable writeable

  library kernel32, 'KERNEL32.DLL',\
    advapi32,'ADVAPI32.DLL',\
	  user32, 'USER32.DLL'

  include 'API\KERNEL32.INC'
  include 'API\ADVAPI32.INC'
  include 'API\USER32.INC'