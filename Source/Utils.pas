unit Utils;

interface

uses
  Windows,
  Messages,
  Classes,
  SysUtils;

const
  WM_LOADFILE = WM_USER + 100;
  WM_UPDATEEXPLORER_VAR = WM_USER + 200;
  WM_SYN_INSERT_MODE = WM_USER + 300;
  WM_GOTO_VAR_AT_MOUSE = WM_USER + 400;
  WM_EDIT_STATUS_CHANGE = WM_USER + 500;

  MAIN_FORM = 'TFormEditor';

type
  TCustomStringList = class(TStringList)
  public
    FFile: string;
    procedure LoadFromFile(const FileName: string); overload;
  end;

function GetMainFormHandle: HWND;
function GetFullPath(const Path: AnsiString): AnsiString;
function FindFiles(const FileName: AnsiString): AnsiString;

implementation

procedure TCustomStringList.LoadFromFile(const FileName: string);
begin
  FFile := FileName;
  inherited LoadFromFile(FileName);
end;

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

function FindFiles(const FileName: AnsiString): AnsiString;
var
  SearchRec: TSearchRec;
begin
  FindFirst(FileName, faAnyFile, SearchRec);
  Result := ExtractFilePath(FileName) + SearchRec.Name;
  FindClose(SearchRec);
end;

end.
