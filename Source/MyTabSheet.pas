unit MyTabSheet;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
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
  MySynHighlighterAsm;

// const
// clMyActvColor = $E6FFFA; //$FAFFE6;

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
  private
    fSelectWord: string;
    procedure SetSynMemoOptions(const Value: TSynMemo);
    procedure SetFile(const Value: AnsiString);
    function GetModifi: Boolean;
    procedure StatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure BClose(Sender: TObject);
    procedure DoSearchReplaceText(const SearchText, ReplaceText: AnsiString;
      AReplace: Boolean; ABackwards: Boolean);
    procedure SynMemoCommandProcessed(Sender: TObject;
      var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
    procedure SynMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SynMemoClick(Sender: TObject);
    procedure SynMemoGutterClick(Sender: TObject; Button: TMouseButton;
      X, Y, Line: Integer; Mark: TSynEditMark);
    procedure SynMemoGutterGetText(Sender: TObject; aLine: Integer;
      var aText: string);
    procedure SynMemoPlaceBookmark(Sender: TObject; var Mark: TSynEditMark);
    procedure ComboBoxFindDropDown(Sender: TObject);
    procedure SetModifi(const Value: Boolean);
    procedure SetSelectWord(const Value: string);
    procedure SynMemoDblClick(Sender: TObject);
  public
    constructor Create(AOwner: TPageControl; Images: TImageList); overload;
    destructor Destroy; override;
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
  end;

var
  MyTabSh: TMyTabSheet;

implementation

uses Main, Options;

var
  FindList: TStringList;

  { TMyTabSheet }

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
  Find: Boolean;
begin
  if S <> '' then
  begin
    Find := False;
    for I := 0 to FindList.Count - 1 do
      if LowerCase(S) = LowerCase(FindList.Strings[I]) then
        Find := True;

    if not Find then
      FindList.Insert(0, S);

    if FindList.Count > 20 then
      FindList.Delete(20);

    fComboBoxFind.Text := S;
  end;
end;

constructor TMyTabSheet.Create(AOwner: TPageControl; Images: TImageList);
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
    Hint := '�������';
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
    Hint := '���������';
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
    Hint := '����������';
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
    OnKeyUp := SynMemoKeyUp;
    OnClick := SynMemoClick;
    OnDblClick := SynMemoDblClick;
    OnGutterClick := SynMemoGutterClick;
    OnGutterGetText := SynMemoGutterGetText;
    OnPlaceBookmark := SynMemoPlaceBookmark;
    Highlighter := FormOptions.MySynAsmSyn;
    SynMemoOptions := FormOptions.SynMemoOpt;
    PopupMenu := FormEditor.PMenuEdit;
  end;

  fSynEditSearch := TSynEditSearch.Create(Self);
  with fSynEditSearch do
  begin

  end;

  Self.PageControl := AOwner;
  Self.Visible := True;
  fActiveCaretY := 1;
  fSelectWord := '';

  FormEditor.ActiveControl := fSynMemo;
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
    fSynMemo.Lines.SaveToFile(fFile);
  except
    MessageBoxA(Handle, PAnsiChar('��������� ������ ��� ������ �����. ' +
      fFile), '������!', MB_ICONERROR or MB_OK);
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
  if Changes * [scCaretX] <> [] then
  begin
    fSynMemo.ActiveLineColor := clNone;
    FormEditor.StatusBar1.Panels[1].Text := '�������: ' +
      IntToStr(fSynMemo.CaretX);
  end;

  if Changes * [scCaretY] <> [] then
  begin
    fSynMemo.InvalidateGutterLine(fActiveCaretY);
    fActiveCaretY := fSynMemo.CaretY;
    fSynMemo.InvalidateGutterLine(fActiveCaretY);

    fSynMemo.ActiveLineColor := clNone;
    FormEditor.StatusBar1.Panels[0].Text := '������: ' +
      IntToStr(fSynMemo.CaretY);
  end;

  if (fSynMemo.SelText = '') then
  begin
    fSelectWord := '';
    TMySynAsmSyn(fSynMemo.Highlighter).SelectWord := fSelectWord;
    // fSynMemo.Repaint;
    fSynMemo.Invalidate;
  end;

  FormEditor.SynHint.Deactivate;
end;

procedure TMyTabSheet.SynMemoCommandProcessed(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
var
  I: Integer;
  Found: Boolean;
begin
  fSynMemo.ActiveLineColor := clNone;
  if fSynMemo.InsertMode then
    FormEditor.StatusBar1.Panels[2].Text := '�������'
  else
    FormEditor.StatusBar1.Panels[2].Text := '������������';
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

procedure TMyTabSheet.SynMemoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
end;

procedure TMyTabSheet.SynMemoClick(Sender: TObject);
begin
  fSynMemo.ActiveLineColor := clNone;

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
