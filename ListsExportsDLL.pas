unit ListsExportsDLL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SynEdit, SynMemo, Buttons, ComCtrls,
  ImgList, System.ImageList, Vcl.ToolWin;

type
  TFormListsExportsDLL = class(TForm)
    SynMemoExp: TSynMemo;
    StatusBar: TStatusBar;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ImageList: TImageList;
    ToolBar: TToolBar;
    ToolButtonOpen: TToolButton;
    ToolButtonSearch: TToolButton;
    ToolButtonSave: TToolButton;
    ToolButtonClear: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    PathLabel: TLabel;
    PathEdit: TEdit;
    ToolButton1: TToolButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SynMemoExpGutterGetText(Sender: TObject; aLine: Integer;
      var aText: string);
    procedure PathEditChange(Sender: TObject);
    procedure SynMemoExpStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure ToolButtonOpenClick(Sender: TObject);
    procedure ToolButtonSearchClick(Sender: TObject);
    procedure ToolButtonSaveClick(Sender: TObject);
    procedure ToolButtonClearClick(Sender: TObject);
  private
    procedure GetListsExport32;
    procedure GetListsExport64;
  public
    { Public declarations }
  end;

var
  FormListsExportsDLL: TFormListsExportsDLL;

implementation

uses Options;

{$R *.dfm}

const
  IMAGE_NT_OPTIONAL_HDR32_MAGIC = $10B;
  IMAGE_NT_OPTIONAL_HDR64_MAGIC = $20B;

var
  F: TFileStream;
  DataDirectoryVirtualAddress: DWORD;
  NumberOfSections, NumberOfNames: Integer;
  VirtualAddress: Integer;
  NameF: Integer;
  Buf: array [0 .. 255] of AnsiChar;
  ActiveCaretY: Integer = 0;

var
  IMAGE_DOS_HEADER: _IMAGE_DOS_HEADER;
  IMAGE_NT_HEADERS: _IMAGE_NT_HEADERS;
  IMAGE_SECTION_HEADER: _IMAGE_SECTION_HEADER;
  IMAGE_EXPORT_DIRECTORY: _IMAGE_EXPORT_DIRECTORY;

type
  _IMAGE_OPTIONAL_HEADER64 = packed record
    { Standard fields. }
    Magic: WORD;
    MajorLinkerVersion: BYTE;
    MinorLinkerVersion: BYTE;
    SizeOfCode: DWORD;
    SizeOfInitializedData: DWORD;
    SizeOfUninitializedData: DWORD;
    AddressOfEntryPoint: DWORD;
    BaseOfCode: DWORD;
    { NT additional fields. }
    ImageBase: UInt64;
    SectionAlignment: DWORD;
    FileAlignment: DWORD;
    MajorOperatingSystemVersion: WORD;
    MinorOperatingSystemVersion: WORD;
    MajorImageVersion: WORD;
    MinorImageVersion: WORD;
    MajorSubsystemVersion: WORD;
    MinorSubsystemVersion: WORD;
    Win32VersionValue: DWORD;
    SizeOfImage: DWORD;
    SizeOfHeaders: DWORD;
    CheckSum: DWORD;
    Subsystem: WORD;
    DllCharacteristics: WORD;
    SizeOfStackReserve: UInt64;
    SizeOfStackCommit: UInt64;
    SizeOfHeapReserve: UInt64;
    SizeOfHeapCommit: UInt64;
    LoaderFlags: DWORD;
    NumberOfRvaAndSizes: DWORD;
    DataDirectory: packed array [0 .. IMAGE_NUMBEROF_DIRECTORY_ENTRIES - 1]
      of _IMAGE_DATA_DIRECTORY;
  end;

  _IMAGE_NT_HEADERS64 = packed record
    Signature: DWORD;
    FileHeader: _IMAGE_FILE_HEADER;
    OptionalHeader: _IMAGE_OPTIONAL_HEADER64;
  end;

var
  IMAGE_NT_HEADERS2: _IMAGE_NT_HEADERS64;

procedure TFormListsExportsDLL.PathEditChange(Sender: TObject);
begin
  StatusBar.Panels[0].Text := 'Файл: ' + ExtractFileName(PathEdit.Text);
end;

procedure TFormListsExportsDLL.FormShow(Sender: TObject);
begin
  SynMemoExp.Highlighter := FormOptions.MySynAsmSyn;
  SynMemoExp.Options := FormOptions.SynMemoOpt.Options;
end;

procedure TFormListsExportsDLL.GetListsExport32;
label
  Error;

var
  lpName, Position: Cardinal;
  S, S2, S3: string;
begin
  DataDirectoryVirtualAddress := 0;
  NumberOfSections := 0;
  NumberOfNames := 0;
  VirtualAddress := 0;
  NameF := 0;

  ZeroMemory(@Buf, 255);
  ZeroMemory(@IMAGE_DOS_HEADER, SizeOf(IMAGE_DOS_HEADER));
  ZeroMemory(@IMAGE_NT_HEADERS, SizeOf(IMAGE_NT_HEADERS));
  ZeroMemory(@IMAGE_SECTION_HEADER, SizeOf(IMAGE_SECTION_HEADER));
  ZeroMemory(@IMAGE_EXPORT_DIRECTORY, SizeOf(IMAGE_EXPORT_DIRECTORY));

  F := TFileStream.Create(PathEdit.Text, fmOpenRead);

  F.Read(IMAGE_DOS_HEADER, SizeOf(IMAGE_DOS_HEADER));
  if IMAGE_DOS_HEADER.e_magic <> IMAGE_DOS_SIGNATURE then
  begin
    SynMemoExp.Lines.Add('; Косяк!');
    goto Error;
  end;

  F.Seek(IMAGE_DOS_HEADER._lfanew, soBeginning);
  F.Read(IMAGE_NT_HEADERS, SizeOf(IMAGE_NT_HEADERS));
  if IMAGE_NT_HEADERS.Signature <> IMAGE_NT_SIGNATURE then
  begin
    SynMemoExp.Lines.Add('; Косяк!');
    goto Error;
  end;

  DataDirectoryVirtualAddress := IMAGE_NT_HEADERS.OptionalHeader.DataDirectory
    [0].VirtualAddress;
  NumberOfSections := IMAGE_NT_HEADERS.FileHeader.NumberOfSections;

  repeat
    Dec(NumberOfSections);
    if NumberOfSections < 0 then
    begin
      SynMemoExp.Lines.Add('; Косяк!');
      goto Error;
    end;

    F.Read(IMAGE_SECTION_HEADER, SizeOf(IMAGE_SECTION_HEADER));
    VirtualAddress := IMAGE_SECTION_HEADER.VirtualAddress;

    if VirtualAddress > DataDirectoryVirtualAddress then
      Continue;

    Inc(VirtualAddress, IMAGE_SECTION_HEADER.SizeOfRawData);

  until VirtualAddress > DataDirectoryVirtualAddress;

  Dec(DataDirectoryVirtualAddress, IMAGE_SECTION_HEADER.VirtualAddress);
  Inc(DataDirectoryVirtualAddress, IMAGE_SECTION_HEADER.PointerToRawData);

  F.Seek(DataDirectoryVirtualAddress, soBeginning);
  F.Read(IMAGE_EXPORT_DIRECTORY, SizeOf(IMAGE_EXPORT_DIRECTORY));

  NameF := IMAGE_EXPORT_DIRECTORY.Name;
  Dec(NameF, IMAGE_SECTION_HEADER.VirtualAddress);
  Inc(NameF, IMAGE_SECTION_HEADER.PointerToRawData);

  F.Seek(NameF, soBeginning);
  F.Read(Buf, 255);

  S2 := LowerCase(string(Buf));
  S3 := Copy(S2, 1, Pos('.', S2) - 1);
  S := 'library ' + S3 + ',' + #39 + S2 + #39;

  SynMemoExp.Lines.Add(S);
  SynMemoExp.Lines.Add('import ' + S3 + ',\');

  Position := Cardinal(IMAGE_EXPORT_DIRECTORY.AddressOfNames);
  Dec(Position, IMAGE_SECTION_HEADER.VirtualAddress);
  Inc(Position, IMAGE_SECTION_HEADER.PointerToRawData);

  NumberOfNames := IMAGE_EXPORT_DIRECTORY.NumberOfNames;
  StatusBar.Panels[1].Text := 'Кол. функций: ' + IntToStr(NumberOfNames);

  repeat
    Dec(NumberOfNames);
    if NumberOfNames < 0 then
    begin
      SynMemoExp.Lines.Add('; Косяк!');
      goto Error;
    end;

    F.Seek(Position, soBeginning);
    Inc(Position, 4);
    F.Read(lpName, 4);

    Dec(lpName, IMAGE_SECTION_HEADER.VirtualAddress);
    Inc(lpName, IMAGE_SECTION_HEADER.PointerToRawData);

    F.Seek(lpName, soBeginning);
    F.Read(Buf, 255);

    S2 := string(Buf);

    if NumberOfNames = 0 then
      S := '       ' + S2 + ',' + #39 + S2 + #39
    else
      S := '       ' + S2 + ',' + #39 + S2 + #39 + ',\';

    SynMemoExp.Lines.Add(S);

  until NumberOfNames = 0;

  SynMemoExp.SetFocus;

Error:
  FreeAndNil(F);
end;

procedure TFormListsExportsDLL.GetListsExport64;
label
  Error;

var
  lpName, Position: UInt64;
  S, S2, S3: string;
begin
  DataDirectoryVirtualAddress := 0;
  NumberOfSections := 0;
  NumberOfNames := 0;
  VirtualAddress := 0;
  NameF := 0;

  ZeroMemory(@Buf, 255);
  ZeroMemory(@IMAGE_DOS_HEADER, SizeOf(IMAGE_DOS_HEADER));
  ZeroMemory(@IMAGE_NT_HEADERS2, SizeOf(IMAGE_NT_HEADERS2));
  ZeroMemory(@IMAGE_SECTION_HEADER, SizeOf(IMAGE_SECTION_HEADER));
  ZeroMemory(@IMAGE_EXPORT_DIRECTORY, SizeOf(IMAGE_EXPORT_DIRECTORY));

  F := TFileStream.Create(PathEdit.Text, fmOpenRead);

  F.Read(IMAGE_DOS_HEADER, SizeOf(IMAGE_DOS_HEADER));
  if IMAGE_DOS_HEADER.e_magic <> IMAGE_DOS_SIGNATURE then
  begin
    SynMemoExp.Lines.Add('; Косяк!');
    goto Error;
  end;

  F.Seek(IMAGE_DOS_HEADER._lfanew, soBeginning);
  F.Read(IMAGE_NT_HEADERS2, SizeOf(IMAGE_NT_HEADERS2));
  if IMAGE_NT_HEADERS2.Signature <> IMAGE_NT_SIGNATURE then
  begin
    SynMemoExp.Lines.Add('; Косяк!');
    goto Error;
  end;

  DataDirectoryVirtualAddress := IMAGE_NT_HEADERS2.OptionalHeader.DataDirectory[0].VirtualAddress;
  NumberOfSections := IMAGE_NT_HEADERS2.FileHeader.NumberOfSections;

  repeat
    Dec(NumberOfSections);
    if NumberOfSections < 0 then
    begin
      SynMemoExp.Lines.Add('; Косяк!');
      goto Error;
    end;

    F.Read(IMAGE_SECTION_HEADER, SizeOf(IMAGE_SECTION_HEADER));
    VirtualAddress := IMAGE_SECTION_HEADER.VirtualAddress;

    if VirtualAddress > DataDirectoryVirtualAddress then
      Continue;

    Inc(VirtualAddress, IMAGE_SECTION_HEADER.SizeOfRawData);

  until VirtualAddress > DataDirectoryVirtualAddress;

  Dec(DataDirectoryVirtualAddress, IMAGE_SECTION_HEADER.VirtualAddress);
  Inc(DataDirectoryVirtualAddress, IMAGE_SECTION_HEADER.PointerToRawData);

  F.Seek(DataDirectoryVirtualAddress, soBeginning);
  F.Read(IMAGE_EXPORT_DIRECTORY, SizeOf(IMAGE_EXPORT_DIRECTORY));

  NameF := IMAGE_EXPORT_DIRECTORY.Name;
  Dec(NameF, IMAGE_SECTION_HEADER.VirtualAddress);
  Inc(NameF, IMAGE_SECTION_HEADER.PointerToRawData);

  F.Seek(NameF, soBeginning);
  F.Read(Buf, 255);

  S2 := LowerCase(string(Buf));
  S3 := Copy(S2, 1, Pos('.', S2) - 1);
  S := 'library ' + S3 + ',' + #39 + S2 + #39;

  SynMemoExp.Lines.Add(S);
  SynMemoExp.Lines.Add('import ' + S3 + ',\ ');

  Position := Cardinal(IMAGE_EXPORT_DIRECTORY.AddressOfNames);
  Dec(Position, IMAGE_SECTION_HEADER.VirtualAddress);
  Inc(Position, IMAGE_SECTION_HEADER.PointerToRawData);

  NumberOfNames := IMAGE_EXPORT_DIRECTORY.NumberOfNames;

  NumberOfNames := IMAGE_EXPORT_DIRECTORY.NumberOfNames;
  StatusBar.Panels[1].Text := 'Кол. функций: ' + IntToStr(NumberOfNames);

  repeat
    Dec(NumberOfNames);
    if NumberOfNames < 0 then
    begin
      SynMemoExp.Lines.Add('; Косяк!');
      goto Error;
    end;

    F.Seek(Position, soBeginning);
    Inc(Position, 4);
    F.Read(lpName, 4);

    Dec(lpName, IMAGE_SECTION_HEADER.VirtualAddress);
    Inc(lpName, IMAGE_SECTION_HEADER.PointerToRawData);

    F.Seek(lpName, soBeginning);
    F.Read(Buf, 255);

    S2 := string(Buf);

    if NumberOfNames = 0 then
      S := '       ' + S2 + ',' + #39 + S2 + #39
    else
      S := '       ' + S2 + ',' + #39 + S2 + #39 + ',\';

    SynMemoExp.Lines.Add(S);

  until NumberOfNames = 0;

Error:
  FreeAndNil(F);
end;

procedure TFormListsExportsDLL.SynMemoExpGutterGetText(Sender: TObject;
  aLine: Integer; var aText: string);
begin
  if ((aLine mod 10) = 0) or (aLine = 1) or (aLine = ActiveCaretY) then
    aText := IntToStr(aLine)
  else if (aLine mod 5) = 0 then
    aText := '-'
  else
    aText := '.';
end;

procedure TFormListsExportsDLL.SynMemoExpStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if Changes * [scCaretX, scCaretY] <> [] then
  begin
    StatusBar.Panels[2].Text := IntToStr(SynMemoExp.CaretY) + ': ' +
      IntToStr(SynMemoExp.CaretX);
  end;

  if Changes * [scCaretY] <> [] then
  begin
    SynMemoExp.InvalidateGutterLine(ActiveCaretY);
    ActiveCaretY := SynMemoExp.CaretY;
    SynMemoExp.InvalidateGutterLine(ActiveCaretY);
  end;
end;

procedure TFormListsExportsDLL.ToolButtonOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    PathEdit.Text := OpenDialog.FileName;
end;

procedure TFormListsExportsDLL.ToolButtonSearchClick(Sender: TObject);
label
  Error;

var
  I: Integer;
begin
  if not FileExists(PathEdit.Text) then
  begin
    MessageBoxA(Handle, 'Файл не найден!', 'Ошибка!', MB_ICONERROR or MB_OK);
    Exit;
  end;

  I := 0;

  if SynMemoExp.Lines.Count > 1 then
  begin
    SynMemoExp.Lines.Add('');
    SynMemoExp.Lines.Add
      (';===============================================================================');
    SynMemoExp.Lines.Add('');

    I := SynMemoExp.Lines.Count - 1;
  end;

  F := TFileStream.Create(PathEdit.Text, fmOpenRead);

  F.Read(IMAGE_DOS_HEADER, SizeOf(IMAGE_DOS_HEADER));
  if IMAGE_DOS_HEADER.e_magic <> IMAGE_DOS_SIGNATURE then
  begin
    SynMemoExp.Lines.Add('; Косяк!');
    goto Error;
  end;

  F.Seek(IMAGE_DOS_HEADER._lfanew, soBeginning);
  F.Read(IMAGE_NT_HEADERS2, SizeOf(IMAGE_NT_HEADERS2));
  if IMAGE_NT_HEADERS2.Signature <> IMAGE_NT_SIGNATURE then
  begin
    SynMemoExp.Lines.Add('; Косяк!');
    goto Error;
  end;

  case IMAGE_NT_HEADERS2.OptionalHeader.Magic of
    IMAGE_NT_OPTIONAL_HDR32_MAGIC:
      begin
        FreeAndNil(F);
        SynMemoExp.Lines.Add('; PE32');
        SynMemoExp.Lines.Add('');
        StatusBar.Panels[3].Text := 'Тип: PE32';
        GetListsExport32;
      end;

    IMAGE_NT_OPTIONAL_HDR64_MAGIC:
      begin
        FreeAndNil(F);
        SynMemoExp.Lines.Add('; PE64');
        SynMemoExp.Lines.Add('');
        StatusBar.Panels[3].Text := 'Тип: PE64';
        GetListsExport64;
      end;

  else
    SynMemoExp.Lines.Add('; Косяк!');
  end;

  if I > 0 then
    SynMemoExp.GotoLineAndCenter(I);

Error:
  FreeAndNil(F);
end;

procedure TFormListsExportsDLL.ToolButtonSaveClick(Sender: TObject);
var
  S, S2: string;
begin
  if SynMemoExp.Lines.Text = '' then
    Exit;

  S2 := ExtractFileName(PathEdit.Text);
  S := Copy(S2, 1, Pos('.', S2) - 1) + '.inc';

  SaveDialog.FileName := S;
  if SaveDialog.Execute then
    SynMemoExp.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TFormListsExportsDLL.ToolButtonClearClick(Sender: TObject);
begin
  SynMemoExp.Lines.Clear;
  with StatusBar do
  begin
    Panels[1].Text := 'Кол. функций:';
    Panels[3].Text := 'Тип:';
  end;
end;

end.
