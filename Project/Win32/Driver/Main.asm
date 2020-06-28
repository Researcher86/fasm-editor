format PE native 4.0 at 10000h
entry DriverEntry

include 'win32a.inc'
include 'ENCODING\WIN1251.INC'
include 'DDK\structs.inc'
include 'DDK\macros.inc'
include 'DDK\ntstatus.inc'
include 'DDK\ntddk.inc'
include 'DDK\stuff.inc'

       
section '.text' code readable executable notpageable

;===============================================================================

proc DriverEntry pDriverObject, usRegistryPath
;-------------------------------------------------------------------------------
  locals
    status	      dd ?
    pDeviceObject dd ?
  endl
;-------------------------------------------------------------------------------

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
  
DriverEntryExit:
	mov	eax, [status]
	ret
endp

;===============================================================================

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
  
  invoke DbgPrint, dbgDispatchCreateClose
  
	ret
endp

;===============================================================================

proc DispatchControl pDeviceObject, pIrp

  invoke DbgPrint, dbgDispatchControl
  
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
        
section '.reloc' data fixups readable discardable