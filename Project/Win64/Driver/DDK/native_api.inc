; some native API defines
; Converted to FASM syntax by Ct757
;
; VERSION:              0.01
; LAST UPDATE:      08.07.06
;
; WWW:   http://ct757.net.ru
; MAIL:     ct757-at-mail.ru

struct LARGE_INTEGER
  LowPart dd ?
  HighPart dd ?
ends

struct KEY_NODE_INFORMATION
  LastWriteTime   LARGE_INTEGER
  TitleIndex	  dd ?
  ClassOffset	  dd ?
  ClassLength	  dd ?
  NameLength	  dd ?
  Name		  dd ?
ends

struct KEY_BASIC_INFORMATION
  LastWriteTime   LARGE_INTEGER
  TitleIndex	  dd ?
  NameLength	  dd ?
  Name		  db ?
ends

struct KEY_FULL_INFORMATION
  LastWriteTime   LARGE_INTEGER
  TitleIndex	  dd ?
  ClassOffset	  dd ?
  ClassLength	  dd ?
  SubKeys	  dd ?
  MaxNameLen	  dd ?
  MaxClassLen	  dd ?
  Values	  dd ?
  MaxValueNameLen dd ?
  MaxValueDataLen dd ?
  Class 	  db ?
ends

KeyBasicInformation  = 0x0
KeyNodeInformation   = 0x1
KeyFullInformation   = 0x2

struct KEY_VALUE_BASIC_INFORMATION
  TitleIndex	  dd ?
  Type		  dd ?
  NameLength	  dd ?
  Name		  db ?
ends

struct KEY_VALUE_FULL_INFORMATION
  TitleIndex	  dd ?
  Type		  dd ?
  DataOffset	  dd ?
  DataLength	  dd ?
  NameLength	  dd ?
  Name		  db ?	; Variable length string
;  Data[1]               ; Variable length data not declared
ends

KeyValueBasicInformation	 = 0x0
KeyValueFullInformation 	 = 0x1
KeyValuePartialInformation	 = 0x2

struct FILE_DIRECTORY_INFORMATION
  NextEntryOffset dd ?
  Unknown	  dd ?
  CreationTime	  LARGE_INTEGER
  LastAccessTime  LARGE_INTEGER
  LastWriteTime   LARGE_INTEGER
  ChangeTime	  LARGE_INTEGER
  EndOfFile	  LARGE_INTEGER
  AllocationSize  LARGE_INTEGER
  FileAttributes  dd ?
  FileNameLength  dd ?
  FileName	  db ?
ends

struct FILE_FULL_DIRECTORY_INFORMATION
  NextEntryOffset dd ?
  Unknown	  dd ?
  CreationTime	  LARGE_INTEGER
  LastAccessTime  LARGE_INTEGER
  LastWriteTime   LARGE_INTEGER
  ChangeTime	  LARGE_INTEGER
  EndOfFile	  LARGE_INTEGER
  AllocationSize  LARGE_INTEGER
  FileAttributes       dd ?
  FileNameLength       dd ?
  EaInformationLength  dd ?
  FileName	       db ?
ends

struct FILE_BOTH_DIRECTORY_INFORMATION
  NextEntryOffset dd ?
  Unknown	  dd ?
  CreationTime	  LARGE_INTEGER
  LastAccessTime  LARGE_INTEGER
  LastWriteTime   LARGE_INTEGER
  ChangeTime	  LARGE_INTEGER
  EndOfFile	  LARGE_INTEGER
  AllocationSize  LARGE_INTEGER
  FileAttributes  dd ?
  FileNameLength  dd ?
  EaInformationLength dd ?
  AlternateNameLength dw ?
  AlternateName   dw 12 dup (?)
  FileName	  db ?
ends

struct FILE_NAMES_INFORMATION
  NextEntryOffset dd ?
  Unknown	  dd ?
  FileNameLength  dd ?
  FileName	  db ?
ends

struct SYSTEM_MODULE_INFORMATION
  Reserved	   dd 3 dup(?)
  Base		   dd ?
  Size		   dd ?
  Flags 	   dd ?
  Index 	   dw ?
  Unknown	   dw ?
  LoadCount	   dw ?
  ModuleNameOffset dw ?
  ImageName	   db 256 dup (?)
ends  


  ThreadBasicInformation	  = 00
  ThreadTimes			  = 01
  ThreadPriority		  = 02
  ThreadBasePriority		  = 03
  ThreadAffinityMask		  = 04
  ThreadImpersonationToken	  = 05
  ThreadDescriptorTableEntry	  = 06
  ThreadEnableAlignmentFaultFixup = 07
  ThreadEventPair		  = 08
  ThreadQuerySetWin32StartAddress = 09
  ThreadZeroTlsCell		  = 10
  ThreadPerformanceCount	  = 11
  ThreadAmILastThread		  = 12
  ThreadIdealProcessor		  = 13
  ThreadPriorityBoost		  = 14
  ThreadSetTlsArrayAddress	  = 15
  ThreadIsIoPending		  = 16
  ThreadHideFromDebugger	  = 17


  struct THREAD_BASIC_INFORMATION
    ExitStatus		dd ?
    TebBaseAddress	dd ?
    .ClientId:
  UniqueProcess  dd ?
  UniqueThread	 dd ?
    AffinityMask	dd ?
    Priority		dd ?
    BasePriority	dd ?
  ends 

    FileDirectoryInformation	    = 01
    FileFullDirectoryInformation    = 02
    FileBothDirectoryInformation    = 03
    FileBasicInformation	    = 04 ; wdm
    FileStandardInformation	    = 05 ; wdm
    FileInternalInformation	    = 06
    FileEaInformation		    = 07
    FileAccessInformation	    = 08
    FileNameInformation 	    = 09
    FileRenameInformation	    = 10
    FileLinkInformation 	    = 11
    FileNamesInformation	    = 12
    FileDispositionInformation	    = 13
    FilePositionInformation	    = 14 ; wdm
    FileFullEaInformation	    = 15
    FileModeInformation 	    = 16
    FileAlignmentInformation	    = 17
    FileAllInformation		    = 18
    FileAllocationInformation	    = 19
    FileEndOfFileInformation	    = 20 ; wdm
    FileAlternateNameInformation    = 21
    FileStreamInformation	    = 22
    FilePipeInformation 	    = 23
    FilePipeLocalInformation	    = 24
    FilePipeRemoteInformation	    = 25
    FileMailslotQueryInformation    = 26
    FileMailslotSetInformation	    = 27
    FileCompressionInformation	    = 28
    FileObjectIdInformation	    = 29
    FileCompletionInformation	    = 30
    FileMoveClusterInformation	    = 31
    FileQuotaInformation	    = 32
    FileReparsePointInformation     = 33
    FileNetworkOpenInformation	    = 34
    FileAttributeTagInformation     = 35
    FileTrackingInformation	    = 36
    FileIdBothDirectoryInformation  = 37
    FileIdFullDirectoryInformation  = 38
    FileValidDataLengthInformation  = 39
    FileShortNameInformation	    = 40
    FileMaximumInformation	    = 41


    SystemBasicInformation		 = 00
    SystemProcessorInformation		 = 01
    SystemPerformanceInformation	 = 02
    SystemTimeOfDayInformation		 = 03
    SystemNotImplemented1		 = 04
    SystemProcessesAndThreadsInformation = 05
    SystemCallCounts			 = 06
    SystemConfigurationInformation	 = 07
    SystemProcessorTimes		 = 08
    SystemGlobalFlag			 = 09
    SystemNotImplemented2		 = 10
    SystemModuleInformation		 = 11
    SystemLockInformation		 = 12
    SystemNotImplemented3		 = 13
    SystemNotImplemented4		 = 14
    SystemNotImplemented5		 = 15
    SystemHandleInformation		 = 16
    SystemObjectInformation		 = 17
    SystemPagefileInformation		 = 18
    SystemInstructionEmulationCounts	 = 19
    SystemInvalidInfoClass1		 = 20
    SystemCacheInformation		 = 21
    SystemPoolTagInformation		 = 22
    SystemProcessorStatistics		 = 23
    SystemDpcInformation		 = 24
    SystemNotImplemented6		 = 25
    SystemLoadImage			 = 26
    SystemUnloadImage			 = 27
    SystemTimeAdjustment		 = 28
    SystemNotImplemented7		 = 29
    SystemNotImplemented8		 = 30
    SystemNotImplemented9		 = 31
    SystemCrashDumpInformation		 = 32
    SystemExceptionInformation		 = 33
    SystemCrashDumpStateInformation	 = 34
    SystemKernelDebuggerInformation	 = 35
    SystemContextSwitchInformation	 = 36
    SystemRegistryQuotaInformation	 = 37
    SystemLoadAndCallImage		 = 38
    SystemPrioritySeparation		 = 39
    SystemNotImplemented10		 = 40
    SystemNotImplemented11		 = 41
    SystemInvalidInfoClass2		 = 42
    SystemInvalidInfoClass3		 = 43
    SystemTimeZoneInformation		 = 44
    SystemLookasideInformation		 = 45
    SystemSetTimeSlipEvent		 = 46
    SystemCreateSession 		 = 47
    SystemDeleteSession 		 = 48
    SystemInvalidInfoClass4		 = 49
    SystemRangeStartInformation 	 = 50
    SystemVerifierInformation		 = 51
    SystemAddVerifier			 = 52
    SystemSessionProcessesInformation	 = 53  