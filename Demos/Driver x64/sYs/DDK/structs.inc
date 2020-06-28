; some Win32 (ring-3) defines not avalible in standart FASM includes
; Converted to FASM syntax by Ct757 
;
; VERSION:              0.01
; LAST UPDATE:      08.07.06
;
; WWW:   http://ct757.net.ru
; MAIL:     ct757-at-mail.ru

IMAGE_DIRECTORY_ENTRY_EXPORT		    = 00
IMAGE_DIRECTORY_ENTRY_IMPORT		    = 01
IMAGE_DIRECTORY_ENTRY_RESOURCE		    = 02
IMAGE_DIRECTORY_ENTRY_EXCEPTION 	    = 03
IMAGE_DIRECTORY_ENTRY_SECURITY		    = 04
IMAGE_DIRECTORY_ENTRY_BASERELOC 	    = 05
IMAGE_DIRECTORY_ENTRY_DEBUG		    = 06
IMAGE_DIRECTORY_ENTRY_COPYRIGHT 	    = 07
IMAGE_DIRECTORY_ENTRY_GLOBALPTR 	    = 08
IMAGE_DIRECTORY_ENTRY_TLS		    = 09
IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG	    = 10
IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT	    = 11
IMAGE_DIRECTORY_ENTRY_IAT		    = 12

IMAGE_NUMBEROF_DIRECTORY_ENTRIES	    = 16

;MAX_PATH = 255

struct LIST_ENTRY
    Flink dd ?
    Blink dd ?
ends

struct SINGLE_LIST_ENTRY
    Next  dd ?
ends

struct GUID
    Data1	dd ?
    Data2	dw ?
    Data3	dw ?
    Data4	db 8 dup(?)
ends

struct LARGE_INTEGER
   LowPart   dd ?
   HighPart   dd ?
ends

struct OBJECTID
    Lineage	    GUID
    Uniquifier	    dd ?
ends

struct SERVICE_STATUS 
 dwServiceType	       dd ?
 dwCurrentState        dd ? 
 dwControlsAccepted    dd ?  
 dwWin32ExitCode       dd ?  
 dwServiceSpecificExitCode dd ?  
 dwCheckPoint	       dd ? 
 dwWaitHint	       dd ?
ends

;struct WIN32_FIND_DATA
; dwFileAttributes	 dd	 ?
; ftCreationTime	 FILETIME
; ftLastAccessTime	 FILETIME
; ftLastWriteTime	 FILETIME
; nFileSizeHigh  dd	 ?
; nFileSizeLow	 dd	 ?
; dwReserved0		 dd	 ?
; dwReserved1		 dd	 ?
; cFileName		 rb	 MAX_PATH
; cAlternate		 rb	 14
;ends

struct SECURITY_ATTRIBUTES
  nLength		dd	?
  lpSecurityDescriptor	dd	?
  bInheritHandle	dd	?
ends

struct FLOATING_SAVE_AREA
  ControlWord	dd	?
  StatusWord	dd	?
  TagWord	dd	?
  ErrorOffset	dd	?
  ErrorSelector dd	?
  DataOffset	dd	?
  DataSelector	dd	?
  RegisterArea	db  SIZE_OF_80387_REGISTERS dup(?)
  Cr0NpxState	dd	?
ends

struct SEH
  PrevLink dd ?    ; адрес предыдущего SEH-фрейма
  CurrentHandler dd ?	 ; адрес обработчика исключений
  SafeOffset dd ?    ; Смещение безопасного места
  PrevEsp dd ?	    ; Старое значение esp
  PrevEbp dd ?	   ; Старое значение ebp
ends

struct CONTEXT
  ContextFlags	dd	?
  iDr0		dd	?
  iDr1		dd	?
  iDr2		dd	?
  iDr3		dd	?
  iDr6		dd	?
  iDr7		dd	?
  FloatSave	FLOATING_SAVE_AREA <>
  regGs 	dd	?
  regFs 	dd	?
  regEs 	dd	?
  regDs 	dd	?
  regEdi	dd	?
  regEsi	dd	?
  regEbx	dd	?
  regEdx	dd	?
  regEcx	dd	?
  regEax	dd	?
  regEbp	dd	?
  regEip	dd	?
  regCs 	dd	?
  regFlag	dd	?
  regEsp	dd	?
  regSs 	dd	?
  ExtendedRegisters db MAXIMUM_SUPPORTED_EXTENSION dup(?)
ends

struct MODULEENTRY32
  dwSize	  dd ?
  th32ModuleID	  dd ?
  h32ProcessID	  dd ?
  GlblcntUsage	  dd ?
  ProccntUsage	  dd ?
  modBaseAddr	  dd ?
  modBaseSize	  dd ?
  hModule	  dd ?
  szModule	  db MAX_MODULE_NAME32+1 dup(?)
  szExePath	  db MAX_PATH dup(?)
ends

struct PROCESSENTRY32
  dwSize	      dd ?
  cntUsage	      dd ?
  th32ProcessID       dd ?
  th32DefaultHeapID   dd ?
  th32ModuleID	      dd ?
  cntThreads	      dd ?
  th32ParentProcessID dd ?
  pcPriClassBase      dd ?
  dwFlags	      dd ?
  szExeFile	      db MAX_PATH dup(?)
ends

struct IMAGE_FILE_HEADER
  Machine		 dw    ?
  NumberOfSections	 dw    ?
  TimeDateStamp  dd    ?
  PointerToSymbolTable	dd    ?
  NumberOfSymbols	 dd    ?
  SizeOfOptionalHeader	dw    ?
  Characteristics	 dw    ?
ends

struct IMAGE_SECTION_HEADER
  Name1 rb IMAGE_SIZEOF_SHORT_NAME
label PhysicalAddress dword
    VirtualSize dd ?
  VirtualAddress dd	   ?
  SizeOfRawData dd	   ?
  PointerToRawData dd	   ?
  PointerToRelocations dd ?
  PointerToLinenumbers dd ?
  NumberOfRelocations dw  ?
  NumberOfLinenumbers dw  ?
  Characteristics dd	   ?
ends

struct IMAGE_DOS_HEADER
  e_magic	     dw    ?
  e_cblp	     dw    ?
  e_cp	     dw    ?
  e_crlc	     dw    ?
  e_cparhdr	     dw    ?
  e_minalloc	     dw    ?
  e_maxalloc	     dw      ?
  e_ss	     dw      ?
  e_sp	     dw      ?
  e_csum	     dw      ?
  e_ip	     dw      ?
  e_cs	     dw      ?
  e_lfarlc	     dw      ?
  e_ovno	     dw      ?
  e_res      dw  4 dup (?)
  e_oemid	     dw      ?
  e_oeminfo	     dw      ?
  e_res2	     dw  10 dup (?)
  e_lfanew	     dd      ?
ends

struct IMAGE_DATA_DIRECTORY
  VirtualAddress    dd	    ?
  isize      dd      ?
ends

struct IMAGE_OPTIONAL_HEADER
  Magic 		 dw	  ?
  MajorLinkerVersion		 db	  ?
  MinorLinkerVersion		 db	  ?
  SizeOfCode			 dd	 ?
  SizeOfInitializedData  dd	 ?
  SizeOfUninitializedData	 dd	 ?
  AddressOfEntryPoint		 dd	 ?
  BaseOfCode			 dd	 ?
  BaseOfData			 dd	 ?
  ImageBase			 dd	 ?
  SectionAlignment		 dd	 ?
  FileAlignment 	 dd	 ?
  MajorOperatingSystemVersion	 dw	  ?
  MinorOperatingSystemVersion	 dw	  ?
  MajorImageVersion		 dw	  ?
  MinorImageVersion		 dw	  ?
  MajorSubSystemVersion  dw	  ?
  MinorSubSystemVersion  dw	  ?
  Win32VersionValue		 dd	 ?
  SizeOfImage			 dd	 ?
  izeOfHeaders		dd	?
  CheckSum			 dd	 ?
  SubSystem			 dw	  ?
  DllCharacteristics		 dw	  ?
  SizeOfStackReserve		 dd	 ?
  SizeOfStackCommit		 dd	 ?
  SizeOfHeapReserve		 dd	 ?
  SizeOfHeapCommit		 dd	 ?
  LoaderFlags			 dd	 ?
  NumberOfRvaAndSizes		 dd	 ?
  DataDirectory 	 db sizeof.IMAGE_DATA_DIRECTORY*IMAGE_NUMBEROF_DIRECTORY_ENTRIES dup(?)
ends

struct IMAGE_NT_HEADERS
  Signature	     dd 	       ?
  FileHeader	     IMAGE_FILE_HEADER
  OptionalHeader    IMAGE_OPTIONAL_HEADER
ends

struct IMAGE_EXPORT_DIRECTORY
  Characteristics	     dd      ?
  TimeDateStamp      dd      ?
  MajorVersion	     dw      ?
  MinorVersion	     dw      ?
  nName 	     dd      ?
  nBase 	     dd      ?
  NumberOfFunctions	     dd      ?
  NumberOfNames      dd      ?
  AddressOfFunctions	     dd      ?
  AddressOfNames	     dd      ?
ends

struct IMAGE_IMPORT_DESCRIPTOR
label	Characteristics dword
    OriginalFirstThunk dd   ?
    TimeDateStamp      dd    ?
    ForwarderChain	   dd	?
    Name		  dd	?
    FirstThunk		   dd	 ?
ends

struct IMAGE_THUNK_DATA32
label ForwarderString dword
label Function dword
label Ordinal dword
      AddressOfData dd ?
ends

ExceptionContinueExecution		= 0
ExceptionContinueSearch 		= 1
ExceptionNestedException		= 2
ExceptionCollidedUnwind 		= 3

CONTEXT_i386		  = 00010000h
CONTEXT_i486		  = 00010000h
CONTEXT_CONTROL 	  = CONTEXT_i386 or 00000001h
CONTEXT_INTEGER 	  = CONTEXT_i386 or 00000002h
CONTEXT_SEGMENTS	  = CONTEXT_i386 or 00000004h
CONTEXT_FLOATING_POINT	  = CONTEXT_i386 or 00000008h
CONTEXT_DEBUG_REGISTERS   = CONTEXT_i386 or 00000010h
CONTEXT_FULL		  = CONTEXT_CONTROL or CONTEXT_INTEGER or CONTEXT_SEGMENTS

TH32CS_SNAPHEAPLIST	= 1
TH32CS_SNAPPROCESS	= 2
TH32CS_SNAPTHREAD	= 4
TH32CS_SNAPMODULE	= 8
TH32CS_SNAPALL		= TH32CS_SNAPHEAPLIST + TH32CS_SNAPPROCESS + TH32CS_SNAPTHREAD + TH32CS_SNAPMODULE
TH32CS_INHERIT		= 80000000h
HF32_DEFAULT		= 1 
HF32_SHARED		= 2
LF32_FIXED		= 1
LF32_FREE		= 2
LF32_MOVEABLE		= 4

IMAGE_DIRECTORY_ENTRY_EXPORT		    =  0
IMAGE_DIRECTORY_ENTRY_IMPORT		    =  1
IMAGE_DIRECTORY_ENTRY_RESOURCE		    =  2
IMAGE_DIRECTORY_ENTRY_EXCEPTION 	    =  3
IMAGE_DIRECTORY_ENTRY_SECURITY		    =  4
IMAGE_DIRECTORY_ENTRY_BASERELOC 	    =  5
IMAGE_DIRECTORY_ENTRY_DEBUG =  6
IMAGE_DIRECTORY_ENTRY_COPYRIGHT 	    =  7
IMAGE_DIRECTORY_ENTRY_GLOBALPTR 	    =  8
IMAGE_DIRECTORY_ENTRY_TLS   =  9
IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG	    = 10
IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT	    = 11
IMAGE_DIRECTORY_ENTRY_IAT   = 12
IMAGE_BITMAP		    = 0
IMAGE_ICON		    = 1
IMAGE_CURSOR		    = 2
IMAGE_ENHMETAFILE	    = 3
PROCESSOR_INTEL_386	    = 386
PROCESSOR_INTEL_486	    = 486
PROCESSOR_INTEL_PENTIUM     = 586
PROCESSOR_MIPS_R4000	    = 4000
PROCESSOR_ALPHA_21064	    = 21064

EXCEPTION_CONTINUE_SEARCH		=  0

MAXIMUM_SUPPORTED_EXTENSION	 = 512

SIZE_OF_80387_REGISTERS 	 = 80

;MAX_PATH			 = 260
MAX_MODULE_NAME32		 = 255

IMAGE_SIZEOF_SHORT_NAME 	 = 8
IMAGE_NUMBEROF_DIRECTORY_ENTRIES = 16