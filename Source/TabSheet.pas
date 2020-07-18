unit TabSheet;

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
  SynHighlighterAsm,
  Utils,
  AsmSource,
  Math,
  SynExportRTF,
  SynExportHTML,
  SynCompletionProposal;

type
  TCustomTabSheet = class(TTabSheet)
  public

  private
    FActiveCaretY: Integer;
    FFile: AnsiString;
    FSynMemo: TSynMemo;
    FSynEditSearch: TSynEditSearch;
    FPanel: TPanel;
    FComboBoxFind: TComboBox;
    FButtonClose: TSpeedButton;
    FButtonNext: TSpeedButton;
    FButtonFirst: TSpeedButton;
    FStatusBar: TStatusBar;
    FSelectWord: string;
    FCtrl: Boolean;
    FProjectPath: AnsiString;
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
    function GetSynMemoLinesCount(): Integer;
    procedure GotoLineAndCenter(ALine: Integer);
    function GetSynMemoCaretY(): Integer;
    function GetSynMemoCaretX(): Integer;
    function GetWordAtMouse(): string;
    function GetWordAtCursor(): string;
    procedure SetBookMark(Mark: Integer);
    procedure GoBookMark(Mark: Integer);
    procedure ClearBookMark();
    function GetSynMemoText(): string;
    procedure SetCompletion(var SynCompletion, SynHint, SynCompletionJump: TSynCompletionProposal);
    procedure SetActiveControl(MainForm: TForm);
    procedure SynMemoRepaint();
    procedure RepaintSelectWord();
    procedure SynMemoRedo();
    procedure SynMemoUndo();
    function GetSynMemoCurrentLine(): string;
    function GetSynMemoPreviousToken(): string;
    function GetSynMemoCaretPosition(): Integer;
    procedure SelectErrorLine(LineNumber: Integer);
    property FilePath: AnsiString read FFile write SetFile;
    property SynMemoOptions: TSynMemo write SetSynMemoOptions;
    property Modifi: Boolean read GetModifi write SetModifi;
    procedure SaveToFile();
    procedure ProcFind(const S: string);
    procedure SearchReplaceText(const SearchText, ReplaceText: AnsiString);
    procedure SearchText(const SearchText: AnsiString);
    procedure UpdateOptions;
    procedure BFindNext(Sender: TObject);
    procedure BFindFirst(Sender: TObject);
    procedure AddFindList(const S: string);
    property SelectWord: string read FSelectWord write SetSelectWord;
    property SelectedText: string read GetSelectedText;
  end;

var
  CustomTabSheet: TCustomTabSheet;

implementation

uses Options;

var
  FindList: TStringList;

{ TMyTabSheet }

procedure TCustomTabSheet.AddSeparator(Separator: Byte);
begin
  case Separator of
    1:
      begin
        FSynMemo.SelText := #13#10 + ';===============================================================================' + #13#10;
      end;

    2:
      begin
        FSynMemo.SelText := #13#10 + ';-------------------------------------------------------------------------------' + #13#10;
      end;
  end;
end;

procedure TCustomTabSheet.ExportRtf(var Rtf: TSynExporterRTF);
var
  Src: TStringList;
  S: AnsiString;
begin
  Rtf.Title := Caption;
  Rtf.Color := FSynMemo.Color;
  Rtf.Font := FSynMemo.Font;
  Rtf.ExportAsText := True;
  Rtf.Highlighter := FSynMemo.Highlighter;

  if SelectedText <> '' then
  begin
    Src := TStringList.Create;
    S := AnsiString(SelectedText);
    Src.Text := S;
    Rtf.ExportAll(Src);

    Src.Free;
  end
  else
    Rtf.ExportAll(FSynMemo.Lines);
end;

procedure TCustomTabSheet.ExportHtml(var Html: TSynExporterHTML);
var
  Src: TStringList;
  S: AnsiString;
begin
  Html.Title := Caption;
  Html.Color := FSynMemo.Color;
  Html.Font := FSynMemo.Font;
  Html.ExportAsText := True;
  Html.Highlighter := FSynMemo.Highlighter;

  if SelectedText <> '' then
  begin
    Src := TStringList.Create;
    S := AnsiString(SelectedText);
    Src.Text := S;
    Html.ExportAll(Src);

    Src.Free;
  end
  else
    Html.ExportAll(FSynMemo.Lines);
end;

function TCustomTabSheet.GetSynMemoLinesCount(): Integer;
begin
  Result := FSynMemo.Lines.Count;
end;

procedure TCustomTabSheet.GotoLineAndCenter(ALine: Integer);
begin
  FSynMemo.GotoLineAndCenter(ALine);
end;

function TCustomTabSheet.GetSynMemoCaretX(): Integer;
begin
  Result := FSynMemo.CaretX;
end;

function TCustomTabSheet.GetSynMemoCaretY(): Integer;
begin
  Result := FSynMemo.CaretY;
end;

function TCustomTabSheet.GetWordAtMouse(): string;
begin
  Result := FSynMemo.WordAtMouse;
end;

function TCustomTabSheet.GetWordAtCursor(): string;
begin
  Result := FSynMemo.WordAtCursor;
end;

procedure TCustomTabSheet.SetBookMark(Mark: Integer);
var
  I: Integer;
  IsFound: Boolean;
begin
  IsFound := False;
  for I := Pred(FSynMemo.Marks.Count) downto 0 do
    if FSynMemo.Marks.Items[I].Line = FSynMemo.CaretY then
    begin
      if FSynMemo.Marks.Items[I].BookmarkNumber = Mark - 351 then
        FSynMemo.CommandProcessor(Mark, #0, nil);

      IsFound := True;
      Break;
    end;

  if not IsFound then
    FSynMemo.CommandProcessor(Mark, #0, nil);
end;

procedure TCustomTabSheet.GoBookMark(Mark: Integer);
begin
   FSynMemo.CommandProcessor(Mark, #0, nil);
end;

procedure TCustomTabSheet.ClearBookMark();
var
  I: Integer;
begin
  for I := Pred(FSynMemo.Marks.Count) downto 0 do
    FSynMemo.ClearBookMark(FSynMemo.Marks[I].BookmarkNumber);
end;

function TCustomTabSheet.GetSynMemoText(): string;
begin
  Result := FSynMemo.Lines.Text;
end;

procedure TCustomTabSheet.SetCompletion(var SynCompletion, SynHint, SynCompletionJump: TSynCompletionProposal);
begin
  SynCompletion.Editor := FSynMemo;
  SynHint.Editor := FSynMemo;
  SynCompletionJump.Editor := FSynMemo;
end;

procedure TCustomTabSheet.SetActiveControl(MainForm: TForm);
begin
  MainForm.ActiveControl := CustomTabSheet.FSynMemo;
end;

procedure TCustomTabSheet.SynMemoRepaint();
begin
  FSynMemo.Repaint();
end;

procedure TCustomTabSheet.RepaintSelectWord();
begin
  TSynCustomAsmHighlighter(FSynMemo.Highlighter).SelectWord := SelectWord;
  FSynMemo.Repaint();
end;

procedure TCustomTabSheet.SynMemoRedo();
begin
  FSynMemo.Redo();
end;

procedure TCustomTabSheet.SynMemoUndo();
begin
  FSynMemo.Undo();
end;

function TCustomTabSheet.GetSynMemoCurrentLine(): string;
begin
  Result := FSynMemo.Lines.Strings[FSynMemo.CaretY - 1];
end;

function TCustomTabSheet.GetSynMemoPreviousToken(): string;
  function IsWordBreakChar(AChar: WideChar): Boolean;
  begin
    Result := (Pos(AChar, '()[],=\/:') > 0);
  end;
var
  Line: string;
  CharPosition: Integer;
begin
  Result := '';

  Line := FSynMemo.Lines[FSynMemo.CaretXY.Line - 1];
  CharPosition := FSynMemo.CaretXY.Char - 1;
  if (CharPosition = 0) or (CharPosition > Length(Line)) or (Length(Line) = 0) then Exit();

  if IsWordBreakChar(Line[CharPosition]) then Exit(); // Dec(X);

  while (CharPosition > 0) and not(IsWordBreakChar(Line[CharPosition])) do
  begin
    Result := Line[CharPosition] + Result;
    Dec(CharPosition);
  end;
end;

function TCustomTabSheet.GetSynMemoCaretPosition(): Integer;
begin
  Result := FSynMemo.CaretXY.Char;
end;

procedure TCustomTabSheet.SelectErrorLine(LineNumber: Integer);
begin
  FSynMemo.GotoLineAndCenter(LineNumber);
  FSynMemo.CaretY := LineNumber + 1;
  FSynMemo.CaretY := LineNumber;
  FSynMemo.CaretX := 0;

  FSynMemo.ActiveLineColor := clRed;
end;

procedure TCustomTabSheet.RegisterSymbol(Big: Boolean = True);
var
  A, B: TBufferCoord;
begin
  A := FSynMemo.BlockBegin;
  B := FSynMemo.BlockEnd;

  if Big then
    FSynMemo.SelText := UpperCase(FSynMemo.SelText)
  else
    FSynMemo.SelText := LowerCase(FSynMemo.SelText);

  FSynMemo.BlockBegin := A;
  FSynMemo.BlockEnd := B;
end;

procedure TCustomTabSheet.SelectText(SelStart: Integer; SelEnd: Integer);
begin
  FSynMemo.SelStart := SelStart;
  FSynMemo.SelEnd := SelEnd;
end;

procedure TCustomTabSheet.GotoVar(BeginChar: Integer; EndChar: Integer);
var
  Line: Integer;
begin
  Line := FSynMemo.CharIndexToRowCol(BeginChar).Line;
  FSynMemo.CaretY := Line - 1;
  FSynMemo.CaretY := Line;
  FSynMemo.GotoLineAndCenter(Line);

  SelectText(BeginChar, EndChar);
end;

procedure TCustomTabSheet.AddOrDelSpace(AddSpace: Boolean = True);
var
  I, J, Len: Integer;
  InString, OutString: TStringList;
  Str: string;
  A, B: TBufferCoord;
begin
  InString := TStringList.Create;
  OutString := TStringList.Create;

  InString.Text := FSynMemo.SelText;
  Len := FSynMemo.SelLength;

  A := FSynMemo.BlockBegin;
  B := FSynMemo.BlockEnd;

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
  FSynMemo.SelText := Str;
  FSynMemo.BlockBegin := A;
  FSynMemo.BlockEnd := B;
  InString.Free;
  OutString.Free;
end;

procedure TCustomTabSheet.AddOrDelComment();
var
  I, Len: Integer;
  InString, OutString: TStringList;
  Str: string;
  BlockBegin, BlockEnd: TBufferCoord;
begin
  InString := TStringList.Create;
  OutString := TStringList.Create;
  InString.Text := FSynMemo.SelText;
  Len := FSynMemo.SelLength;

  BlockBegin := FSynMemo.BlockBegin;
  BlockEnd := FSynMemo.BlockEnd;

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
  FSynMemo.SelText := Str;
  FSynMemo.BlockBegin := BlockBegin;
  FSynMemo.BlockEnd := BlockEnd;
  InString.Free;
  OutString.Free;

  if (FSynMemo.LineText <> '') and (FSynMemo.LineText[1] = ';') then
  begin
    FSynMemo.LineText := Copy(FSynMemo.LineText, 2, FSynMemo.LineText.Length);
    FSynMemo.CaretY := FSynMemo.CaretY + 1;
  end
  else
  begin
    FSynMemo.LineText := ';' + FSynMemo.LineText;
    FSynMemo.CaretY := FSynMemo.CaretY + 1;
  end;
end;

procedure TCustomTabSheet.SynMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) then
  begin
    FCtrl := True;
    if Key <> VK_CONTROL then
        FCtrl := false;
  end;
end;

procedure TCustomTabSheet.SynMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  MySynAsmSyn: TSynCustomAsmHighlighter;
begin
  if Key = VK_CONTROL then
  begin
    FCtrl := False;

    MySynAsmSyn := TSynCustomAsmHighlighter(FSynMemo.Highlighter);
    FSynMemo.Cursor := crIBeam;

    if not MySynAsmSyn.equalsUnderscoreWord('') then
    begin
      MySynAsmSyn.UnderscoreWord := '';
      FSynMemo.Invalidate;
    end;
  end;

  PostMessage(GetMainFormHandle, WM_UPDATEEXPLORER_VAR, 0, 0);
end;

procedure TCustomTabSheet.SynMemoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FCtrl and (FSynMemo.WordAtMouse <> '') then
  begin
    FCtrl := False;
    PostMessage(GetMainFormHandle, WM_GOTO_VAR_AT_MOUSE, 0, 0);
  end;
end;

procedure TCustomTabSheet.SynMemoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  MySynAsmSyn: TSynCustomAsmHighlighter;
begin
  MySynAsmSyn := TSynCustomAsmHighlighter(FSynMemo.Highlighter);

  if FCtrl and (FSynMemo.WordAtMouse <> '') then
  begin
    FSynMemo.Cursor := crHandPoint;

    if not MySynAsmSyn.equalsUnderscoreWord(FSynMemo.WordAtMouse) then
    begin
      MySynAsmSyn.UnderscoreWord := FSynMemo.WordAtMouse;
      FSynMemo.Invalidate;
    end;
  end;

  if FSynMemo.WordAtMouse = '' then
  begin
    FSynMemo.Cursor := crIBeam;

    if not MySynAsmSyn.equalsUnderscoreWord('') then
    begin
      MySynAsmSyn.UnderscoreWord := '';
      FSynMemo.Invalidate;
    end;
  end;
end;

procedure TCustomTabSheet.SynMemoExit(Sender: TObject);
begin
  FCtrl := False;
end;

procedure TCustomTabSheet.UpdateOptions;
begin
  FSynMemo.Highlighter := FormOptions.SynCustomAsmHighlighter;
  FSynMemo.Color := FormOptions.ColorEdit.Selected;
  FSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
  FSynMemo.Font := FormOptions.SynMemoOpt.Font;
end;

procedure TCustomTabSheet.BClose(Sender: TObject);
begin
  FPanel.Visible := False;
end;

procedure TCustomTabSheet.BFindFirst(Sender: TObject);
begin
  DoSearchReplaceText(FComboBoxFind.Text, '', False, True);
end;

procedure TCustomTabSheet.BFindNext(Sender: TObject);
begin
  DoSearchReplaceText(FComboBoxFind.Text, '', False, False);
end;

procedure TCustomTabSheet.SearchReplaceText(const SearchText,
  ReplaceText: AnsiString);
begin
  DoSearchReplaceText(SearchText, ReplaceText, True, False);
end;

procedure TCustomTabSheet.SearchText(const SearchText: AnsiString);
begin
  FSynMemo.CaretX := 1;
  FSynMemo.CaretY := 1;
  DoSearchReplaceText(SearchText, '', False, False);
end;

procedure TCustomTabSheet.ComboBoxFindDropDown(Sender: TObject);
begin
  FComboBoxFind.Items.Text := FindList.Text;
end;

procedure TCustomTabSheet.AddFindList(const S: string);
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

    FComboBoxFind.Text := S;
  end;
end;

constructor TCustomTabSheet.Create(AOwner: TPageControl; Images: TImageList; BookmarkImages: TImageList; PMenuEdit: TPopupMenu; FileName: AnsiString);
begin
  inherited Create(AOwner);

  FPanel := TPanel.Create(Self);
  with FPanel do
  begin
    Parent := Self;
    Align := alTop;
    BevelOuter := bvNone;
    Height := 22;
    Color := clScrollBar;
    ParentBackground := False;
    Visible := False;
  end;

  FComboBoxFind := TComboBox.Create(FPanel);
  with FComboBoxFind do
  begin
    Parent := FPanel;
    Align := alLeft;
    Width := 200;
    OnDropDown := ComboBoxFindDropDown;
  end;

  FButtonClose := TSpeedButton.Create(FPanel);
  with FButtonClose do
  begin
    Parent := FPanel;
    OnClick := BClose;
    Images.GetBitmap(0, Glyph);
    Width := 17;
    Height := 15;
    Flat := True;
    Top := 3;
    Hint := 'Закрыть';
    ShowHint := True;
  end;

  FButtonNext := TSpeedButton.Create(FPanel);
  with FButtonNext do
  begin
    Parent := FPanel;
    OnClick := BFindNext;
    Images.GetBitmap(1, Glyph);
    Width := 30;
    Height := 22;
    Flat := True;
    Left := FComboBoxFind.Width + 10;
    Hint := 'Следующее';
    ShowHint := True;
  end;

  FButtonFirst := TSpeedButton.Create(FPanel);
  with FButtonFirst do
  begin
    Parent := FPanel;
    OnClick := BFindFirst;
    Images.GetBitmap(2, Glyph);
    Width := 30;
    Height := 22;
    Flat := True;
    Left := FButtonNext.Left + 31;
    Hint := 'Предыдущее';
    ShowHint := True;
  end;

  FSynMemo := TSynMemo.Create(Self);
  with FSynMemo do
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
    Highlighter := FormOptions.SynCustomAsmHighlighter;
    SynMemoOptions := FormOptions.SynMemoOpt;
    PopupMenu := PMenuEdit;
  end;

  FilePath := FileName;

  FSynEditSearch := TSynEditSearch.Create(Self);
  with FSynEditSearch do
  begin

  end;

  FStatusBar := TStatusBar.Create(Self);
  with FStatusBar do
  begin
    Parent := Self;
    Panels.Add;
    Panels.Add;
    Panels.Add;
    Panels.Add;
    Align := alBottom;
    Panels[0].Width := 120;
    Panels[0].Text := 'Строка: ' + IntToStr(FSynMemo.CaretY);
    Panels[1].Width := 120;
    Panels[1].Text := 'Столбец: ' + IntToStr(FSynMemo.CaretX);
    Panels[2].Width := 100;
    Panels[2].Text := 'Вставка';
    Panels[3].Width := 50;
    Panels[3].Text := 'Файл: ' + FileName;
  end;

  Self.PageControl := AOwner;
  Self.Visible := True;
  FActiveCaretY := 1;
  FSelectWord := '';

  UpdateOptions;
end;

destructor TCustomTabSheet.Destroy;
begin
  FButtonClose.Free;
  FButtonNext.Free;
  FButtonFirst.Free;
  FComboBoxFind.Free;
  FPanel.Free;
  FSynEditSearch.Free;
  FSynMemo.Free;
  inherited Destroy;
end;

function TCustomTabSheet.GetModifi: Boolean;
begin
  Result := FSynMemo.Modified;
end;

procedure TCustomTabSheet.SetModifi(const Value: Boolean);
begin
  FSynMemo.Modified := Value;
end;

procedure TCustomTabSheet.ProcFind(const S: string);
begin
  FPanel.Visible := True;
  FComboBoxFind.SetFocus;
  FButtonClose.Left := FPanel.Width - 15;
  FButtonClose.Anchors := [akRight];

  if S <> '' then
    AddFindList(S)
  else
    AddFindList(FSynMemo.SelText);
end;

procedure TCustomTabSheet.SaveToFile();
begin
  try
    FSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
    FSynMemo.Lines.SaveToFile(FFile);
  except
    MessageBoxA(Handle, PAnsiChar(AnsiString('Произошла ошибка при записи файла. ' + FFile)), 'Ошибка!', MB_ICONERROR or MB_OK);
  end;
  FSynMemo.Modified := False;
end;

procedure TCustomTabSheet.SetFile(const Value: AnsiString);
var
  Str: AnsiString;
begin
  if not FileExists(Value) then
    raise Exception.Create('File not found: ' + Value);

  FFile := Value;
  Self.Caption := ExtractFileName(FFile);
  FSynMemo.Lines.LoadFromFile(FFile);
end;

procedure TCustomTabSheet.SetSelectWord(const Value: string);
begin
  FSelectWord := LowerCase(Value);
end;

function TCustomTabSheet.GetSelectedText(): string;
begin
  Result := FSynMemo.SelText;
end;

procedure TCustomTabSheet.SetSynMemoOptions(const Value: TSynMemo);
begin
  FSynMemo.SelectedColor.Background := Value.SelectedColor.Background;
  FSynMemo.Gutter.AutoSize := Value.Gutter.AutoSize;
  FSynMemo.Gutter.BorderColor := Value.Gutter.BorderColor;
  FSynMemo.Gutter.Color := Value.Gutter.Color;
  FSynMemo.Gutter.Font := Value.Gutter.Font;
  FSynMemo.Gutter.Gradient := Value.Gutter.Gradient;
  FSynMemo.Gutter.GradientEndColor := Value.Gutter.GradientEndColor;
  FSynMemo.Gutter.GradientStartColor := Value.Gutter.GradientStartColor;
  FSynMemo.Gutter.LeftOffset := Value.Gutter.LeftOffset;
  FSynMemo.Gutter.RightOffset := Value.Gutter.RightOffset;
  FSynMemo.Gutter.ShowLineNumbers := Value.Gutter.ShowLineNumbers;
  FSynMemo.Gutter.Width := Value.Gutter.Width;

  FSynMemo.Options := [eoAutoIndent, eoEnhanceHomeKey, eoEnhanceEndKey,
    eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete,
    eoDragDropEditing,
  // eoSmartTabs,
  eoTabsToSpaces, eoRightMouseMovesCursor, eoScrollHintFollows { ,
    eoTrimTrailingSpaces } ];

  FSynMemo.TabWidth := Value.TabWidth;
  FSynMemo.WantTabs := Value.WantTabs;
end;

procedure TCustomTabSheet.StatusChange(Sender: TObject; Changes: TSynStatusChanges);
begin
  FCtrl := false;

  if Changes * [scCaretX] <> [] then
  begin
    FSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
    FStatusBar.Panels[1].Text := 'Столбец: ' + IntToStr(FSynMemo.CaretX);
  end;

  if Changes * [scCaretY] <> [] then
  begin
    FSynMemo.InvalidateGutterLine(FActiveCaretY);
    FActiveCaretY := FSynMemo.CaretY;
    FSynMemo.InvalidateGutterLine(FActiveCaretY);

    FSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
    FStatusBar.Panels[0].Text := 'Строка: ' + IntToStr(FSynMemo.CaretY);
  end;

  if (FSynMemo.SelText = '') then
  begin
    FSelectWord := '';
    TSynCustomAsmHighlighter(FSynMemo.Highlighter).SelectWord := FSelectWord;
    FSynMemo.Invalidate;
  end;

  PostMessage(GetMainFormHandle, WM_EDIT_STATUS_CHANGE, 0, 0);
end;

procedure TCustomTabSheet.SynMemoCommandProcessed(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
var
  I: Integer;
  Found: Boolean;
begin
  FSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;
  if FSynMemo.InsertMode then
    FStatusBar.Panels[2].Text := 'Вставка'
  else
    FStatusBar.Panels[2].Text := 'Перезаписать';
end;

procedure TCustomTabSheet.SynMemoDblClick(Sender: TObject);
begin
  FSelectWord := FSynMemo.SelText;
  if FSelectWord <> '' then
  begin
    TSynCustomAsmHighlighter(FSynMemo.Highlighter).SelectWord := FSelectWord;
    FSynMemo.Invalidate;
  end;
end;

procedure TCustomTabSheet.SynMemoClick(Sender: TObject);
begin
  FSynMemo.ActiveLineColor := FormOptions.ColorBoxActiveLine.Selected;

  if FSelectWord <> '' then
  begin
    FSelectWord := '';
    TSynCustomAsmHighlighter(FSynMemo.Highlighter).SelectWord := FSelectWord;
  end;
end;

procedure TCustomTabSheet.SynMemoGutterClick(Sender: TObject; Button: TMouseButton;
  X, Y, Line: Integer; Mark: TSynEditMark);
var
  I: Integer;
  Found: Boolean;
begin
  if (X > 16) or (Button <> mbLeft) then
    Exit;

  FSynMemo.BeginUpdate;

  Found := False;
  for I := Pred(FSynMemo.Marks.Count) downto 0 do
    if FSynMemo.Marks.Items[I].Line = Line then
    begin
      FSynMemo.ClearBookMark(FSynMemo.Marks[I].BookmarkNumber);
      Found := True;
      Break;
    end;

  { Set next bookmark }
  if not Found then
  begin
    I := 0;
    while FSynMemo.IsBookmark(I) do
      Inc(I);
    FSynMemo.SetBookMark(I, 0, Line);
  end;

  FSynMemo.EndUpdate;
end;

procedure TCustomTabSheet.SynMemoPlaceBookmark(Sender: TObject;
  var Mark: TSynEditMark);
var
  I: Integer;
begin
  for I := Pred(FSynMemo.Marks.Count) downto 0 do
    if FSynMemo.Marks.Items[I].Line = FSynMemo.CaretY then
    begin
      FSynMemo.ClearBookMark(FSynMemo.Marks[I].BookmarkNumber);
      Break;
    end;
end;

procedure TCustomTabSheet.SynMemoGutterGetText(Sender: TObject; aLine: Integer;
  var aText: string);
begin
  if ((aLine mod 10) = 0) or (aLine = 1) or (aLine = FActiveCaretY) then
    aText := IntToStr(aLine)
  else if (aLine mod 5) = 0 then
    aText := '-'
  else
    aText := '.';
end;

procedure TCustomTabSheet.DoSearchReplaceText(const SearchText,
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

  FSynMemo.SearchEngine := FSynEditSearch;
  if FSynMemo.SearchReplace(SearchText, ReplaceText, Options) = 0 then
  begin
    MessageBeep(MB_ICONASTERISK);
    if ssoBackwards in Options then
      FSynMemo.BlockEnd := FSynMemo.BlockBegin
    else
      FSynMemo.BlockBegin := FSynMemo.BlockEnd;
    FSynMemo.CaretXY := FSynMemo.BlockBegin;
  end;
end;

initialization

FindList := TStringList.Create;

finalization

FindList.Free;

end.
