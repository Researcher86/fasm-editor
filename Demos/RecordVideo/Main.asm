format PE GUI 4.0                          
entry Start                        
                              
include 'win32a.inc'
include 'ENCODING\WIN1251.INC'
                                         
section '.text' code readable executable
                   
Start:                                          
  invoke GetModuleHandle, 0                   
  mov [wc.hInstance], eax          
  invoke LoadIcon, [wc.hInstance], 17
  mov [wc.hIcon], eax
  invoke LoadCursor, 0, IDC_ARROW                   
  mov [wc.hCursor], eax
  invoke RegisterClass, wc                   
  test eax, eax                    
  jz error                        
                         
  invoke SystemParametersInfo, SPI_GETWORKAREA, 0, rect, 0      
  mov edx, [rect.bottom]
  mov eax, 291
  shr edx, 1
  shr eax, 1
  sub edx, eax
  mov eax, [rect.right]
  mov ecx, 347
  shr eax, 1
  shr ecx, 1
  sub eax, ecx                         

  mov [X], eax
  mov [Y], edx

  invoke LoadMenu, [wc.hInstance], 37          
  invoke CreateWindowEx, 0, _class, _title,\
            WS_VISIBLE + WS_DLGFRAME + WS_SYSMENU + WS_MINIMIZEBOX,\
            [X], [Y], 347, 291, NULL, eax, [wc.hInstance], NULL
  test eax, eax
  jz error
                       
msg_loop:                     
  invoke GetMessage, msg, NULL, 0, 0
  cmp eax, 1
  jb end_loop
  jne msg_loop
  invoke TranslateMessage, msg
  invoke DispatchMessage, msg                   
jmp	msg_loop

error:
  invoke MessageBox, NULL, _error, NULL, MB_ICONERROR + MB_OK

end_loop:
  invoke ExitProcess, [msg.wParam]

;===============================================================================
  
proc WindowProc uses ebx esi edi, hwnd, wmsg, wparam, lparam
  cmp [wmsg], WM_DESTROY
  je .wmdestroy                           
  cmp [wmsg], WM_CREATE            
  je .wmcreate       
  cmp [wmsg], WM_PAINT
  je .wmpaint                       
  cmp [wmsg], WM_COMMAND
  je .wmcommand                           

.defwndproc:
  invoke DefWindowProc, [hwnd], [wmsg], [wparam], [lparam]
  jmp .finish

.wmcreate:                 
  invoke GetDC, 0
  mov [hScreenDC], eax

  invoke GetDeviceCaps, eax, BITSPIXEL             
  mov [bits], eax

  invoke GetDeviceCaps, [hScreenDC], HORZRES
  mov [maxxScreen], eax                        

  invoke GetDeviceCaps, [hScreenDC], VERTRES
  mov [maxyScreen], eax

  invoke ReleaseDC, 0, [hScreenDC]
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  mov [compfccHandler], 4356534Dh
  mov [mspFRecord], 50                    ; скорость
  mov [PlaybackFPS], 30                   ; частота FPS
  mov [KeyFramesEvery], 5                 ; ключевой кадр
  mov [CompressionQuality], 8000          ; сжатие
  mov [selectedCompressor], 1             ; кодек
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  invoke LoadCursor, 0, IDC_ARROW
  mov [hCursor], eax                 

  mov [bmpInfoHeader.biSize], sizeof.BITMAPINFOHEADER
  mov eax, [maxxScreen]
  mov [bmpInfoHeader.biWidth], eax
  mov eax, [maxyScreen]
  mov [bmpInfoHeader.biHeight], eax
  mov [bmpInfoHeader.biPlanes], 1
  mov eax, [bits]
  mov [bmpInfoHeader.biBitCount], ax
  mov [bmpInfoHeader.biCompression], BI_RGB

  mov eax, [maxxScreen]
  mul [bits]
  add eax, 31
  mov ebx, 32
  div ebx
  mov ebx, 4
  mul ebx
  mul [maxyScreen]

  mov [bmpInfoHeader.biSizeImage], eax
  mov [ImSize], eax

  invoke LoadBitmapA, [wc.hInstance], 1
  mov [Fon], eax
  jmp .finish
                        
.wmpaint:
  invoke BeginPaint, [hwnd], ps
  mov [hdc], eax

  invoke CreateCompatibleDC, [hdc]
  mov [hSrcDC], eax
  invoke SelectObject, [hSrcDC], [Fon]

  invoke SetStretchBltMode, [hdc], STRETCH_HALFTONE
  invoke StretchBlt, [hdc], 0, 0, 347, 291, [hSrcDC], 0, 0, 241, 198, SRCCOPY

  invoke DeleteDC, [hSrcDC]

  invoke EndPaint, [hwnd], ps
  jmp .finish

.wmcommand:
  mov eax, [wparam]
  and eax, 0FFFFh
  cmp eax, IDM_NEW
  je .new
  cmp eax, IDM_ABOUT
  je .about
  cmp eax, IDM_EXIT
  je .wmdestroy
  cmp eax, IDM_START
  je .startRec
  cmp eax, IDM_STOP
  je .stopRec
  jmp .defwndproc

.new:
  mov  [DialogStruct.lStructSize], sizeof.OPENFILENAME
  push [hwnd]
  pop  [DialogStruct.hwndOwner]
  push [wc.hInstance]
  pop  [DialogStruct.hInstance]
  mov  [DialogStruct.lpstrFilter], FilterSaveDialog
  mov  [DialogStruct.lpstrFile], FileName
  mov  [DialogStruct.nMaxFile], 260
  mov  [DialogStruct.Flags], OFN_EXPLORER + OFN_HIDEREADONLY + OFN_OVERWRITEPROMPT
  invoke GetSaveFileNameA, DialogStruct

  jmp .finish

.about:
  invoke DialogBoxParam, [wc.hInstance], 47, [hwnd], DialogProcAbout, 0
  jmp .finish

.startRec:
  call StartRecording
  jmp .finish

.stopRec:                    
  call StopRecording
  jmp .finish

.wmdestroy:
  invoke PostQuitMessage, 0
  xor eax,eax

.finish:
  ret
endp                                     

;===============================================================================

proc DialogProcAbout hwnddlg, msg, wparam, lparam
  push ebx esi edi
  cmp [msg], WM_COMMAND
  je .close
  cmp [msg], WM_CLOSE
  je .close
  xor eax,eax                   
  jmp .finish

.close:
  invoke EndDialog, [hwnddlg], 0

.finish:
  pop edi esi ebx
  ret
endp

;===============================================================================

proc StartRecording
  mov [recordstate], 1

  invoke CreateThread, 0, 0, RecordVideo, 0, CREATE_SUSPENDED, Id
  mov [Thread], eax

  invoke SetThreadPriority, [Thread], THREAD_PRIORITY_IDLE
  invoke ResumeThread, [Thread]
  ret
endp

;===============================================================================

proc StopRecording
  mov [recordstate], 0
  ret
endp
                             
;===============================================================================

proc RecordVideo
  call [AVIFileInit]
  invoke AVIFileOpenA, pfile, FileName, OF_WRITE or OF_CREATE, 0
  cmp eax, 0
  jnz .error1

  invoke RtlZeroMemory, asiInfo, sizeof.AVISTREAMINFOA
  mov [asiInfo.fccType], streamtypeVIDEO
  mov [asiInfo.fccHandler], 0
  mov [asiInfo.dwFlags], 0
  mov [asiInfo.dwScale], 1

  mov eax, [PlaybackFPS]
  mov [asiInfo.dwRate], eax
  mov [asiInfo.dwStart], 0
  mov eax, [bmpInfoHeader.biSizeImage]
  mov [asiInfo.dwSuggestedBufferSize], eax
  mov eax, [bmpInfoHeader.biWidth]
  mov [asiInfo.rcFrame.right], eax
  mov eax, [bmpInfoHeader.biHeight]
  mov [asiInfo.rcFrame.bottom], eax

  invoke AVIFileCreateStreamA, [pfile], Stream, asiInfo
  cmp eax, 0
  jnz .error2

  invoke RtlZeroMemory, opts, sizeof.AVICOMPRESSOPTIONS

  mov [opts.fccType], streamtypeVIDEO
  mov eax, [compfccHandler]
  mov [opts.fccHandler], eax
  mov eax, [KeyFramesEvery]
  mov [opts.dwKeyFrameEvery], eax
  mov eax, [CompressionQuality]
  mov [opts.dwQuality], eax
  mov [opts.dwBytesPerSecond], 0
  mov [opts.dwFlags], AVICOMPRESSF_VALID or AVICOMPRESSF_KEYFRAMES
  mov [opts.lpFormat], $00
  mov [opts.cbFormat], 0
  mov [opts.dwInterleaveEvery], 0

  invoke AVIMakeCompressedStream, CompressedStream, [Stream], opts, 0
  cmp eax, 0
  jnz .error3

  invoke AVIStreamSetFormat, [CompressedStream], 0, bmpInfoHeader, sizeof.BITMAPINFOHEADER
  cmp eax, 0
  jnz .error4

  mov  [lpbi.bmiHeader.biSize], sizeof.BITMAPINFOHEADER
  push [maxxScreen]
  pop  [lpbi.bmiHeader.biWidth]
  push [maxyScreen]
  pop  [lpbi.bmiHeader.biHeight]
  mov  [lpbi.bmiHeader.biPlanes], 1
  push word [bits]
  pop  [lpbi.bmiHeader.biBitCount]
  mov  [lpbi.bmiHeader.biCompression], BI_RGB
  mov  [lpbi.bmiHeader.biSizeImage], 0
  mov  [lpbi.bmiHeader.biXPelsPerMeter], 1
  mov  [lpbi.bmiHeader.biYPelsPerMeter], 1
  mov  [lpbi.bmiHeader.biClrUsed], 0
  mov  [lpbi.bmiHeader.biClrImportant], 0

;-------------------------------------------------------------------------------
  mov [FramePos], 0
  invoke GlobalAlloc, GMEM_ZEROINIT, [ImSize]
  mov [lpBits], eax

  invoke GetDC, 0
  mov [DC], eax
  invoke CreateCompatibleDC, [DC]
  mov [MemDC], eax
  invoke CreateCompatibleBitmap, [DC], [maxxScreen], [maxyScreen]
  mov [Bmp], eax
  invoke SelectObject, [MemDC], [Bmp]
  invoke ReleaseDC, 0, [DC]
                                                
.write:
  invoke GetDC, 0
  mov [DC], eax

  invoke BitBlt, [MemDC], 0, 0, [maxxScreen], [maxyScreen], [DC], 0, 0, SRCCOPY
  invoke ReleaseDC, 0, [DC]

  invoke GetCursorPos, xPoint
  invoke DrawIcon, [MemDC], [xPoint.x], [xPoint.y], [hCursor]

  invoke GetDIBits, [MemDC], [Bmp], 0, [maxyScreen], [lpBits], lpbi, 0
  cmp eax, 0
  jz .exit

  invoke AVIStreamWrite, [CompressedStream], [FramePos], 1, [lpBits], [ImSize], 0, 0, 0
  cmp eax, 0
  jnz .exit

  inc [FramePos]
  cmp [recordstate], 1
  jz .write

;-------------------------------------------------------------------------------
.exit:
  invoke DeleteObject, [Bmp]
  invoke DeleteDC, [MemDC]
  invoke GlobalFree, [lpBits]

  push opts
  pop  [P]
  invoke AVISaveOptionsFree, 1, P

.error4:
  invoke AVIStreamRelease, [CompressedStream]

.error3:
  invoke AVIStreamRelease, [Stream]

.error2:
  invoke AVIFileRelease, [pfile]     

.error1:                        
  call [AVIFileExit]
  ret                 
endp                               
                         
;===============================================================================

section '.data' data readable writeable

  _class TCHAR 'RecVideo',0
  _title TCHAR 'Record video 1.0 :)',0
  _error TCHAR 'Запуск потерпел неудачу.',0

  wc WNDCLASS 0, WindowProc, 0, 0, NULL, NULL, NULL, COLOR_BTNFACE + 1, NULL, _class

  msg MSG
  rect RECT                 
  X dd 0
  Y dd 0
  FileName db 'C:\Record.avi', 256 dup (0)
  FilterSaveDialog	db 'AVI', 0, '*.avi', 0, 0
  DialogStruct	OPENFILENAME
  bmpInfoHeader BITMAPINFOHEADER
                                         
  Id       dd ?
  Thread   dd ?

  P        dd 0
  FramePos dd 0
  ImSize   dd 0

include 'vfw32.inc'
include 'Data.inc'

  DC           dd 0
  MemDC        dd 0
  Bmp          dd 0
  lpbi         BITMAPINFO
  lpBits       dd 0
  xPoint       POINT

  Fon          dd 0
  hdc          dd 0
  ps           PAINTSTRUCT
  hSrcDC       dd 0   
  

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL',\
    user32,'USER32.DLL',\
    gdi32,'GDI32.DLL',\
    comdlg32,'comdlg32.dll',\
    winmm, 'WINMM.DLL',\
    msvfw32, 'MSVFW32.DLL',\
    avifil32, 'AVIFIL32.DLL',\
    avicap32, 'AVICAP32.DLL'

  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'
  include 'api\COMDLG32.INC'

  include 'API_winmm.inc'                 
  include 'API_msvfw32.inc'
  include 'API_avifil32.inc'
  include 'API_avicap32.inc'

section '.rsrc' resource data readable

  IDM_NEW     = 101  
  IDM_EXIT    = 102

  IDM_START   = 201
  IDM_STOP    = 202
  IDM_ABOUT   = 301

  directory RT_MENU, menus,\
      RT_DIALOG, dialogs,\
      RT_ICON, icons,\
      RT_BITMAP, resBmp,\
      RT_GROUP_ICON, group_icons,\
      RT_MANIFEST, manifests,\
      RT_VERSION, versions

  resource menus,\
     37, LANG_RUSSIAN + SUBLANG_DEFAULT, main_menu

  resource dialogs,\
     47, LANG_RUSSIAN + SUBLANG_DEFAULT, aboutDlg

  resource icons,\
      1, LANG_NEUTRAL, icon_data

  resource resBmp,\
      1, LANG_NEUTRAL, Bmp1

  resource group_icons,\
     17, LANG_NEUTRAL, main_icon

  resource manifests,\
      1, LANG_NEUTRAL, manifest

  resource versions,\
      1, LANG_NEUTRAL, version

;===============================================================================

  menu main_menu
    menuitem 'Файл',0, MFR_POPUP
    menuitem 'Новый',  IDM_NEW
    menuseparator
    menuitem 'Выход',  IDM_EXIT, MFR_END

    menuitem 'Запись', 0, MFR_POPUP
    menuitem 'Старт',  IDM_START
    menuitem 'Стоп',   IDM_STOP, MFR_END

    menuitem 'Помощь', 0, MFR_POPUP + MFR_END
    menuitem 'О программе...', IDM_ABOUT, MFR_END

;===============================================================================

  dialog aboutDlg, 'О программе', 12, 20, 200, 75, WS_CAPTION + WS_POPUP + WS_SYSMENU + DS_MODALFRAME
    dialogitem 'STATIC', <'Record video ', 2014h, ' версия 1.0.', 0Dh, 0Ah,\
      'Разработчик: Альпенов Танат Маратович.', 0Dh, 0Ah,\
      'Дата создания: 2011 г.', 0Dh, 0Ah, 'Мыло: Researcher86@Mail.ru.', 0Dh, 0Ah,\
      'Сделано в Казахстане.'>, -1, 50, 5, 144, 40, WS_VISIBLE + SS_CENTER
    dialogitem 'STATIC', 17, -1, 15, 15, 48, 48, WS_VISIBLE + SS_ICON
    dialogitem 'STATIC', '', -1, 4, 50, 194, 11, WS_VISIBLE + SS_ETCHEDHORZ
    dialogitem 'BUTTON', 'OK', IDOK, 145, 55, 50, 15, WS_VISIBLE + WS_TABSTOP + BS_DEFPUSHBUTTON
  enddialog

;===============================================================================

  icon main_icon, icon_data, 'MAINICON.ico'
  bitmap Bmp1, 'Fon.bmp'

  resdata manifest                                
    file 'Manifest32.xml'
  endres
                                  
;===============================================================================

  versioninfo version, VOS__WINDOWS32, VFT_APP, VFT2_UNKNOWN,\
        LANG_RUSSIAN + SUBLANG_DEFAULT, 0,\
        'Comments', 'Сделано в Казахстане',\
        'CompanyName', 'Танат',\
	      'FileDescription', 'Record video',\
	      'LegalCopyright', 'Альпенов Танат Маратович.',\
	      'FileVersion', '1.0',\
	      'ProductVersion', '1.0',\
	      'OriginalFilename', 'RecVideo.EXE'       