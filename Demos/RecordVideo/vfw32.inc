streamtypeVIDEO         = 1935960438
AVICOMPRESSF_INTERLEAVE = $00000001
AVICOMPRESSF_DATARATE   = $00000002
AVICOMPRESSF_KEYFRAMES  = $00000004
AVICOMPRESSF_VALID      = $00000008       
                                                
;struct TICINFO
;  dwSize        dd ?
;  fccType       dd ?                  
;  fccHandler    dd ?
;  dwFlags       dd ?
;  dwVersion     dd ?
;  dwVersionICM  dd ?
;  szName        dw 16  dup (?)
;  szDescription dw 128 dup (?)
;  szDriver      dw 128 dup (?)
;ends

;struct AVIStreamHeader
;  fccType               dd ?
;  fccHandler            dd ?
;  dwFlags               dd ?
;  wPriority             dw ?
;  wLanguage             dw ?
;  dwInitialFrames       dd ?
;  dwScale               dd ?
;  dwRate                dd ?
;  dwStart               dd ?
;  dwLength              dd ?
;  dwSuggestedBufferSize dd ?
;  dwQuality             dd ?
;  dwSampleSize          dd ?
;  rcFrame               RECT
;ends
                                                  
struct AVISTREAMINFOA
  fccType               dd ?
  fccHandler            dd ?                      
  dwFlags               dd ?
  dwCaps                dd ?
  wPriority             dw ?
  wLanguage             dw ?
  dwScale               dd ?
  dwRate                dd ?
  dwStart               dd ?
  dwLength              dd ?
  dwInitialFrames       dd ?
  dwSuggestedBufferSize dd ?
  dwQuality             dd ?
  dwSampleSize          dd ?
  rcFrame               RECT
  dwEditCount           dd ?
  dwFormatChangeCount   dd ?
  szName                db 64 dup (0)
ends
                                               
;struct AVISTREAMINFOW
;  fccType               dd ?
;  fccHandler            dd ?
;  dwFlags               dd ?
;  dwCaps                dd ?
;  wPriority             dw ?
;  wLanguage             dw ?
;  dwScale               dd ?
;  dwRate                dd ?
;  dwStart               dd ?
;  dwLength              dd ?
;  dwInitialFrames       dd ?
;  dwSuggestedBufferSize dd ?
;  dwQuality             dd ?
;  dwSampleSize          dd ?
;  rcFrame               RECT
;  dwEditCount           dd ?
;  dwFormatChangeCount   dd ?
;  szName                dw 64 dup (0)
ends

struct AVICOMPRESSOPTIONS
  fccType           dd ?
  fccHandler        dd ?
  dwKeyFrameEvery   dd ?
  dwQuality         dd ?
  dwBytesPerSecond  dd ?
  dwFlags           dd ?
  lpFormat          dd ?
  cbFormat          dd ?
  lpParms           dd ?
  cbParms           dd ?
  dwInterleaveEvery dd ?
ends

;struct AVIFILEINFOA
;  dwMaxBytesPerSec      dd ?
;  dwFlags               dd ?
;  dwCaps                dd ?
;  dwStreams             dd ?
;  dwSuggestedBufferSize dd ?
;  dwWidth               dd ?
;  dwHeight              dd ?
;  dwScale               dd ?
;  dwRate                dd ?
;  dwLength              dd ?
;  dwEditCount           dd ?
;  szFileType            db 64 dup (0); : array [0 .. 63] of AnsiChar;
;ends

;struct iAVIFILE
;	CreateStream dd ?
;	EndRecord		 dd ?
;	GetStream		 dd ?
;	Info			   dd ?
;	Open			   dd ?
;	ReadData		 dd ?
;	WriteData		 dd ?
;ends

struct iAVIFILE
	Info			   dd ?
	GetStream		 dd ?
	CreateStream dd ?
	WriteData		 dd ?
	ReadData		 dd ?
	EndRecord		 dd ?
	DeleteStream dd ?
ends

struct iAVISTREAM
  Create     dd ?
  Info       dd ?
  FindSample dd ?
  ReadFormat dd ?
  SetFormat  dd ?
  Read       dd ?
  Write      dd ?
  Delete     dd ?
  ReadData   dd ?
  WriteData  dd ?
  SetInfo    dd ?
ends

;struct WAVEFORMATEX
;  wFormatTag      dw ?
;  nChannels       dw ?
;  nSamplesPerSec  dd ?
;  nAvgBytesPerSec dd ?
;  nBlockAlign     dw ?
;  wBitsPerSample  dw ?
;  cbSize          dw ?
;ends

;struct TAviUtil
;	pfile 			 dd ?
;	wfx 			   WAVEFORMATEX
;	period 			 dd ?
;	as				   dd ?
;	ps			     dd ?
;	psCompressed dd ?
;	nframe			 dd ?
;	nsamp			   dd ?
;	iserr			   dd ?
;ends

;struct fAVIS
;	avihnd          dd ?
;	pAVIStream      dd ?
;	firstframe      dd ?
;	totalframe      dd ?
;	pGetFrameObject dd ?
;ends