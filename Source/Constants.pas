unit Constants;

interface

uses
  Windows,
  Messages,
  SysUtils;

const
  WM_LOADFILE = WM_USER + 100;
  WM_UPDATEEXPLORER_VAR = WM_USER + 200;
  WM_SYN_INSERT_MODE = WM_USER + 300;
  WM_GOTO_VAR_AT_MOUSE = WM_USER + 400;
  WM_EDIT_STATUS_CHANGE = WM_USER + 500;

  MAIN_FORM = 'TFormEditor';

function GetMainFormHandle: HWND;
function GetFullPath(const Path: AnsiString): AnsiString;

implementation

function GetMainFormHandle: HWND;
begin
  Result := FindWindow(MAIN_FORM, nil);
end;

function GetFullPath(const Path: AnsiString): AnsiString;
var
  fName: PAnsiChar;
  FPath: array [0 .. 255] of AnsiChar;
  S: AnsiString;
begin
  ZeroMemory(@FPath, SizeOf(FPath));
  if ExtractFileDrive(Path) = '' then
    S := 'C:\' + Trim(Path)
  else
    S := Trim(Path);

  GetFullPathNameA(PAnsiChar(S), SizeOf(FPath), @FPath, fName);
  Result := StrPas(PAnsiChar(@FPath));
end;

end.
