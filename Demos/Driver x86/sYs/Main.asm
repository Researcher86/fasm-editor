format PE native 4.0 at 10000h
entry DriverEntry

include 'win32a.inc'
include 'ENCODING\WIN1251.INC'
include 'DDK\structs.inc'
include 'DDK\macros.inc'
include 'DDK\ntstatus.inc'
include 'DDK\ntddk.inc'
include 'DDK\stuff.inc'

       
IOCTL_IO =  (FILE_DEVICE_UNKNOWN shl 16) or (800h shl 14) or (FILE_ANY_ACCESS shl 2) or METHOD_BUFFERED

;===============================================================================


TIMER_FREQUENCY	equ 1193167			; 1,193,167 Hz
OCTAVE			equ 2
PITCH_C			equ 523				;  523,25 Hz
PITCH_Cs		equ 554				;  554,37 Hz
PITCH_D			equ 587				;  587,33 Hz
PITCH_Ds		equ 622				;  622,25 Hz
PITCH_E			equ 659				;  659,25 Hz
PITCH_F			equ 698				;  698,46 Hz
PITCH_Fs		equ 740				;  739,99 Hz
PITCH_G			equ 784				;  783,99 Hz
PITCH_Gs		equ 831				;  830,61 Hz
PITCH_A			equ 880				;  880,00 Hz
PITCH_As		equ 988				;  987,77 Hz
PITCH_H			equ 1047			; 1046,50 Hz


TONE_1			equ TIMER_FREQUENCY/(PITCH_C*OCTAVE)
TONE_2			equ TIMER_FREQUENCY/(PITCH_E*OCTAVE)
TONE_3			equ (PITCH_G*OCTAVE)

DELAY			equ 2000000h		

macro DO_DELAY {
	mov eax, DELAY
@@:
  dec eax
  jnz @b
}


;===============================================================================


section '.text' code readable executable notpageable

proc MakeBeep1 dwPitch
	cli

	mov al, 10110110b
	out 43h, al         

	mov eax, [dwPitch]
	out 42h, al

	mov al, ah
	out 42h, al

	; speaker ON
	in al, 61h
	or  al, 11b
	out 61h, al

	sti

  DO_DELAY

	cli

	; speaker OFF
	in al, 61h
	and al, 11111100b
	out 61h, al

	sti

	ret
endp


;-------------------------------------------------------------------------------

proc MyBeeb
	push TONE_1
  call MakeBeep1

	push TONE_2
  call MakeBeep1

  ; Аппаратный доступ через hal.dll функцию HalMakeBeep
	invoke HalMakeBeep, TONE_3

  DO_DELAY
                    
	invoke HalMakeBeep, 0
  
  ret
endp


proc DriverEntry pDriverObject, usRegistryPath
;==========================================================================
  locals
    status	      dd ?
    pDeviceObject dd ?
  endl
;==========================================================================

	invoke DbgPrint, dbgDriverEntry

	mov [status], STATUS_DEVICE_CONFIGURATION_ERROR

;-----[ Создаем устройство

	lea eax, [pDeviceObject]
	invoke IoCreateDevice, [pDriverObject], 0, usDevName, FILE_DEVICE_UNKNOWN, 0, 0, eax
	or eax, eax
	mov [status], eax
	jnz	DriverEntryExit

;-----[ Создаем симвользую ссылку на устройство, дабы можно было общаться с драйвером извне

	invoke IoCreateSymbolicLink, usSymLink, usDevName
	or eax, eax
	jz SetHandlers

;-----[ А если произошла ошибка - удаляем устройство

	invoke IoDeleteDevice, [pDeviceObject]
	jmp DriverEntryExit

;-----[ Задаем обработчики

SetHandlers:
	mov	eax, [pDriverObject]
	mov	[eax + DRIVER_OBJECT.DriverUnload], DriverUnload
	mov	[eax + DRIVER_OBJECT.MajorFunction + IRP_MJ_CREATE * 4], DispatchCreateClose
	mov	[eax + DRIVER_OBJECT.MajorFunction + IRP_MJ_CLOSE * 4], DispatchCreateClose
	mov	[eax + DRIVER_OBJECT.MajorFunction + IRP_MJ_DEVICE_CONTROL * 4], DispatchControl

	mov	[status], STATUS_SUCCESS
  
  call MyBeeb

DriverEntryExit:
	mov	eax, [status]
	ret
endp

proc DriverUnload pDriverObject
	
  invoke DbgPrint, dbgDriverUnload

;-----[ Удаляем символьную ссылку
	invoke IoDeleteSymbolicLink, usSymLink

;-----[ Проверка, устройство уже удалено?
	mov eax, [pDriverObject]
	mov eax, [eax + DRIVER_OBJECT.DeviceObject]
	or eax, eax
	jz AlreadyDeleted

;-----[ если еще не удалено - удаляем
	invoke IoDeleteDevice, eax
  
  call MyBeeb   

AlreadyDeleted:
	ret
endp

proc DispatchCreateClose pDeviceObject, pIrp

;-----[ Обработка открытия/закрытия девайса
	mov eax, [pIrp]
	mov [eax + _IRP.IoStatus.Status], STATUS_SUCCESS
	and [eax + _IRP.IoStatus.Information], 0
	fastcall IofCompleteRequest, [pIrp], IO_NO_INCREMENT
	mov eax, STATUS_SUCCESS
  
  call MyBeeb
  
  invoke DbgPrint, dbgDispatchCreateClose
  
	ret
endp

proc DispatchControl pDeviceObject, pIrp

  invoke DbgPrint, dbgDispatchControl
  
  call MyBeeb
  
  fastcall  IofCompleteRequest, [pIrp], IO_NO_INCREMENT
  
	mov eax, STATUS_SUCCESS
	ret
endp


;===============================================================================


section '.data' data readable writeable notpageable

  u_str usSymLink, '\??\sYsDriver'
  u_str usDevName, '\Device\sYsDevice'
   
  dbgDriverEntry           db 'DriverEntry', 0
  dbgDriverUnload          db 'DriverUnload', 0
  dbgDispatchCreateClose   db 'DispatchCreateClose', 0
  dbgDispatchControl       db 'DispatchControl', 0

;===============================================================================


section '.idata' import readable notpageable

    syslibrary ntoskrnl,'ntoskrnl.exe',\
	       hal,'hal.dll'

    include 'DDK\ntoskrnl.inc'
    include 'DDK\hal.inc'
    
section '.rsrc' resource data readable

  directory RT_VERSION, versions
      
  resource versions,\
      1, LANG_NEUTRAL, version

  versioninfo version, VOS__WINDOWS32, VFT_DRV, VFT2_UNKNOWN,\
        LANG_RUSSIAN + SUBLANG_DEFAULT, 0,\
        'Comments', 'Сделано в Казахстане',\
        'CompanyName', 'Танат',\
	      'FileDescription', 'Драйвер режима ядра',\
	      'LegalCopyright', 'Альпенов Танат Маратович',\
	      'FileVersion', '1.0',\
	      'ProductVersion', '1.0',\
	      'OriginalFilename', 'sYs.sys'     
        
section '.reloc' data fixups readable discardable