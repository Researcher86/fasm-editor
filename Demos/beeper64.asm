; the most simple win64 "driver" with IMPORT section for call API
; when started (use start_drv.exe) it produce a beep
; it can't be stopped because it hasn't implemented procedure for stop
; so if you want to use it again, you must reboot win64

format PE64 native 5.02 at 10000h
entry start


section '.text' code readable executable notpageable

start:
; rcx=pDriverObject rdx=pDriverPath

	mov	ecx,620h
	call	qword [HalMakeBeep]
	mov	eax,20000000h
delay_loop:
	dec	rax
	or	rax,rax
; it's enough to use dec eax... but we used 2 instructions for slow-down the loop
	jnz	delay_loop
	xor	ecx,ecx
	call	qword [HalMakeBeep]

	xor	eax,eax			; success exit code

	ret


section '.rdata' readable notpageable

data 12

ImportLookup:
HalMakeBeep		dq	rva szHalmakebeep
			dq	0

end data


section 'INIT' data import readable notpageable
			dd	rva ImportAddress
			dd	0
			dd	0
			dd	rva szHal_dll
			dd	rva ImportLookup
		times 5	dd	0

ImportAddress		dq	rva szHalmakebeep
			dq	0

szHalmakebeep		dw	0
			db	'HalMakeBeep',0

szHal_dll		db	'HAL.dll',0