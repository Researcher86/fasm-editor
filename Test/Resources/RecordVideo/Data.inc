HORZRES    = 8
VERTRES    = 10
BITSPIXEL  = 12

pfile iAVIFILE
asiInfo AVISTREAMINFOA
Stream iAVISTREAM
CompressedStream iAVISTREAM
opts  AVICOMPRESSOPTIONS

struct RGBQUAD
  rgbBlue     db ?
  rgbGreen    db ?                             
  rgbRed      db ?
  rgbReserved db ?
ends

struct BITMAPINFO
  bmiHeader BITMAPINFOHEADER
  bmiColors RGBQUAD
ends


bits             dd ?
compfccHandler   dd ?
recordstate      db 0         ;: boolean;
maxxScreen       dd ?
maxyScreen       dd ?

PlaybackFPS        dd ?
mspFRecord         dd ?
KeyFramesEvery     dd ?
selectedCompressor dd ?
CompressionQuality dd ?
CompressorCount    dd 0
hCursor            dd ?
hScreenDC          dd ?           
