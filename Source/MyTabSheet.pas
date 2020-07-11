unit MyTabSheet;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Menus,
  Forms,
  SynEditTypes,
  SynEdit,
  SynMemo,
  SynEditSearch,
  ComCtrls,
  ExtCtrls,
  StdCtrls,
  Graphics,
  Buttons,
  System.ImageList,
  SynEditKeyCmds,
  MySynHighlighterAsm,
  Constants,
  ScanAsmFile,
  Math,
  SynExportRTF,
  SynExportHTML;

type
  TMyTabSheet = class(TTabSheet)
  public
    fActiveCaretY: Integer;
    fFile: AnsiString;
    fSynMemo: TSynMemo;
    fSynEditSearch: TSynEditSearch;
    fPanel: TPanel;
    fComboBoxFind: TComboBox;
    fBClose: TSpeedButton;
    fBNext: TSpeedButton;
    fBFirst: TSpeedButton;
    fStatusBar: TStatusBar;
  private
    fSelectWord: string;
    fCtrl: Boolean;
    fProjectPath: AnsiString;
    procedure SetSynMemoOptions(const Value: TSynMemo);
    procedure SetFile(const Value: AnsiString);
    function GetModifi: Boolean;
    procedure StatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure BClose(Sender: TObject);
    procedure DoSearchReplaceText(const SearchText, ReplaceText: AnsiString; AReplace: Boolean; ABackwards: Boolean);
    procedure SynMemoCommandProcessed(Sender: TObject; var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
    procedure SynMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SynMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SynMemoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SynMemoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SynMemoExit(Sender: TObject);
    procedure SynMemoClick(Sender: TObject);
    procedure SynMemoGutterClick(Sender: TObject; Button: TMouseButton; X, Y, Line: Integer; Mark: TSynEditMark);
    procedure SynMemoGutterGetText(Sender: TObject; aLine: Integer; var aText: string);
    procedure SynMemoPlaceBookmark(Sender: TObject; var Mark: TSynEditMark);
    procedure ComboBoxFindDropDown(Sender: TObject);
    procedure SetModifi(const Value: Boolean);
    procedure SetSelectWord(const Value: string);
    function GetSelectedText(): string;
    procedure SynMemoDblClick(Sender: TObject);
  public
    constructor Create(AOwner: TPageControl; Images: TImageList; BookmarkImages: TImageList; PMenuEdit: TPopupMenu; FileName: AnsiString); overload;
    destructor Destroy; override;
    procedure AddSeparator(Separator: Byte);
    procedure AddOrDelSpace(AddSpace: Boolean = True);
    procedure AddOrDelComment();
    procedure RegisterSymbol(Big: Boolean = True);
    procedure SelectText(SelStart: Integer; SelEnd: Integer);
    procedure GotoVar(BeginChar: Integer; EndChar: Integer);
    procedure ExportRtf(var Rtf: TSynExporterRTF);
    procedure ExportHtml(var Html: TSynExporterHTML);
    property FilePath: AnsiString read fFile write SetFile;
    property SynMemoOptions: TSynMemo write SetSynMemoOptions;
    property Modifi: Boolean read GetModifi write SetModifi;
    procedure SaveToFile;
    procedure ProcFind(const S: string);
    procedure SearchReplaceText(const SearchText, ReplaceText: AnsiString);
    procedure SearchText(const SearchText: AnsiString);
    procedure UpdateOptions;
    procedure BFindNext(Sender: TObject);
    procedure BFindFirst(Sender: TObject);
    procedure AddFindList(const S: string);
    property SelectWord: string read fSelectWord write SetSelectWord;
    property SelectedText: string read GetSelectedText;
  end;

var
  MyTabSh: TMyTabSheet;

implementation

uses Options;

var
  FindList: TStringList;

{ TMyTabSheet }

procedure TMyTabSheet.AddSeparator(Separator: Byte);
begin
  case Separator of
    1:
      begin
        fSynMemo.SelText := #13#10 + ';===============================================================================' + #13#10;
      end;

    2:
      begin
        fSynMemo.SelText := #13#10 + ';-------------------------------------------------------------------------------' + #13#10;
      end;
  end;
end;

procedure TMyTabSheet.ExportRtf(var Rtf: TSynExporterRTF);
var
  Src: TStringList;
  S: AnsiString;
begin
  Rtf.Title := Caption;
  Rtf.Color := fSynMemo.Color;
  Rtf.Font := fSynMemo.Font;
  Rtf.ExportAsText := True;
  Rtf.Highlighter := fSynMemo.Highlighter;

  if SelectedText <> '' then
  begin
    Src := TStringList.Create;
    S := AnsiString(SelectedText);
    Src.Text := S;
    Rtf.ExportAll(Src);

    Src.Free;
  end
  else
    Rtf.ExportAll(fSynMemo.Lines);
end;

procedure TMyTabSheet.ExportHtml(var Html: TSynExporterHTML);
var
  Src: TStringList;
  S: AnsiString;
begin
  Html.Title := Caption;
  Html.Color := fSynMemo.Color;
  Html.Font := fSynMemo.Font;
  Html.ExportAsText := True;
  Html.Highlighter := fSynMemo.Highlighter;

  if SelectedText <> '' then
  begin
    Src := TStringList.Create;
    S := AnsiString(SelectedText);
    Src.Text := S;
    Html.ExportAll(Src);

    Src.Free;
  end
  else
    Html.ExportAll(fSynMemo.Lines);
end;

procedure TMyTabSheet.RegisterSymbol(Big: Boolean = True);
var
  A, B: TBufferCoord;
begin
  A := fSynMemo.BlockBegin;
  B := fSynMemo.BlockEnd;

  if Big then
    fSynMemo.SelText := UpperCase(fSynMemo.SelText)
  else
    fSynMemo.SelText := LowerCase(fSynMemo.SelText);

  fSynMemo.BlockBegin := A;
  fSynMemo.BlockEnd := B;
end;

procedure TMyTabSheet.SelectText(SelStart: Integer; SelEnd: Integer);
begin
  fSynMemo.SelStart := SelStart;
  fSynMemo.SelEnd := SelEnd;
end;

procedure TMyTabSheet.GotoVar(BeginChar: Integer; EndChar: Integer);
var
  Line: Integer;
begin
  Line := fSynMemo.CharIndexToRowCol(BeginChar).Line;
  fSynMemo.CaretY := Line - 1;
  fSynMemo.CaretY := Line;
  fSynMemo.GotoLineAndCenter(Line);

  SelectText(BeginChar, EndChar);
end;

procedure TMyTabSheet.AddOrDelSpace(AddSpace: Boolean = True);
var
  I, J, Len: Integer;
  InString, OutString: TStringList;
  Str: string;
  A, B: TBufferCoord;
begin
  InString := TStringList.Create;
  OutString := TStringList.Create;

  InString.Text := fSynMemo.SelText;
  Len := fSynMemo.SelLength;

  A := fSynMemo.BlockBegin;
  B := fSynMemo.BlockEnd;

  if AddSpace then
    for I := 0 to InString.Count - 1 do
    begin
      OutString.Add('  ' + InString.Strings[I]);
      Inc(Len, 2);
    end
  else
    for I := 0 to InString.Count - 1 do
    begin
      Str := InString.Strings[I];

      for J := 1 to 2 do
        if (Str <> '') and (Str[1] in [' ', #9]) then
        begin
          Str := Copy(Str, 2, Length(Str));
          Dec(Len);
        end;

      OutString.Add(Str);
    end;

  Str := Copy(OutString.Text, 1, Len);
  fSynMemo.SelText := Str;
  fSynMemo.BlockBegin := A;
  fSynMemo.BlockEnd := B;
  InString.Free;
  OutString.Free;
end;

procedure TMyTabSheet.AddOrDelComment();
var
  I, Len: Integer;
  InString, OutString: TStringList;
  Str: string;
  BlockBegin, BlockEnd: TBufferCoord;
begin
  InString := TStringList.Create;
  OutString := TStringList.Create;
  InString.Text := fSynMemo.SelText;
  Len := fSynMemo.SelLength;

  BlockBegin := fSynMemo.BlockBegin;
  BlockEnd := fSynMemo.BlockEnd;

  for I := 0 to InString.Count - 1 do
  begin
    Str := TrimLeft(InString.Strings[I]);
    if Str = '' then
    begin
      OutString.Add(';' + InString.Strings[I]);
      Inc(Len);
    end
    else if Str[1] = ';' then
    begin
      Str := TrimLeft(InString.Strings[I]);
      Str := Copy(Str, 2, Length(Str));
      OutString.Add(Str);
      Dec(Len);
    end
    else
    begin
      OutString.Add(';' + InString.Strings[I]);
      Inc(Len);
    end;
  end;

  Str := Copy(OutString.Text, 1, Len);
  fSynMemo.SelText := Str;
  fSynMemo.BlockBegin := BlockBegin;
  fSynMemo.BlockEnd := BlockEnd;
  InString.Free;
  OutString.Free;

  if (fSynMemo.LineText <> '') and (fSynMemo.LineText[1] = ';') then
  begin
    fSynMemo.LineText := Copy(fSynMemo.LineText, 2, fSynMemo.LineText.Length);
    fSynMemo.CaretY := fSynMemo.CaretY + 1;
  end
  else
  begin
    fSynMemo.LineText := ';' + fSynMemo.LineText;
    fSynMemo.CaretY := fSynMemo.CaretY + 1;
  end;
end;

procedure TMyTabSheet.SynMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) then
  begin
    fCtrl := True;
    if Key <> VK_CONTROL then
        fCtrl := false;
  end;
end;

procedure TMyTabSheet.SynMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  MySynAsmSyn: TMySynAsmSyn;
begin
  if Key = VK_CONTROL then
  begin
    fCtrl := False;

    MySynAsmSyn := TMySynAsmSyn(fSynMemo.Highlighter);
    fSynMemo.Cursor := crIBeam;

    if not MySynAsmSyn.equalsUnderscoreWord('') then
    begin
      MySynAsmSyn.UnderscoreWord := '';
      fSynMemo.Invalidate;
    end;
  end;

  PostMessage(GetMainFormHandle, WM_UPDATEEXPLORER_VAR, 0, 0);
end;

procedure TMyTabSheet.SynMemoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if fCtrl and (fSynMemo.WordAtMouse <> '') then
  begin
    fCtrl := False;
    PostMessage(GetMainFormHandle, WM_GOTO_VAR_AT_MOUSE, 0, 0);
  end;
end;

procedure TMyTabSheet.SynMemoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  MySynAsmSyn: TMySynAsmSyn;
begin
  MySynAsmSyn := TMySynAsmSyn(fSynMemo.Highlighter);

  if fCtrl and (fSynMemo.WordAtMouse <> '') then
  begin
    fSynMemo.Cursor := crHandPoint;

    if not MySynAsmSyn.equalsUnderscoreWord(fSynMemo.WordAtMouse) then
    begin
      MySynAsmSyn.UnderscoreWord := fSynMemo.WordAtMouse;
      fSynMemo.Invalidate;
    end;
  end;

  if fSynMemo.WordAtMouse = '' then
  begin
    fSynMemo.Cursor := crIBeam;

    if not MySynAsmSyn.equalsUnderscoreWord('') then
    begin
      MySynAsmSyn.UnderscoreWord := '';
      fSynMemo.Invalidate;
    end;
  end;
end;

procedure TMyTabSheet.SynMemoExit(Sender: TObject);
begin
  fCtrl := False;
end;

procedure TMyTabSheet.UpdateOptions;
begin
  fSynMemo.Highlighter := FormOptions.MySynAsmSyn;
  fSynMemo.Color := FormOptions.ColorEdit.Selected;
  fSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
  fSynMemo.Font := FormOptions.SynMemoOpt.Font;
end;

function FindFiles(const FileName: AnsiString): AnsiString;
var
  SearchRec: TSearchRec;
begin
  FindFirst(FileName, faAnyFile, SearchRec);
  Result := ExtractFilePath(FileName) + SearchRec.Name;
  FindClose(SearchRec);
end;

procedure TMyTabSheet.BClose(Sender: TObject);
begin
  fPanel.Visible := False;
end;

procedure TMyTabSheet.BFindFirst(Sender: TObject);
begin
  DoSearchReplaceText(fComboBoxFind.Text, '', False, True);
end;

procedure TMyTabSheet.BFindNext(Sender: TObject);
begin
  DoSearchReplaceText(fComboBoxFind.Text, '', False, False);
end;

procedure TMyTabSheet.SearchReplaceText(const SearchText,
  ReplaceText: AnsiString);
begin
  DoSearchReplaceText(SearchText, ReplaceText, True, False);
end;

procedure TMyTabSheet.SearchText(const SearchText: AnsiString);
begin
  fSynMemo.CaretX := 1;
  fSynMemo.CaretY := 1;
  DoSearchReplaceText(SearchText, '', False, False);
end;

procedure TMyTabSheet.ComboBoxFindDropDown(Sender: TObject);
begin
  fComboBoxFind.Items.Text := FindList.Text;
end;

procedure TMyTabSheet.AddFindList(const S: string);
var
  I: Integer;
  IsFound: Boolean;
begin
  if S <> '' then
  begin
    IsFound := False;
    for I := 0 to FindList.Count - 1 do
      if LowerCase(S) = LowerCase(FindList.Strings[I]) then
        IsFound := True;

    if not IsFound then
      FindList.Insert(0, S);

    if FindList.Count > 20 then
      FindList.Delete(20);

    fComboBoxFind.Text := S;
  end;
end;

constructor TMyTabSheet.Create(AOwner: TPageControl; Images: TImageList; BookmarkImages: TImageList; PMenuEdit: TPopupMenu; FileName: AnsiString);
begin
  inherited Create(AOwner);

  fPanel := TPanel.Create(Self);
  with fPanel do
  begin
    Parent := Self;
    Align := alTop;
    BevelOuter := bvNone;
    Height := 22;
    Color := clScrollBar;
    ParentBackground := False;
    Visible := False;
  end;

  fComboBoxFind := TComboBox.Create(fPanel);
  with fComboBoxFind do
  begin
    Parent := fPanel;
    Align := alLeft;
    Width := 200;
    OnDropDown := ComboBoxFindDropDown;
  end;

  fBClose := TSpeedButton.Create(fPanel);
  with fBClose do
  begin
    Parent := fPanel;
    OnClick := BClose;
    Images.GetBitmap(0, Glyph);
    Width := 17;
    Height := 15;
    Flat := True;
    Top := 3;
    Hint := 'Закрыть';
    ShowHint := True;
  end;

  fBNext := TSpeedButton.Create(fPanel);
  with fBNext do
  begin
    Parent := fPanel;
    OnClick := BFindNext;
    Images.GetBitmap(1, Glyph);
    Width := 30;
    Height := 22;
    Flat := True;
    Left := fComboBoxFind.Width + 10;
    Hint := 'Следующее';
    ShowHint := True;
  end;

  fBFirst := TSpeedButton.Create(fPanel);
  with fBFirst do
  begin
    Parent := fPanel;
    OnClick := BFindFirst;
    Images.GetBitmap(2, Glyph);
    Width := 30;
    Height := 22;
    Flat := True;
    Left := fBNext.Left + 31;
    Hint := 'Предыдущее';
    ShowHint := True;
  end;

  fSynMemo := TSynMemo.Create(Self);
  with fSynMemo do
  begin
    Parent := Self;
    Align := alClient;
    BorderStyle := bsNone;
    ActiveLineColor := FormOptions.SynMemoOpt.ActiveLineColor;
    BookMarkOptions.BookmarkImages := BookmarkImages;
    OnStatusChange := StatusChange;
    OnCommandProcessed := SynMemoCommandProcessed;

    OnKeyDown := SynMemoKeyDown;
    OnKeyUp := SynMemoKeyUp;
    OnMouseUp := SynMemoMouseUp;
    OnMouseMove := SynMemoMouseMove;
    OnExit := SynMemoExit;

    OnClick := SynMemoClick;
    OnDblClick := SynMemoDblClick;
    OnGutterClick := SynMemoGutterClick;
    OnGutterGetText := SynMemoGutterGetText;
    OnPlaceBookmark := SynMemoPlaceBookmark;
    Highlighter := FormOptions.MySynAsmSyn;
    SynMemoOptions := FormOptions.SynMemoOpt;
    PopupMenu := PMenuEdit;
  end;

  FilePath := FileName;

  fSynEditSearch := TSynEditSearch.Create(Self);
  with fSynEditSearch do
  begin

  end;

  fStatusBar := TStatusBar.Create(Self);
  with fStatusBar do
  begin
    Parent := Self;
    Panels.Add;
    Panels.Add;
    Panels.Add;
    Panels.Add;
    Align := alBottom;
    Panels[0].Width := 120;
    Panels[0].Text := 'Строка: ' + IntToStr(fSynMemo.CaretY);
    Panels[1].Width := 120;
    Panels[1].Text := 'Столбец: ' + IntToStr(fSynMemo.CaretX);
    Panels[2].Width := 100;
    Panels[2].Text := 'Вставка';
    Panels[3].Width := 50;
    Panels[3].Text := 'Файл: ' + FileName;
  end;

  Self.PageControl := AOwner;
  Self.Visible := True;
  fActiveCaretY := 1;
  fSelectWord := '';

  UpdateOptions;
end;

destructor TMyTabSheet.Destroy;
begin
  fBClose.Free;
  fBNext.Free;
  fBFirst.Free;
  fComboBoxFind.Free;
  fPanel.Free;
  fSynEditSearch.Free;
  fSynMemo.Free;
  inherited Destroy;
end;

function TMyTabSheet.GetModifi: Boolean;
begin
  Result := fSynMemo.Modified;
end;

procedure TMyTabSheet.SetModifi(const Value: Boolean);
begin
  fSynMemo.Modified := Value;
end;

procedure TMyTabSheet.ProcFind(const S: string);
begin
  fPanel.Visible := True;
  fComboBoxFind.SetFocus;
  fBClose.Left := fPanel.Width - 15;
  fBClose.Anchors := [akRight];

  if S <> '' then
    AddFindList(S)
  else
    AddFindList(fSynMemo.SelText);
end;

procedure TMyTabSheet.SaveToFile;
begin
  try
    fSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
    fSynMemo.Lines.SaveToFile(fFile);
  except
    MessageBoxA(Handle, PAnsiChar(AnsiString('Произошла ошибка при записи файла. ' + fFile)), 'Ошибка!', MB_ICONERROR or MB_OK);
  end;
  fSynMemo.Modified := False;
end;

procedure TMyTabSheet.SetFile(const Value: AnsiString);
var
  Str: AnsiString;
begin
  Str := FindFiles(Value);
  if Str = '' then
    fFile := Value
  else
    fFile := Str;

  if not FileExists(fFile) then
    Exit;

  Self.Caption := ExtractFileName(fFile);
  fSynMemo.Lines.LoadFromFile(fFile);
end;

procedure TMyTabSheet.SetSelectWord(const Value: string);
begin
  fSelectWord := LowerCase(Value);
end;

function TMyTabSheet.GetSelectedText(): string;
begin
  Result := fSynMemo.SelText;
end;

procedure TMyTabSheet.SetSynMemoOptions(const Value: TSynMemo);
begin
  fSynMemo.SelectedColor.Background := Value.SelectedColor.Background;
  fSynMemo.Gutter.AutoSize := Value.Gutter.AutoSize;
  fSynMemo.Gutter.BorderColor := Value.Gutter.BorderColor;
  fSynMemo.Gutter.Color := Value.Gutter.Color;
  fSynMemo.Gutter.Font := Value.Gutter.Font;
  fSynMemo.Gutter.Gradient := Value.Gutter.Gradient;
  fSynMemo.Gutter.GradientEndColor := Value.Gutter.GradientEndColor;
  fSynMemo.Gutter.GradientStartColor := Value.Gutter.GradientStartColor;
  fSynMemo.Gutter.LeftOffset := Value.Gutter.LeftOffset;
  fSynMemo.Gutter.RightOffset := Value.Gutter.RightOffset;
  fSynMemo.Gutter.ShowLineNumbers := Value.Gutter.ShowLineNumbers;
  fSynMemo.Gutter.Width := Value.Gutter.Width;

  fSynMemo.Options := [eoAutoIndent, eoEnhanceHomeKey, eoEnhanceEndKey,
    eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete,
    eoDragDropEditing,
  // eoSmartTabs,
  eoTabsToSpaces, eoRightMouseMovesCursor, eoScrollHintFollows { ,
    eoTrimTrailingSpaces } ];

  fSynMemo.TabWidth := Value.TabWidth;
  fSynMemo.WantTabs := Value.WantTabs;
end;

procedure TMyTabSheet.StatusChange(Sender: TObject; Changes: TSynStatusChanges);
begin
  fCtrl := false;

  if Changes * [scCaretX] <> [] then
  begin
    fSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
    fStatusBar.Panels[1].Text := 'Столбец: ' + IntToStr(fSynMemo.CaretX);
  end;

  if Changes * [scCaretY] <> [] then
  begin
    fSynMemo.InvalidateGutterLine(fActiveCaretY);
    fActiveCaretY := fSynMemo.CaretY;
    fSynMemo.InvalidateGutterLine(fActiveCaretY);

    fSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
    fStatusBar.Panels[0].Text := 'Строка: ' + IntToStr(fSynMemo.CaretY);
  end;

  if (fSynMemo.SelText = '') then
  begin
    fSelectWord := '';
    TMySynAsmSyn(fSynMemo.Highlighter).SelectWord := fSelectWord;
    fSynMemo.Invalidate;
  end;

  PostMessage(GetMainFormHandle, WM_EDIT_STATUS_CHANGE, 0, 0);
end;

procedure TMyTabSheet.SynMemoCommandProcessed(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
var
  I: Integer;
  Found: Boolean;
begin
  fSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
  if fSynMemo.InsertMode then
    fStatusBar.Panels[2].Text := 'Вставка'
  else
    fStatusBar.Panels[2].Text := 'Перезаписать';
end;

procedure TMyTabSheet.SynMemoDblClick(Sender: TObject);
begin
  fSelectWord := fSynMemo.SelText;
  if fSelectWord <> '' then
  begin
    TMySynAsmSyn(fSynMemo.Highlighter).SelectWord := fSelectWord;
    fSynMemo.Invalidate;
  end;
end;

procedure TMyTabSheet.SynMemoClick(Sender: TObject);
begin
  fSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;

  if fSelectWord <> '' then
  begin
    fSelectWord := '';
    TMySynAsmSyn(fSynMemo.Highlighter).SelectWord := fSelectWord;
  end;
end;

procedure TMyTabSheet.SynMemoGutterClick(Sender: TObject; Button: TMouseButton;
  X, Y, Line: Integer; Mark: TSynEditMark);
var
  I: Integer;
  Found: Boolean;
begin
  if (X > 16) or (Button <> mbLeft) then
    Exit;

  fSynMemo.BeginUpdate;

  Found := False;
  for I := Pred(fSynMemo.Marks.Count) downto 0 do
    if fSynMemo.Marks.Items[I].Line = Line then
    begin
      fSynMemo.ClearBookMark(fSynMemo.Marks[I].BookmarkNumber);
      Found := True;
      Break;
    end;

  { Set next bookmark }
  if not Found then
  begin
    I := 0;
    while fSynMemo.IsBookmark(I) do
      Inc(I);
    fSynMemo.SetBookMark(I, 0, Line);
  end;

  fSynMemo.EndUpdate;
end;

procedure TMyTabSheet.SynMemoPlaceBookmark(Sender: TObject;
  var Mark: TSynEditMark);
var
  I: Integer;
begin
  for I := Pred(fSynMemo.Marks.Count) downto 0 do
    if fSynMemo.Marks.Items[I].Line = fSynMemo.CaretY then
    begin
      fSynMemo.ClearBookMark(fSynMemo.Marks[I].BookmarkNumber);
      Break;
    end;
end;

procedure TMyTabSheet.SynMemoGutterGetText(Sender: TObject; aLine: Integer;
  var aText: string);
begin
  if ((aLine mod 10) = 0) or (aLine = 1) or (aLine = fActiveCaretY) then
    aText := IntToStr(aLine)
  else if (aLine mod 5) = 0 then
    aText := '-'
  else
    aText := '.';
end;

procedure TMyTabSheet.DoSearchReplaceText(const SearchText,
  ReplaceText: AnsiString; AReplace: Boolean; ABackwards: Boolean);
var
  Options: TSynSearchOptions;
begin
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll, ssoEntireScope]
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);

  fSynMemo.SearchEngine := fSynEditSearch;
  if fSynMemo.SearchReplace(SearchText, ReplaceText, Options) = 0 then
  begin
    MessageBeep(MB_ICONASTERISK);
    if ssoBackwards in Options then
      fSynMemo.BlockEnd := fSynMemo.BlockBegin
    else
      fSynMemo.BlockBegin := fSynMemo.BlockEnd;
    fSynMemo.CaretXY := fSynMemo.BlockBegin;
  end;
end;

initialization

FindList := TStringList.Create;

finalization

FindList.Free;

end.
