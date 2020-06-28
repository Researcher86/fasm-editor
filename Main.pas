unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms,
  Dialogs, SynEdit, Menus, SynCompletionProposal, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, ToolWin, MyTabSheet, Clipbrd, StrUtils,
  jpeg, VirtualTrees, SynExportHTML, SynEditExport,
  SynExportRTF, SynMemo, SynEditKeyCmds, ScanAsmFile,
  SynEditTextBuffer, SynEditTypes, ImgList, Grids, System.ImageList, ATBinHex, ATxSHex;

const
  WM_LOADFILE = WM_USER + 100;
  WM_UPDATEEXPLORER_VAR = WM_USER + 200;

type
  TCopyHexData = (chASM, chCPP, chDelphi);

type
  TFormEditor = class(TForm)
    StatusBar1: TStatusBar;
    Splitter5: TSplitter;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    OpenFileDialog: TOpenDialog;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N8: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    SynCompletion: TSynCompletionProposal;
    Splitter4: TSplitter;
    N10: TMenuItem;
    PageControl1: TPageControl;
    TabSheetGlav: TTabSheet;
    PMenuProject: TPopupMenu;
    Panel1: TPanel;
    PanelProjectStruc: TPanel;
    PanelTitleProjectStructure: TPanel;
    BCloseProjectStruc: TSpeedButton;
    PanelStructure: TPanel;
    PanelTitleStruc: TPanel;
    BCloseStruc: TSpeedButton;
    Splitter1: TSplitter;
    Image1: TImage;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    N9: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    ToolButton10: TToolButton;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N24: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N5: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N25: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    ExplorerProject: TVirtualStringTree;
    ExplorerVar: TVirtualStringTree;
    SaveDialog: TSaveDialog;
    N48: TMenuItem;
    Source1: TMenuItem;
    Include1: TMenuItem;
    PMenuSrcInc: TPopupMenu;
    N47: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    ToolButton6: TToolButton;
    PMenuTab: TPopupMenu;
    PMenuEdit: TPopupMenu;
    N110: TMenuItem;
    N310: TMenuItem;
    N311: TMenuItem;
    N211: TMenuItem;
    N111: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    N58: TMenuItem;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    N59: TMenuItem;
    N60: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    SynExporterRTF: TSynExporterRTF;
    SynExporterHTML: TSynExporterHTML;
    SaveDialogExport: TSaveDialog;
    N63: TMenuItem;
    RTF1: TMenuItem;
    HTML1: TMenuItem;
    N65: TMenuItem;
    RTF2: TMenuItem;
    HTML2: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    N71: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    N75: TMenuItem;
    N76: TMenuItem;
    N77: TMenuItem;
    N78: TMenuItem;
    N23: TMenuItem;
    N79: TMenuItem;
    N80: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    N83: TMenuItem;
    N85: TMenuItem;
    N84: TMenuItem;
    ListBoxFile: TListBox;
    PMenuExplorerVar: TPopupMenu;
    ExplorerVar1: TMenuItem;
    N86: TMenuItem;
    N87: TMenuItem;
    N88: TMenuItem;
    N89: TMenuItem;
    N90: TMenuItem;
    d1: TMenuItem;
    N112: TMenuItem;
    N210: TMenuItem;
    N312: TMenuItem;
    N410: TMenuItem;
    N510: TMenuItem;
    N610: TMenuItem;
    N710: TMenuItem;
    N810: TMenuItem;
    N91: TMenuItem;
    N92: TMenuItem;
    N93: TMenuItem;
    N113: TMenuItem;
    N114: TMenuItem;
    N115: TMenuItem;
    N116: TMenuItem;
    N117: TMenuItem;
    N118: TMenuItem;
    N119: TMenuItem;
    N120: TMenuItem;
    N94: TMenuItem;
    N95: TMenuItem;
    N96: TMenuItem;
    N97: TMenuItem;
    N98: TMenuItem;
    PageControlMesAndHex: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    PMenuHex: TPopupMenu;
    N64: TMenuItem;
    ASM1: TMenuItem;
    C1: TMenuItem;
    Delphi1: TMenuItem;
    N99: TMenuItem;
    N100: TMenuItem;
    N101: TMenuItem;
    N102: TMenuItem;
    N103: TMenuItem;
    N104: TMenuItem;
    N105: TMenuItem;
    N106: TMenuItem;
    SynHint: TSynCompletionProposal;
    DLL1: TMenuItem;
    N107: TMenuItem;
    Include2: TMenuItem;
    N108: TMenuItem;
    N109: TMenuItem;
    PanelCloseH_D: TPanel;
    BCloseH_D: TSpeedButton;
    Win32APIHelp1: TMenuItem;
    SynCompletionJump: TSynCompletionProposal;
    N121: TMenuItem;
    N123: TMenuItem;
    N122: TMenuItem;
    ToolButton23: TToolButton;
    ToolbarImageList: TImageList;
    MainMenuImageList: TImageList;
    ImBookMark: TImageList;
    ProjectStructImageList: TImageList;
    LabelTitleProjectStructure: TLabel;
    LabelTitleStruc: TLabel;
    MyTabSheetImageList: TImageList;
    HexEditor: TATBinHex;
    procedure FormCreate(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
    procedure ExplorerProjectlGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure ExplorerProjectDblClick(Sender: TObject);
    procedure ExplorerVarGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure ExplorerProjectPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure ExplorerProjectGetPopupMenu(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; const P: TPoint;
      var AskParent: Boolean; var PopupMenu: TPopupMenu);
    procedure N46Click(Sender: TObject);
    procedure N48Click(Sender: TObject);
    procedure ExplorerProjectEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure ExplorerProjectNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: string);
    procedure BCloseProjectStrucClick(Sender: TObject);
    procedure BCloseStrucClick(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N50Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure ExplorerProjectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Source1Click(Sender: TObject);
    procedure SaveDialogCanClose(Sender: TObject; var CanClose: Boolean);
    procedure Include1Click(Sender: TObject);
    procedure N44Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure PageControl1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure N55Click(Sender: TObject);
    procedure N54Click(Sender: TObject);
    procedure N58Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N60Click(Sender: TObject);
    procedure RTF2Click(Sender: TObject);
    procedure HTML2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SynCompletionExecute(Kind: SynCompletionType; Sender: TObject;
      var CurrentInput: string; var x, y: Integer; var CanExecute: Boolean);
    procedure N13Click(Sender: TObject);
    procedure N66Click(Sender: TObject);
    procedure N67Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure N72Click(Sender: TObject);
    procedure N73Click(Sender: TObject);
    procedure N78Click(Sender: TObject);
    procedure N79Click(Sender: TObject);
    procedure N80Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N81Click(Sender: TObject);
    procedure N82Click(Sender: TObject);
    procedure N85Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ExplorerVarGetPopupMenu(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; const P: TPoint;
      var AskParent: Boolean; var PopupMenu: TPopupMenu);
    procedure ExplorerVar1Click(Sender: TObject);
    procedure ExplorerVarDblClick(Sender: TObject);
    procedure N86Click(Sender: TObject);
    procedure d1Click(Sender: TObject);
    procedure N112Click(Sender: TObject);
    procedure N210Click(Sender: TObject);
    procedure N312Click(Sender: TObject);
    procedure N410Click(Sender: TObject);
    procedure N510Click(Sender: TObject);
    procedure N610Click(Sender: TObject);
    procedure N710Click(Sender: TObject);
    procedure N810Click(Sender: TObject);
    procedure N91Click(Sender: TObject);
    procedure N93Click(Sender: TObject);
    procedure N113Click(Sender: TObject);
    procedure N114Click(Sender: TObject);
    procedure N115Click(Sender: TObject);
    procedure N116Click(Sender: TObject);
    procedure N117Click(Sender: TObject);
    procedure N118Click(Sender: TObject);
    procedure N119Click(Sender: TObject);
    procedure N120Click(Sender: TObject);
    procedure N94Click(Sender: TObject);
    procedure N96Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure ASM1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure Delphi1Click(Sender: TObject);
    procedure N99Click(Sender: TObject);
    procedure N100Click(Sender: TObject);
    procedure N103Click(Sender: TObject);
    procedure N104Click(Sender: TObject);
    procedure N105Click(Sender: TObject);
    procedure N106Click(Sender: TObject);
    procedure SynHintExecute(Kind: SynCompletionType; Sender: TObject;
      var CurrentInput: string; var x, y: Integer; var CanExecute: Boolean);
    procedure SynCompletionCodeCompletion(Sender: TObject; var Value: string;
      Shift: TShiftState; Index: Integer; EndToken: Char);
    procedure DLL1Click(Sender: TObject);
    procedure PageControl1MouseMove(Sender: TObject; Shift: TShiftState;
      x, y: Integer);
    procedure ExplorerVarGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: string);
    procedure ExplorerProjectGetHint(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex;
      var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string);
    procedure BCloseH_DClick(Sender: TObject);
    procedure Win32APIHelp1Click(Sender: TObject);
    procedure N121Click(Sender: TObject);
    procedure ExplorerProjectGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure ExplorerVarGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure VirtualStringTree1GetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
  private
    procedure WMProc_LoadFile(var Msg: TMessage); message WM_LOADFILE;
    procedure WMProc_UpdateExplorerVar(var Msg: TMessage);
      message WM_UPDATEEXPLORER_VAR;
    function Compile(const CommandLine: AnsiString; const Dir: AnsiString)
      : AnsiString;
    procedure FileCompile(const FileName: AnsiString; Run: Boolean = False);
    function FindPage(const FindName: AnsiString;
      FindVar: Boolean = True): Boolean;
    procedure FindStrInFile(const S: AnsiString);
    function CreatePage(const FileName: AnsiString; FindVar: Boolean = True)
      : TMyTabSheet;
    procedure DestroyAllPage;
    procedure SaveAll;
    procedure RunProg;
    procedure RunDBG;
    procedure CloseProgAndDBG;
    procedure PageReset(const FindName: AnsiString; FindVar: Boolean = True);
    function FindNode(const NodeName: AnsiString; Src: Boolean): Boolean;
    procedure ModifiProjectFile(const PrtFile: AnsiString);
    procedure SaveProjectAs;
    procedure AddOrDelSpace(AddSpace: Boolean = True);
    procedure RegisterSymbol(Big: Boolean = True);
    function GetFullPath(const Path: AnsiString): AnsiString;
    procedure LoadLastFiles;
    procedure AddLastFiles(const FileName: string);
    procedure MenuLastFilesClick(Sender: TObject);
    procedure ClearP;
    procedure FindVar;
    function FindVarNameAndPath(const VarName: string): TTokenKind;
    procedure SetBookMark(Mark: Integer);
    procedure GoBookMark(Mark: Integer);
    procedure CopyHexData(Types: TCopyHexData = chASM);
    procedure AddSeparator(Separator: Byte);
    procedure ClearHexEditor(HexEditor: TATBinHex);
  public
    procedure CreateExpVar;
    function LoadProject(const FileName: AnsiString): Boolean;
    procedure LoadAsmOrIncFile(const FileName: AnsiString);
    procedure CloseProject;
    procedure Vis(Status: Boolean);
    procedure AppShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
  end;

var
  FormEditor: TFormEditor;

implementation

{$R *.dfm}

uses ShellApi, Options, NewProject, IniFiles, uSearchReplaceText,
  About, FindInFile, ParamRun, uGotoLine, uListsExportsDLL,
  MySynHighlighterAsm, Unit1;

const
  LastFiles = 'Options\LastFiles.lf';
  SynCompletionParam = 'Options\CompletionParam.cp';
  HelpPath = 'Help\Win32API\WIN32.HLP';

type
  PExplorerFieldPrt = ^TExplorerFieldPtr;

  TExplorerFieldPtr = packed record
    NameNode: AnsiString;
    FilePath: AnsiString;
    Project: Boolean;
    DirBol: Boolean;
    Source: Boolean;
    Include: Boolean;
  end;

  PExplorerFieldVar = ^TExplorerFieldVar;

  TExplorerFieldVar = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    NameNode: AnsiString;
    DirBol: Boolean;
  end;

var
  ExpFieldPrt: PExplorerFieldPrt;
  ExpFieldVar: PExplorerFieldVar;

  NodeDirPtr, NodeDirSource, NodeDirInclude, NodeSource, NodeInclude,

    varNodeDirInclude, varNodeDirImport, varNodeDirInterface, varNodeDirMacro,
    varNodeDirStruct, varNodeDirProc, varNodeDirLabel, varNodeDirConst,
    NodeDirVar, NodeDirType, NodeTemp: PVirtualNode;

var
  RecOpt: packed record fH, fW: Integer;
end;
Ini:
TIniFile;
ProjectPath, ProjectFile, ProjectName: AnsiString;
LoadProjectB, Dot: Boolean;

StartupInfoProg, StartupInfoDBG: TStartupInfoA;
ProcessInformationProg, ProcessInformationDBG: TProcessInformation;
ParamRunProg:
AnsiString = '';
ProgRun, DBGRun: Boolean;
ActPage:
Integer = -1;

procedure TFormEditor.ClearHexEditor(HexEditor: TATBinHex);
var
  DefaultValueForHexEditor: TStringStream;
  data : array[0..303] of Word;
begin
  FillChar(data, SizeOf(data), 0);

  DefaultValueForHexEditor := TStringStream.Create;
  DefaultValueForHexEditor.Write(data, SizeOf(data));

  HexEditor.OpenStream(DefaultValueForHexEditor);
end;

procedure TFormEditor.FindVar;
var
  S: string;
  Src: TMyStringList;
  ptrIncludeTemp: PInclude;
begin
  Src := TMyStringList.Create;

  ptrIncludeTemp := nil;
  ptrIncludeTemp := ListInclude;
  while ptrIncludeTemp <> nil do
  begin
    if FileExists(GetFullPath(ptrIncludeTemp^.fName)) then
      Src.LoadFromFile(GetFullPath(ptrIncludeTemp^.fName))

    else if FileExists(ProjectPath + ptrIncludeTemp^.fName) then
      Src.LoadFromFile(ProjectPath + ptrIncludeTemp^.fName)

    else if FileExists(GetFullPath(FormOptions.EditINC.Text + '\' +
      ptrIncludeTemp^.fName)) then
      Src.LoadFromFile(GetFullPath(FormOptions.EditINC.Text + '\' +
        ptrIncludeTemp^.fName));

    S := Src.Text;
    Scan.FindInclude(S);
    ptrIncludeTemp := ptrIncludeTemp^.fNext;
  end;

  ptrInclude := ListInclude;
  while ptrInclude <> nil do
  begin
    if FileExists(GetFullPath(ptrInclude^.fName)) then
      Src.LoadFromFile(GetFullPath(ptrInclude^.fName))
    else if FileExists(ProjectPath + ptrInclude^.fName) then
      Src.LoadFromFile(ProjectPath + ptrInclude^.fName)
    else if FileExists(GetFullPath(FormOptions.EditINC.Text + '\' +
      ptrInclude^.fName)) then
      Src.LoadFromFile(GetFullPath(FormOptions.EditINC.Text + '\' +
        ptrInclude^.fName))

    else
    begin
      ptrIncludeTemp := ListInclude;
      while ptrIncludeTemp <> nil do
      begin
        S := GetFullPath(ExtractFilePath(ptrIncludeTemp^.fName) +
          ptrInclude^.fName);
        if FileExists(S) then
        begin
          Src.LoadFromFile(S);
          Break;
        end;
        ptrIncludeTemp := ptrIncludeTemp^.fNext;
      end;
    end;

    ptrInclude^.fName := Src.fFile;
    S := Src.Text;
    Scan.BeginScan(S, ptrInclude);
    ptrInclude := ptrInclude^.fNext;
  end;
  Src.Free;
end;

function TFormEditor.FindVarNameAndPath(const VarName: string): TTokenKind;
begin
  ptrImport := ListImport;
  while ptrImport <> nil do
  begin

    if ptrImport^.fName = VarName then
    begin
      Result := tkImport;
      Exit;
    end;

    ptrImport := ptrImport^.fNext;
  end;

  ptrInterface := ListInterface;
  while ptrInterface <> nil do
  begin

    if ptrInterface^.fName = VarName then
    begin
      Result := tkInterface;
      Exit;
    end;

    ptrInterface := ptrInterface^.fNext;
  end;

  ptrMacro := ListMacro;
  while ptrMacro <> nil do
  begin

    if ptrMacro^.fName = VarName then
    begin
      Result := tkMacro;
      Exit;
    end;

    ptrMacro := ptrMacro^.fNext;
  end;

  ptrStruct := ListStruct;
  while ptrStruct <> nil do
  begin

    if ptrStruct^.fName = VarName then
    begin
      Result := tkStruct;
      Exit;
    end;

    ptrStruct := ptrStruct^.fNext;
  end;

  ptrStruc := ListStruc;
  while ptrStruc <> nil do
  begin

    if ptrStruc^.fName = VarName then
    begin
      Result := tkStruc;
      Exit;
    end;

    ptrStruc := ptrStruc^.fNext;
  end;

  ptrProc := ListProc;
  while ptrProc <> nil do
  begin

    if ptrProc^.fName = VarName then
    begin
      Result := tkProc;
      Exit;
    end;

    ptrProc := ptrProc^.fNext;
  end;

  ptrLabel := ListLabel;
  while ptrLabel <> nil do
  begin

    if (ptrLabel^.fName = VarName) or (ptrLabel^.fName = '.' + VarName) then
    begin
      Result := tkLabel;
      Exit;
    end;

    ptrLabel := ptrLabel^.fNext;
  end;

  ptrConst := ListConst;
  while ptrConst <> nil do
  begin

    if ptrConst^.fName = VarName then
    begin
      Result := tkConst;
      Exit;
    end;

    ptrConst := ptrConst^.fNext;
  end;

  ptrVar := ListVar;
  while ptrVar <> nil do
  begin

    if ptrVar^.fName = VarName then
    begin
      Result := tkVar;
      Exit;
    end;

    ptrVar := ptrVar^.fNext;
  end;

  ptrType := ListType;
  while ptrType <> nil do
  begin

    if ptrType^.fName = VarName then
    begin
      Result := tkType;
      Exit;
    end;

    ptrType := ptrType^.fNext;
  end;
end;

procedure TFormEditor.Win32APIHelp1Click(Sender: TObject);
var
  S, S2: AnsiString;
begin
  S2 := '';
  S := ExtractFilePath(Application.ExeName) + HelpPath;
  if not FileExists(S) then
  begin
    MessageBoxA(Handle, 'Файл справки не найден!', 'Ошибка!',
      MB_OK or MB_ICONERROR);
    Exit;
  end;

  if (PageControl1.ActivePage is TMyTabSheet) then
  begin
    S2 := (PageControl1.ActivePage as TMyTabSheet).fSynMemo.SelText;
    WinHelpA(Handle, S, HELP_PARTIALKEY, LongInt(PAnsiChar(S2)));
  end
  else
    WinHelpA(Handle, S, HELP_PARTIALKEY, LongInt(PAnsiChar(S2)))
end;

procedure TFormEditor.WMProc_LoadFile(var Msg: TMessage);
var
  Buf: array [0 .. 255] of AnsiChar;
  S, Ext: AnsiString;
begin
  ZeroMemory(@Buf, 255);
  GlobalGetAtomNameA(Msg.WParam, @Buf, 255);
  GlobalDeleteAtom(Msg.WParam);
  S := StrPas(PAnsiChar(@Buf));

  if (not FileExists(S)) { or (not Assigned(FormEditor)) } then
    Exit;

  Ext := LowerCase(ExtractFileExt(S));
  if Ext = '.prt' then
    LoadProject(S);

  if (Ext = '.asm') or (Ext = '.inc') then
    LoadAsmOrIncFile(S);
end;

procedure TFormEditor.WMProc_UpdateExplorerVar(var Msg: TMessage);
begin
  CreateExpVar;
end;

procedure TFormEditor.PageReset(const FindName: AnsiString;
  FindVar: Boolean = True);
var
  I: Integer;
  Str, Str2: AnsiString;
begin
  Str := LowerCase(FindName);

  for I := 1 to PageControl1.PageCount - 1 do
  begin
    Str2 := LowerCase(TMyTabSheet(PageControl1.Pages[I]).fFile);

    if Str = Str2 then
    begin
      (PageControl1.Pages[I] as TMyTabSheet).FilePath := FindName;

      if FindVar then
        PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
      Break;
    end;
  end;
end;

function TFormEditor.FindNode(const NodeName: AnsiString; Src: Boolean)
  : Boolean;
begin
  Result := False;
  with ExplorerProject do
  begin
    if Src then
    begin
      NodeTemp := GetNext(NodeDirSource);
      while NodeTemp <> NodeDirInclude do
      begin
        ExpFieldPrt := GetNodeData(NodeTemp);
        if ExpFieldPrt = nil then
          Exit;

        if LowerCase(NodeName) = LowerCase(ExpFieldPrt^.NameNode) then
        begin
          Result := True;
          Break;
        end;
        NodeTemp := GetNext(NodeTemp);
      end;
    end
    else
    begin
      NodeTemp := GetNext(NodeDirInclude);
      while NodeTemp <> nil do
      begin
        ExpFieldPrt := GetNodeData(NodeTemp);
        if ExpFieldPrt = nil then
          Exit;

        if LowerCase(NodeName) = LowerCase(ExpFieldPrt^.NameNode) then
        begin
          Result := True;
          Break;
        end;
        NodeTemp := GetNext(NodeTemp);
      end;
    end;
  end;
end;

procedure TFormEditor.ModifiProjectFile(const PrtFile: AnsiString);
var
  F: TextFile;
  CountAsm, CountInc: Integer;
begin
  if PrtFile = '' then
    Exit;

  AssignFile(F, PrtFile);
{$I-}
  Rewrite(F);
{$I+}
  if IOResult = 0 then
    with ExplorerProject do
    begin
      NodeTemp := GetNext(NodeDirSource);
      ExpFieldPrt := GetNodeData(NodeTemp);
      Writeln(F, '; FASM Editor');
      Writeln(F);
      Writeln(F, 'include ', '"', ExpFieldPrt^.NameNode, '"');
      Writeln(F);
      Writeln(F, 'if 2 * 2 = 5');
      Writeln(F, '[options]');
      Writeln(F, '  countAsm=', 0);
      Writeln(F, '  countInc=', 0);
      Writeln(F, '[asm]');

      NodeTemp := GetNext(NodeDirSource);
      CountAsm := 1;
      while NodeTemp <> NodeDirInclude do
      begin
        ExpFieldPrt := GetNodeData(NodeTemp);
        Writeln(F, '  asm', CountAsm, '=', '"',
          ExtractFileName(ExpFieldPrt^.NameNode), '"');
        NodeTemp := GetNext(NodeTemp);
        Inc(CountAsm);
      end;

      Writeln(F, '[inc]');
      NodeTemp := GetNext(NodeDirInclude);
      CountInc := 1;
      while NodeTemp <> nil do
      begin
        ExpFieldPrt := GetNodeData(NodeTemp);
        Writeln(F, '  inc', CountInc, '=', '"',
          ExtractFileName(ExpFieldPrt^.NameNode), '"');
        NodeTemp := GetNext(NodeTemp);
        Inc(CountInc);
      end;
      Writeln(F, 'end if');
      CloseFile(F);
    end
  else
  begin
    MessageBoxA(Handle, PAnsiChar('Произошла ошибка при записи файла. ' +
      PrtFile), 'Ошибка!', MB_ICONERROR or MB_OK);
    Exit;
  end;

  Dec(CountAsm);
  Dec(CountInc);
  Ini := TIniFile.Create(PrtFile);
  Ini.WriteInteger('options', 'countAsm', CountAsm);
  Ini.WriteInteger('options', 'countInc', CountInc);
  Ini.Free;
end;

procedure TFormEditor.SaveProjectAs;
  procedure PageResetFile(const FindName, NewName: AnsiString);
  var
    I: Integer;
    Str, Str2: AnsiString;
  begin
    Str := LowerCase(FindName);

    for I := 1 to PageControl1.PageCount - 1 do
    begin
      Str2 := LowerCase(TMyTabSheet(PageControl1.Pages[I]).fFile);

      if Str = Str2 then
      begin
        PageControl1.Pages[I].Caption := ExtractFileName(NewName);
        (PageControl1.Pages[I] as TMyTabSheet).fFile := NewName;
        Break;
      end;
    end;
  end;

var
  StrFileName, StrNameNode: AnsiString;
  S: AnsiString;
begin
  S := ProjectFile;
  if (not FileExists(ProjectFile)) or (NodeDirPtr = nil) then
    Exit;

  with ExplorerProject do
  begin
    NodeTemp := NodeDirPtr;
    while NodeTemp <> nil do
    begin
      ExpFieldPrt := GetNodeData(NodeTemp);

      if not ExpFieldPrt^.DirBol then
        with ExpFieldPrt^ do
        begin
          if Project then
          begin
            SaveDialog.Filter := 'Project (*.ptr)|*.prt';
            SaveDialog.FileName := NameNode + '.prt';

            if not SaveDialog.Execute then
              Exit
            else
              StrFileName := SaveDialog.FileName;

            if ExtractFileExt(StrFileName) = '' then
              StrFileName := StrFileName + '.prt';

            StrNameNode := ExtractFileName(StrFileName);
            ProjectFile := StrFileName;
            ProjectPath := ExtractFilePath(StrFileName);
            NameNode := Copy(StrNameNode, 1, Pos('.', StrNameNode) - 1);
            ProjectName := NameNode;
          end
          else if Source then
          begin
            SaveDialog.Filter := 'Source (*.asm)|*.asm';
            SaveDialog.FileName := NameNode;

            if not SaveDialog.Execute then
              Exit
            else
              StrFileName := SaveDialog.FileName;

            if ExtractFileExt(StrFileName) = '' then
              StrFileName := StrFileName + '.asm';

            NameNode := ExtractFileName(StrFileName);
            PageResetFile(FilePath, StrFileName);
          end
          else if Include then
          begin
            SaveDialog.Filter := 'Include (*.inc)|*.inc';
            SaveDialog.FileName := NameNode;

            if not SaveDialog.Execute then
              Exit
            else
              StrFileName := SaveDialog.FileName;

            if ExtractFileExt(StrFileName) = '' then
              StrFileName := StrFileName + '.inc';

            NameNode := ExtractFileName(StrFileName);
            PageResetFile(FilePath, StrFileName);
          end;

          if not CopyFileA(PAnsiChar(FilePath), PAnsiChar(StrFileName), False)
          then
          begin
            MessageBoxA(Handle, 'Произошла ошибка при копировании проекта.',
              'Ошибка!', MB_ICONERROR or MB_OK);
            LoadProject(S);
            Exit;
          end;

          FilePath := StrFileName;
        end;
      NodeTemp := GetNext(NodeTemp);
    end;

    ModifiProjectFile(ProjectFile);
    ExplorerProject.Refresh;
  end;
end;

procedure TFormEditor.SetBookMark(Mark: Integer);
var
  I: Integer;
  Found: Boolean;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
    begin
      Found := False;
      for I := Pred(fSynMemo.Marks.Count) downto 0 do
        if fSynMemo.Marks.Items[I].Line = fSynMemo.CaretY then
        begin
          if fSynMemo.Marks.Items[I].BookmarkNumber = Mark - 351 then
            fSynMemo.CommandProcessor(Mark, #0, nil);
          Found := True;
          Break;
        end;

      if not Found then
        fSynMemo.CommandProcessor(Mark, #0, nil);
    end;
end;

procedure TFormEditor.GoBookMark(Mark: Integer);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
      fSynMemo.CommandProcessor(Mark, #0, nil);
end;

procedure TFormEditor.RunProg;
  procedure RunProgProc;
  var
    S: AnsiString;
  begin
    ProgRun := True;
    with FormEditor do
    begin
      ToolButton7.Enabled := False;
      N14.Enabled := False;
    end;

    S := ProjectPath + ProjectName + '.com';
    if not FileExists(S) then
      S := ProjectPath + ProjectName + '.exe';

    S := '"' + S + '"' + ' "' + ParamRunProg + '"';

    CreateProcessA(nil, PAnsiChar(S), nil, nil, False, NORMAL_PRIORITY_CLASS,
      nil, PAnsiChar(ProjectPath), StartupInfoProg, ProcessInformationProg);

    WaitForMultipleObjects(2, @ProcessInformationProg.hProcess, True, INFINITE);

    ProgRun := False;
    with FormEditor do
    begin
      ToolButton7.Enabled := True;
      N14.Enabled := True;
    end;
  end;

var
  Id: DWORD;
  Thread: THandle;
  I: Integer;
begin
  Thread := CreateThread(0, 0, @RunProgProc, 0, CREATE_SUSPENDED, Id);
  SetThreadPriority(Thread, THREAD_PRIORITY_IDLE);
  ResumeThread(Thread);
end;

procedure TFormEditor.RunDBG;
  procedure RunDBGProc;
  var
    S, S2: AnsiString;
    F: array [0 .. 255] of AnsiChar;
  begin
    DBGRun := True;
    with FormEditor do
    begin
      ToolButton9.Enabled := False;
      N16.Enabled := False;
    end;

    S := ProjectPath + ProjectName + '.com';
    if not FileExists(S) then
      S := ProjectPath + ProjectName + '.exe';

    if not FileExists(S) then
      S := ProjectPath + ProjectName + '.dll';

    CreateProcessA(nil, PAnsiChar('"' + DBG + '"' + ' "' + S + '"'), nil, nil,
      False, NORMAL_PRIORITY_CLASS, nil, nil, StartupInfoDBG,
      ProcessInformationDBG);

    WaitForMultipleObjects(2, @ProcessInformationDBG.hProcess, True, INFINITE);

    DBGRun := False;
    with FormEditor do
    begin
      ToolButton9.Enabled := True;
      N16.Enabled := True;
    end;
  end;

var
  Id: DWORD;
  Thread: THandle;
  I: Integer;
begin
  Thread := CreateThread(0, 0, @RunDBGProc, 0, CREATE_SUSPENDED, Id);
  SetThreadPriority(Thread, THREAD_PRIORITY_IDLE);
  ResumeThread(Thread);
end;

procedure TFormEditor.RegisterSymbol(Big: Boolean);
var
  A, B: TBufferCoord;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
    begin
      A := fSynMemo.BlockBegin;
      B := fSynMemo.BlockEnd;

      if Big then
        fSynMemo.SelText := UpperCase(fSynMemo.SelText)
      else
        fSynMemo.SelText := LowerCase(fSynMemo.SelText);

      fSynMemo.BlockBegin := A;
      fSynMemo.BlockEnd := B;

      PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
    end;
end;

procedure TFormEditor.RTF2Click(Sender: TObject);
var
  FileName: string;
  Src: TStringList;
  S: AnsiString;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
    begin
      SaveDialogExport.Filter := SynExporterRTF.DefaultFilter;
      SaveDialogExport.FileName :=
        Copy(Caption, 1, Pos('.', Caption) - 1) + '.rtf';

      if not SaveDialogExport.Execute then
        Exit;

      FileName := SaveDialogExport.FileName;

      if ExtractFileExt(FileName) = '' then
        FileName := FileName + '.rtf';

      SynExporterRTF.Title := Caption;
      SynExporterRTF.Color := fSynMemo.Color;
      SynExporterRTF.Font := fSynMemo.Font;
      SynExporterRTF.ExportAsText := True;
      SynExporterRTF.Highlighter := fSynMemo.Highlighter;

      if fSynMemo.SelText <> '' then
      begin
        Src := TStringList.Create;
        S := AnsiString(fSynMemo.SelText);
        Src.Text := S;
        SynExporterRTF.ExportAll(Src);

        Src.Free;
      end
      else
        SynExporterRTF.ExportAll(fSynMemo.Lines);

      SynExporterRTF.SaveToFile(FileName);
    end;
end;

function TFormEditor.Compile(const CommandLine: AnsiString;
  const Dir: AnsiString): AnsiString;
var
  SA: TSecurityAttributes;
  SI: TStartupInfoA;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array [0 .. 1024] of AnsiChar;
  BytesRead: Cardinal;
  Line: string;
begin
  Application.ProcessMessages;
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;

  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE);
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;

    WasOK := CreateProcessA(nil, PAnsiChar(CommandLine), nil, nil, True, 0, nil,
      PAnsiChar(Dir), SI, PI);

    CloseHandle(StdOutPipeWrite);

    if not WasOK then
      raise Exception.Create('Ошибка. Проверти настройки!')
    else
      try
        Line := '';
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);

          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            Line := Line + Buffer;
          end;

        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    Result := Trim(Line);
    CloseHandle(StdOutPipeRead);
  end;
end;

procedure TFormEditor.CopyHexData(Types: TCopyHexData);
var
  Hex, Res: AnsiString;
  I, J, x: Integer;
  SelStart, SelEnd: Integer;
begin
  Hex := SToHex(HexEditor.SelText);
  Hex := ReplaceText(Hex, ' ', '');

  case Types of
    chASM:
      begin
        I := 1;
        J := 1;
        x := Length(Hex);
        Res := 'mas db ';

        while I <= x do
        begin
          if Hex[I] in ['A' .. 'F', 'H'] then
            Res := Res + '0';

          Res := Res + Hex[I];
          Inc(I);

          Res := Res + Hex[I] + 'h';
          Inc(I);

          if I < x then
            if J = 16 then
            begin
              J := 0;
              Res := Res + ',\' + #13#10 + '       ';
            end
            else
              Res := Res + ', ';

          Inc(J);
        end;
      end;

    chCPP:
      begin
        I := 1;
        J := 1;
        x := Length(Hex);
        Res := 'unsigned char mas[' + IntToStr(x div 2) + '] = {' + #13#10 +
          '       ';

        while I <= x do
        begin
          Res := Res + '0x';

          Res := Res + Hex[I];
          Inc(I);

          Res := Res + Hex[I];
          Inc(I);

          if I < x then
            if J = 16 then
            begin
              J := 0;
              Res := Res + ',' + #13#10 + '       ';
            end
            else
              Res := Res + ', ';

          Inc(J);
        end;

        Res := Res + '};';
      end;

    chDelphi:
      begin
        I := 1;
        J := 1;
        x := Length(Hex);
        Res := 'mas: array[0..' + IntToStr((x div 2) - 1) + '] of Byte = (' + #13#10 + '       ';

        while I <= x do
        begin
          Res := Res + '$';

          Res := Res + Hex[I];
          Inc(I);

          Res := Res + Hex[I];
          Inc(I);

          if I < x then
            if J = 16 then
            begin
              J := 0;
              Res := Res + ',' + #13#10 + '       ';
            end
            else
              Res := Res + ', ';

          Inc(J);
        end;

        Res := Res + ');';
      end;
  end;

  Clipboard.AsText := Res;
end;

procedure TFormEditor.AddSeparator(Separator: Byte);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
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

      PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
    end;
end;

procedure TFormEditor.AddOrDelSpace(AddSpace: Boolean = True);
var
  I, J, Len: Integer;
  InString, OutString: TStringList;
  Str: string;
  A, B: TBufferCoord;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
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
      PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
    end;
end;

procedure TFormEditor.ASM1Click(Sender: TObject);
begin
  CopyHexData;
end;

procedure TFormEditor.C1Click(Sender: TObject);
begin
  CopyHexData(chCPP);
end;

procedure TFormEditor.Delphi1Click(Sender: TObject);
begin
  CopyHexData(chDelphi);
end;

procedure TFormEditor.BCloseH_DClick(Sender: TObject);
begin
  N29.Checked := not N29.Checked;
  PageControlMesAndHex.Visible := N29.Checked;
  Splitter5.Visible := N29.Checked;
  PanelCloseH_D.Visible := N29.Checked;
end;

procedure TFormEditor.BCloseProjectStrucClick(Sender: TObject);
begin
  Splitter1.Visible := False;
  PanelProjectStruc.Visible := False;
  N27.Checked := False;

  if (not N27.Checked) and (not N28.Checked) then
    Panel1.Visible := False;
end;

procedure TFormEditor.BCloseStrucClick(Sender: TObject);
begin
  PanelStructure.Visible := False;
  Splitter1.Visible := False;
  PanelProjectStruc.Align := alClient;
  N28.Checked := False;

  if (not N27.Checked) and (not N28.Checked) then
    Panel1.Visible := False;
end;

procedure TFormEditor.VirtualStringTree1GetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PExplorerFieldPrt;
begin
  Data := Sender.GetNodeData(Node);
  CellText := Data^.NameNode;
end;

procedure TFormEditor.CloseProgAndDBG;
begin
  TerminateProcess(ProcessInformationProg.hProcess, 0);
  TerminateProcess(ProcessInformationDBG.hProcess, 0);
end;

procedure TFormEditor.CloseProject;
begin
  CloseProgAndDBG;
  DestroyAllPage;
  ExplorerProject.Clear;
  ExplorerVar.Clear;

  if LoadProjectB then
  begin
    AddLastFiles(ProjectFile);
    LoadLastFiles;
  end;

  Memo1.Text := '';
  ProjectPath := '';
  ProjectFile := '';
  ProjectName := '';
  LoadProjectB := False;
  ClearP;

  ClearHexEditor(HexEditor);

  with StatusBar1 do
  begin
    Panels[0].Text := 'Строка:';
    Panels[1].Text := 'Столбец:';
    Panels[2].Text := 'Вставка';
    Panels[3].Text := 'Файл:';
  end;
end;

procedure TFormEditor.CreateExpVar;
var
  NodeDirIncludeExp, NodeDirImportExp, NodeDirInterfaceExp, NodeDirMacroExp,
    NodeDirStructExp, NodeDirProcExp, NodeDirLabelExp, NodeDirConstExp,
    NodeDirVarExp, NodeDirTypeExp: Boolean;
  Scrol: Integer;
  S: string;
  ptrIncludeTemp: PInclude;
begin
  NodeDirIncludeExp := False;
  NodeDirImportExp := False;
  NodeDirInterfaceExp := False;
  NodeDirMacroExp := False;
  NodeDirStructExp := False;
  NodeDirProcExp := False;
  NodeDirLabelExp := False;
  NodeDirConstExp := False;
  NodeDirVarExp := False;
  NodeDirTypeExp := False;

  if not(PageControl1.ActivePage is TMyTabSheet) then
    Exit;

  with ExplorerVar do
  begin
    if varNodeDirInclude <> nil then
      NodeDirIncludeExp := Expanded[varNodeDirInclude];

    if varNodeDirImport <> nil then
      NodeDirImportExp := Expanded[varNodeDirImport];

    if varNodeDirInterface <> nil then
      NodeDirInterfaceExp := Expanded[varNodeDirInterface];

    if varNodeDirMacro <> nil then
      NodeDirMacroExp := Expanded[varNodeDirMacro];

    if varNodeDirStruct <> nil then
      NodeDirStructExp := Expanded[varNodeDirStruct];

    if varNodeDirProc <> nil then
      NodeDirProcExp := Expanded[varNodeDirProc];

    if varNodeDirLabel <> nil then
      NodeDirLabelExp := Expanded[varNodeDirLabel];

    if varNodeDirConst <> nil then
      NodeDirConstExp := Expanded[varNodeDirConst];

    if NodeDirVar <> nil then
      NodeDirVarExp := Expanded[NodeDirVar];

    if NodeDirType <> nil then
      NodeDirTypeExp := Expanded[NodeDirType];
  end;

  ExplorerVar.Clear;
  ExplorerVar.BeginUpdate;

  varNodeDirInclude := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(varNodeDirInclude);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Include';
    DirBol := True;
  end;

  varNodeDirImport := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(varNodeDirImport);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Import';
    DirBol := True;
  end;

  varNodeDirInterface := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(varNodeDirInterface);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Interface';
    DirBol := True;
  end;

  NodeDirType := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(NodeDirType);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Type';
    DirBol := True;
  end;

  varNodeDirMacro := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(varNodeDirMacro);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Macro';
    DirBol := True;
  end;

  varNodeDirStruct := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(varNodeDirStruct);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Struct';
    DirBol := True;
  end;

  varNodeDirProc := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(varNodeDirProc);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Proc';
    DirBol := True;
  end;

  varNodeDirLabel := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(varNodeDirLabel);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Label';
    DirBol := True;
  end;

  varNodeDirConst := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(varNodeDirConst);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Const';
    DirBol := True;
  end;

  NodeDirVar := ExplorerVar.AddChild(nil);
  ExpFieldVar := ExplorerVar.GetNodeData(NodeDirVar);
  with ExpFieldVar^ do
  begin
    fBeginChar := 0;
    fEndChar := 0;
    NameNode := 'Var';
    DirBol := True;
  end;

  with (PageControl1.ActivePage as TMyTabSheet) do
  begin
    S := fSynMemo.Lines.Text;
    Scan := TScan.Create;
    Scan.FindInclude(S);

    S := fSynMemo.Lines.Text;
    Scan.BeginScan(S);

    ptrInclude := ListInclude;
    while ptrInclude <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(varNodeDirInclude);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrInclude^.fBeginChar;
        fEndChar := ptrInclude^.fEndChar;
        NameNode := ptrInclude^.fName;
        DirBol := False;
      end;
      ptrInclude := ptrInclude^.fNext;
    end;

    ptrImport := ListImport;
    while ptrImport <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(varNodeDirImport);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrImport^.fBeginChar;
        fEndChar := ptrImport^.fEndChar;
        NameNode := ptrImport^.fName + ' -> ' + ptrImport^.fData;
        DirBol := False;
      end;
      ptrImport := ptrImport^.fNext;
    end;

    ptrInterface := ListInterface;
    while ptrInterface <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(varNodeDirInterface);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrInterface^.fBeginChar;
        fEndChar := ptrInterface^.fEndChar;
        NameNode := ptrInterface^.fName;
        DirBol := False;
      end;
      ptrInterface := ptrInterface^.fNext;
    end;

    ptrType := ListType;
    while ptrType <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(NodeDirType);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrType^.fBeginChar;
        fEndChar := ptrType^.fEndChar;
        NameNode := ptrType^.fName + ': ' + UpperCase(ptrType^.fTypeName) + ' '
          + ptrType^.fTypeLong;
        DirBol := False;
      end;
      ptrType := ptrType^.fNext;
    end;

    ptrMacro := ListMacro;
    while ptrMacro <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(varNodeDirMacro);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrMacro^.fBeginChar;
        fEndChar := ptrMacro^.fEndChar;
        NameNode := ptrMacro^.fName;
        DirBol := False;
      end;
      ptrMacro := ptrMacro^.fNext;
    end;

    ptrStruct := ListStruct;
    while ptrStruct <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(varNodeDirStruct);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrStruct^.fBeginChar;
        fEndChar := ptrStruct^.fEndChar;
        NameNode := ptrStruct^.fName;
        DirBol := False;
      end;
      ptrStruct := ptrStruct^.fNext;
    end;

    ptrProc := ListProc;
    while ptrProc <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(varNodeDirProc);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrProc^.fBeginChar;
        fEndChar := ptrProc^.fEndChar;
        NameNode := ptrProc^.fName;
        // + '(' + ptrProc^.fData + ')';
        DirBol := False;
      end;
      ptrProc := ptrProc^.fNext;
    end;

    ptrLabel := ListLabel;
    while ptrLabel <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(varNodeDirLabel);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrLabel^.fBeginChar;
        fEndChar := ptrLabel^.fEndChar;
        NameNode := ptrLabel^.fName;
        DirBol := False;
      end;
      ptrLabel := ptrLabel^.fNext;
    end;

    ptrConst := ListConst;
    while ptrConst <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(varNodeDirConst);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrConst^.fBeginChar;
        fEndChar := ptrConst^.fEndChar;
        NameNode := ptrConst^.fName + ' = ' + ptrConst^.fData;
        DirBol := False;
      end;
      ptrConst := ptrConst^.fNext;
    end;

    ptrVar := ListVar;
    while ptrVar <> nil do
    begin
      NodeTemp := ExplorerVar.AddChild(NodeDirVar);
      ExpFieldVar := ExplorerVar.GetNodeData(NodeTemp);
      with ExpFieldVar^ do
      begin
        fBeginChar := ptrVar^.fBeginChar;
        fEndChar := ptrVar^.fEndChar;
        NameNode := ptrVar^.fName + ': ' + ptrVar^.fTypeLong;
        DirBol := False;
      end;
      ptrVar := ptrVar^.fNext;
    end;
  end;

  Scan.Free;

  ExplorerVar.EndUpdate;

  with ExplorerVar do
  begin
    if (varNodeDirInclude <> nil) and NodeDirIncludeExp then
      Expanded[varNodeDirInclude] := NodeDirIncludeExp;

    if (varNodeDirImport <> nil) and NodeDirImportExp then
      Expanded[varNodeDirImport] := NodeDirImportExp;

    if (varNodeDirInterface <> nil) and NodeDirInterfaceExp then
      Expanded[varNodeDirInterface] := NodeDirInterfaceExp;

    if (varNodeDirMacro <> nil) and NodeDirMacroExp then
      Expanded[varNodeDirMacro] := NodeDirMacroExp;

    if (varNodeDirStruct <> nil) and NodeDirStructExp then
      Expanded[varNodeDirStruct] := NodeDirStructExp;

    if (varNodeDirProc <> nil) and NodeDirProcExp then
      Expanded[varNodeDirProc] := NodeDirProcExp;

    if (varNodeDirLabel <> nil) and NodeDirLabelExp then
      Expanded[varNodeDirLabel] := NodeDirLabelExp;

    if (varNodeDirConst <> nil) and NodeDirConstExp then
      Expanded[varNodeDirConst] := NodeDirConstExp;

    if (NodeDirVar <> nil) and NodeDirVarExp then
      Expanded[NodeDirVar] := NodeDirVarExp;

    if (NodeDirType <> nil) and NodeDirTypeExp then
      Expanded[NodeDirType] := NodeDirTypeExp;
  end;
end;

function TFormEditor.CreatePage(const FileName: AnsiString;
  FindVar: Boolean = True): TMyTabSheet;
var
  S: AnsiString;
begin
  Result := nil;
  if ExtractFileExt(FileName) = '' then
    Exit;

  if not FileExists(FileName) then
  begin
    S := 'Файл ' + ExtractFileName(FileName) + ' не найден!';
    MessageBoxA(Handle, PAnsiChar(S), 'Ошибка!', MB_ICONERROR or MB_OK);
    Exit;
  end;

  MyTabSh := TMyTabSheet.Create(PageControl1, MyTabSheetImageList);
  MyTabSh.Parent := PageControl1;
  MyTabSh.FilePath := FileName;
  PageControl1.ActivePage := MyTabSh;
  SynCompletion.Editor := MyTabSh.fSynMemo;
  SynHint.Editor := MyTabSh.fSynMemo;
  SynCompletionJump.Editor := MyTabSh.fSynMemo;
  TMySynAsmSyn(MyTabSh.fSynMemo.Highlighter).SelectWord := MyTabSh.SelectWord;
  MyTabSh.fSynMemo.Repaint;
  Result := MyTabSh;

  if LowerCase(ExtractFileExt(MyTabSh.fFile)) = '.prt' then
    MyTabSh.ImageIndex := 36
  else if LowerCase(ExtractFileExt(MyTabSh.fFile)) = '.asm' then
    MyTabSh.ImageIndex := 37
  else if LowerCase(ExtractFileExt(MyTabSh.fFile)) = '.inc' then
    MyTabSh.ImageIndex := 38;

  if FindVar then
    PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);

  with StatusBar1 do
  begin
    Panels[0].Text := 'Строка: ' +
      IntToStr((PageControl1.ActivePage as TMyTabSheet).fSynMemo.CaretY);
    Panels[1].Text := 'Столбец: ' +
      IntToStr((PageControl1.ActivePage as TMyTabSheet).fSynMemo.CaretX);
    Panels[2].Text := 'Вставка';
    Panels[3].Text := 'Файл: ' + FileName;
  end;
end;

procedure TFormEditor.d1Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker0);
end;

procedure TFormEditor.N112Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker1);
end;

procedure TFormEditor.N210Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker2);
end;

procedure TFormEditor.N312Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker3);
end;

procedure TFormEditor.N410Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker4);
end;

procedure TFormEditor.N510Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker5);
end;

procedure TFormEditor.N610Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker6);
end;

procedure TFormEditor.N710Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker7);
end;

procedure TFormEditor.N810Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker8);
end;

procedure TFormEditor.N91Click(Sender: TObject);
begin
  SetBookMark(ecSetMarker9);
end;

procedure TFormEditor.N93Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker0);
end;

procedure TFormEditor.N113Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker1);
end;

procedure TFormEditor.N114Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker2);
end;

procedure TFormEditor.N115Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker3);
end;

procedure TFormEditor.N116Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker4);
end;

procedure TFormEditor.N117Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker5);
end;

procedure TFormEditor.N118Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker6);
end;

procedure TFormEditor.N119Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker7);
end;

procedure TFormEditor.N120Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker8);
end;

procedure TFormEditor.N121Click(Sender: TObject);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    FileCompile((PageControl1.ActivePage as TMyTabSheet).fFile);
end;

procedure TFormEditor.N94Click(Sender: TObject);
begin
  GoBookMark(ecGotoMarker9);
end;

procedure TFormEditor.N96Click(Sender: TObject);
var
  I: Integer;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
      for I := Pred(fSynMemo.Marks.Count) downto 0 do
        fSynMemo.ClearBookMark(fSynMemo.Marks[I].BookmarkNumber);
end;

procedure TFormEditor.N99Click(Sender: TObject);
begin
  HexEditor.SelectAll;
end;

procedure TFormEditor.DestroyAllPage;
var
  I: Integer;
  S: AnsiString;
begin
  for I := 1 to PageControl1.PageCount - 1 do
  begin
    PageControl1.ActivePage := PageControl1.Pages[1];
    MyTabSh := (PageControl1.ActivePage as TMyTabSheet);

    S := 'Сохранить файл ' + MyTabSh.Caption + '?';
    if MyTabSh.Modifi then
    begin
      ActiveControl := MyTabSh.fSynMemo;
      SynCompletion.Editor := MyTabSh.fSynMemo;
      SynHint.Editor := MyTabSh.fSynMemo;
      SynCompletionJump.Editor := MyTabSh.fSynMemo;
      TMySynAsmSyn(MyTabSh.fSynMemo.Highlighter).SelectWord :=
        MyTabSh.SelectWord;
      MyTabSh.fSynMemo.Repaint;
      PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);

      with StatusBar1 do
      begin
        Panels[0].Text := 'Строка: ' + IntToStr(MyTabSh.fSynMemo.CaretY);
        Panels[1].Text := 'Столбец: ' + IntToStr(MyTabSh.fSynMemo.CaretX);

        if MyTabSh.fSynMemo.InsertMode then
          Panels[2].Text := 'Вставка'
        else
          Panels[2].Text := 'Перезаписать';

        Panels[3].Text := 'Файл: ' + MyTabSh.fFile;
      end;

      if MessageBoxA(Handle, PAnsiChar(S), 'Внимание!', MB_ICONQUESTION or
        MB_YESNO) = mrYes then
        MyTabSh.SaveToFile;
    end;

    S := MyTabSh.fFile;
    AddLastFiles(S);
    MyTabSh.Free;
  end;

  LoadLastFiles;
end;

procedure TFormEditor.DLL1Click(Sender: TObject);
begin
  FormListsExportsDLL.ShowModal;
end;

procedure TFormEditor.ExplorerProjectDblClick(Sender: TObject);
var
  Ext: AnsiString;
  Data: PExplorerFieldPrt;
begin
  if not Assigned(ExplorerProject.FocusedNode) then
    Exit;

  Data := ExplorerProject.GetNodeData(ExplorerProject.FocusedNode);

  if Data^.FilePath = '' then
    Exit;

  if not FileExists(Data^.FilePath) then
    Exit;

  Ext := ExtractFileExt(Data^.FilePath);

  if (LowerCase(Ext) = '.asm') or (LowerCase(Ext) = '.inc') then
    if not FindPage(Data^.FilePath) then
      CreatePage(Data^.FilePath);
end;

procedure TFormEditor.ExplorerProjectEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  Data: PExplorerFieldPrt;
begin
  Data := Sender.GetNodeData(Node);
  with Data^ do
    Allowed := not DirBol;
end;

procedure TFormEditor.ExplorerProjectGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string);
var
  Data: PExplorerFieldPrt;
begin
  Data := Sender.GetNodeData(Node);
  with Data^ do
    if DirBol then
      Exit
    else
    begin
      LineBreakStyle := hlbForceSingleLine;
      HintText := FilePath;
    end;
end;

procedure TFormEditor.ExplorerProjectGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
var
  Data: PExplorerFieldPrt;
begin
  if Kind <> ikState then Exit;

  Data := Sender.GetNodeData(Node);
  with Data^ do
  begin
    if Project then
      ImageIndex := 0
    else if DirBol then
      if not Sender.Expanded[Node] then
        ImageIndex := 1
      else
        ImageIndex := 2
    else if Source then
      ImageIndex := 3
    else if Include then
      ImageIndex := 4;
  end;
end;

procedure TFormEditor.ExplorerProjectGetPopupMenu(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; const P: TPoint;
  var AskParent: Boolean; var PopupMenu: TPopupMenu);
var
  Data: PExplorerFieldPrt;
begin
  PopupMenu := nil;
  AskParent := False;
  Data := Sender.GetNodeData(Node);
  if (Data <> nil) then
    with Data^ do
    begin
      if Project then
        PopupMenu := PMenuProject
      else if not DirBol then
        PopupMenu := PMenuSrcInc;
    end;
end;

procedure TFormEditor.ExplorerProjectKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    N50Click(nil);
end;

procedure TFormEditor.ExplorerProjectlGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PExplorerFieldPrt;
begin
  Data := Sender.GetNodeData(Node);
  CellText := Data^.NameNode;
end;

procedure TFormEditor.ExplorerProjectNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: string);
  procedure RenamePage(const FindName, NewName: AnsiString);
  var
    I: Integer;
    Str, Str2: AnsiString;
  begin
    Str := LowerCase(FindName);

    for I := 1 to PageControl1.PageCount - 1 do
    begin
      Str2 := LowerCase(TMyTabSheet(PageControl1.Pages[I]).fFile);

      if Str = Str2 then
      begin
        PageControl1.Pages[I].Caption := ExtractFileName(NewName);
        (PageControl1.Pages[I] as TMyTabSheet).fFile := NewName;
        Break;
      end;
    end;
  end;

var
  Data: PExplorerFieldPrt;
  NewName, Str, Ext: AnsiString;
begin
  if NewText = '' then
  begin
    Data := Sender.GetNodeData(Node);
    NewText := Data^.NameNode;
    Exit;
  end;

  NewText := ExtractFileName(NewText);
  Data := Sender.GetNodeData(Node);
  with Data^ do
  begin
    if Project then
    begin
      NewName := ExtractFilePath(FilePath) + NewText + '.prt';
      ProjectName := NewText;
      RenameFile(FilePath, NewName);
      FilePath := NewName;
      ProjectFile := NewName;
      NameNode := NewText;
    end
    else
    begin
      Ext := ExtractFileExt(NewText);
      if Ext = '' then
      begin
        Ext := ExtractFileExt(NameNode);
        NewText := NewText + Ext;
      end;

      if (LowerCase(Ext) = '.asm') or (LowerCase(Ext) = '.inc') then
      begin
        NewName := ExtractFilePath(FilePath) + NewText;
        RenameFile(FilePath, NewName);
        RenamePage(FilePath, NewName);
        FilePath := NewName;
        NameNode := NewText;
        ModifiProjectFile(ProjectFile);
      end;
    end;
  end;
end;

procedure TFormEditor.ExplorerProjectPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PExplorerFieldPrt;
begin
  Data := Sender.GetNodeData(Node);
  with Data^ do
    if Project then
      TargetCanvas.Font.Style := [fsBold];
end;

procedure TFormEditor.ExplorerVar1Click(Sender: TObject);
var
  Data: PExplorerFieldVar;
  S, S2: string;
  I: Integer;
begin
  Data := ExplorerVar.GetNodeData(ExplorerVar.FocusedNode);

  if (Data = nil) or (Data^.DirBol) then
    Exit;
  S := Data^.NameNode;

  for I := 1 to Length(S) do
    if (S[I] in ['=', '-', '(', ':']) and (S[I + 1] in [#32, '>']) then
      Break
    else
      S2 := S2 + S[I];

  S2 := Trim(S2);
  Clipboard.AsText := S2;
end;

procedure TFormEditor.ExplorerVarDblClick(Sender: TObject);
var
  Data: PExplorerFieldVar;
  I: Integer;
begin
  if (not Assigned(ExplorerVar.FocusedNode)) or
    (not(PageControl1.ActivePage is TMyTabSheet)) then
    Exit;

  Data := ExplorerVar.GetNodeData(ExplorerVar.FocusedNode);
  if (Data = nil) or (Data^.DirBol) then
    Exit;

  I := TMyTabSheet(PageControl1.ActivePage).fSynMemo.CharIndexToRowCol
    (Data^.fBeginChar).Line;
  TMyTabSheet(PageControl1.ActivePage).fSynMemo.CaretY := I - 1;
  TMyTabSheet(PageControl1.ActivePage).fSynMemo.CaretY := I;
  TMyTabSheet(PageControl1.ActivePage).fSynMemo.GotoLineAndCenter(I);

  TMyTabSheet(PageControl1.ActivePage).fSynMemo.SelStart := Data^.fBeginChar;
  TMyTabSheet(PageControl1.ActivePage).fSynMemo.SelEnd := Data^.fEndChar;

  ActiveControl := TMyTabSheet(PageControl1.ActivePage).fSynMemo;
end;

procedure TFormEditor.ExplorerVarGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string);
var
  Data: PExplorerFieldVar;
begin
  Data := Sender.GetNodeData(Node);
  with Data^ do
    if DirBol then
      Exit
    else
      HintText := NameNode;
end;

procedure TFormEditor.ExplorerVarGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
var
  Data: PExplorerFieldVar;
begin
  if Kind <> ikState then Exit;

  Data := Sender.GetNodeData(Node);
  with Data^ do
  begin
    if DirBol then
      if not Sender.Expanded[Node] then
        ImageIndex := 1
      else
        ImageIndex := 2
    else
      ImageIndex := 5;
  end;
end;

procedure TFormEditor.ExplorerVarGetPopupMenu(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; const P: TPoint;
  var AskParent: Boolean; var PopupMenu: TPopupMenu);
var
  Data: PExplorerFieldVar;
begin
  PopupMenu := nil;
  AskParent := False;
  Data := Sender.GetNodeData(Node);
  if (Data <> nil) and (not Data^.DirBol) then
    PopupMenu := PMenuExplorerVar;
end;

procedure TFormEditor.ExplorerVarGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PExplorerFieldVar;
begin
  Data := Sender.GetNodeData(Node);
  CellText := Data^.NameNode;
end;

procedure TFormEditor.FileCompile(const FileName: AnsiString;
  Run: Boolean = False);
var
  ErrLine: Integer;
  Str, Str2, S: AnsiString;
  F: array [0 .. 255] of AnsiChar;
  Tab: TMyTabSheet;
  I, J: Integer;
begin
  if FileName = '' then
    Exit;
  if not FileExists(CompilerFASM) then
  begin
    MessageBoxA(Handle, 'Компилятор FASM не найден. ' +
      'Проверти путь в настройках программы!', 'Ошибка!',
      MB_ICONERROR or MB_OK);
    Exit;
  end;

  if (ProgRun) or (DBGRun) then
    if (MessageBoxA(Handle, 'Программа запущена. Закрыть?', 'Внимание!',
      MB_ICONQUESTION or MB_YESNO) = mrYes) then
      CloseProgAndDBG
    else
      Exit;

  SaveAll;
  Memo1.Lines.Clear;
  Memo1.Lines.Add(Compile('"' + CompilerFASM + '"' + '"' + FileName + '"',
    ExtractFilePath(FileName)));

  if (Pos('error', Memo1.Text) > 0) { and (Memo1.Lines.Count > 2) } then
  begin
    for I := 0 to Memo1.Lines.Count - 1 do
      if Pos('[', Memo1.Lines.Strings[I]) > 0 then
      begin
        J := I;
        Break;
      end;

    Str := Memo1.Lines.Strings[J];
    Str2 := Copy(Str, Pos('[', Str) + 1, Length(Str));
    Str := Copy(Str2, 1, Pos(']', Str2) - 1);

    Str2 := Copy(Memo1.Lines.Strings[J], 1,
      Pos('[', Memo1.Lines.Strings[J]) - 1);

    Str2 := GetFullPath(Str2);
    ZeroMemory(@F, 256);
    GetLongPathNameA(PAnsiChar(Str2), F, 255);
    S := StrPas(F);
    if S <> '' then
      Str2 := S;

    if FindPage(Str2) then
      Tab := TMyTabSheet(PageControl1.ActivePage)
    else
      Tab := CreatePage(Str2);

    if Tab = nil then
      Exit;

    Tab.fSynMemo.GotoLineAndCenter(StrToInt(Str));
    Tab.fSynMemo.CaretY := StrToInt(Str) + 1;
    Tab.fSynMemo.CaretY := StrToInt(Str);
    Tab.fSynMemo.CaretX := 0;

    Tab.fSynMemo.ActiveLineColor := clRed;
    FormEditor.ActiveControl := TMyTabSheet(PageControl1.ActivePage).fSynMemo;
  end
  else if Pos('error', Memo1.Text) <= 0 then
  begin
    if Pos('optional settings', Memo1.Text) <= 0 then
      Memo1.Lines.Add('Ok!');

    S := ProjectPath + ProjectName;
    if ((FileExists(S + '.com')) or (FileExists(S + '.exe'))) and (Run) then
      RunProg;
  end;

  S := ProjectPath + ProjectName;
  if FileExists(S + '.com') then
    S := S + '.com'
  else if FileExists(S + '.exe') then
    S := S + '.exe'
  else if FileExists(S + '.dll') then
    S := S + '.dll'
  else if FileExists(S + '.obj') then
    S := S + '.obj'
  else if FileExists(S + '.bin') then
    S := S + '.bin'
  else if FileExists(S + '.sys') then
    S := S + '.sys';

  if FileExists(S) then
    HexEditor.Open(S);

  (PageControl1.ActivePage as TMyTabSheet).fSynMemo.Repaint;
  Memo1.Repaint;
end;

function TFormEditor.FindPage(const FindName: AnsiString;
  FindVar: Boolean = True): Boolean;
var
  I: Integer;
  Str, Str2: AnsiString;
begin
  Result := False;
  Str := LowerCase(FindName);

  for I := 1 to PageControl1.PageCount - 1 do
  begin
    Str2 := LowerCase(TMyTabSheet(PageControl1.Pages[I]).fFile);

    if Str = Str2 then
    begin
      PageControl1.ActivePage := PageControl1.Pages[I];
      ActiveControl := (PageControl1.ActivePage as TMyTabSheet).fSynMemo;
      Result := True;

      MyTabSh := (PageControl1.ActivePage as TMyTabSheet);
      SynCompletion.Editor := MyTabSh.fSynMemo;
      SynHint.Editor := MyTabSh.fSynMemo;
      SynCompletionJump.Editor := MyTabSh.fSynMemo;

      if FindVar then
        PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);

      with StatusBar1 do
      begin
        Panels[0].Text := 'Строка: ' + IntToStr(MyTabSh.fSynMemo.CaretY);
        Panels[1].Text := 'Столбец: ' + IntToStr(MyTabSh.fSynMemo.CaretX);

        if (PageControl1.ActivePage as TMyTabSheet).fSynMemo.InsertMode then
          Panels[2].Text := 'Вставка'
        else
          Panels[2].Text := 'Перезаписать';

        Panels[3].Text := 'Файл: ' + FindName;
      end;

      TMySynAsmSyn(MyTabSh.fSynMemo.Highlighter).SelectWord :=
        MyTabSh.SelectWord;
      MyTabSh.fSynMemo.Repaint;
      Break;
    end;
  end;
end;

procedure TFormEditor.FindStrInFile(const S: AnsiString);
var
  F: AnsiString;
  I: Integer;
  FInc: AnsiString;
  Temp: TStringList;
  Txt: string;
begin
  /// ////////////////////////////////////////////////
  if not(PageControl1.ActivePage is TMyTabSheet) then
    Exit;

  Scan := TScan.Create;
  Temp := TStringList.Create;
  with (PageControl1.ActivePage as TMyTabSheet) do
  begin
    ProcFind(S);

    Txt := fSynMemo.Lines.Text;
    Scan.FindInclude(Txt);

    ptrInclude := ListInclude;
    while ptrInclude <> nil do
    begin
      FInc := ptrInclude^.fName;
      if FileExists(ProjectPath + FInc) then
      begin
        F := ProjectPath + FInc;
        F := GetFullPath(F);
        Temp.LoadFromFile(F);
      end
      else if FileExists(GetFullPath(FInc)) then
      begin
        F := GetFullPath(FInc);
        Temp.LoadFromFile(F);
      end
      else if FileExists(GetFullPath(ExtractFilePath(fFile) + FInc)) then
      begin
        F := GetFullPath(ExtractFilePath(fFile) + FInc);
        Temp.LoadFromFile(F);
      end
      else if FileExists(GetFullPath(FormOptions.EditINC.Text + '\' + FInc))
      then
      begin
        F := GetFullPath(FormOptions.EditINC.Text + '\' + FInc);
        Temp.LoadFromFile(F);
      end
      else
      begin
        ptrInclude := ptrInclude^.fNext;
        Continue;
      end;

      if Pos(LowerCase(S), LowerCase(Temp.Text)) > 0 then
      begin
        if not FindPage(F, False) then
          CreatePage(F, False);

        with (PageControl1.ActivePage as TMyTabSheet) do
        begin
          SearchText(S);
          ProcFind(S);
        end;
      end;
      ptrInclude := ptrInclude^.fNext;
    end;
    Scan.Free;
    PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
  end;
  Temp.Free;
end;

procedure TFormEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseProject;
end;

procedure TFormEditor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // CanClose := False;
  // if MessageBoxA(Handle, 'Выйти из FASM Editor?', 'Внимание!',
  // MB_ICONQUESTION or MB_YESNO) = mrYes then
  // CanClose := True;
end;

procedure TFormEditor.AppShowHint(var HintStr: string; var CanShow: Boolean;
  var HintInfo: THintInfo);
var
  R: TRect;
begin
  if HintInfo.HintControl = PageControl1 then
  begin
    ZeroMemory(@R, SizeOf(R));

    R := PageControl1.TabRect(ActPage);
    if PtInRect(R, HintInfo.CursorPos) and
      (PageControl1.Pages[ActPage] is TMyTabSheet) then
    begin
      HintStr := TMyTabSheet(PageControl1.Pages[ActPage]).fFile;
      HintInfo.CursorRect := R;
    end;
  end;
end;

procedure TFormEditor.FormCreate(Sender: TObject);
var
  F: TFileStream;
begin
  ExplorerProject.NodeDataSize := SizeOf(TExplorerFieldPtr);
  ExplorerVar.NodeDataSize := SizeOf(TExplorerFieldVar);
  Vis(False);

  if FileExists(ExtractFilePath(ParamStr(0)) + LastFiles) then
    ListBoxFile.Items.LoadFromFile(ExtractFilePath(ParamStr(0)) + LastFiles);

  if not FileExists(ExtractFilePath(ParamStr(0)) + SynCompletionParam) then
    Exit;

  F := TFileStream.Create(ExtractFilePath(ParamStr(0)) + SynCompletionParam,
    fmOpenRead);
  F.Read(RecOpt, SizeOf(RecOpt));
  F.Free;

  SynCompletion.NbLinesInWindow := RecOpt.fH;
  SynCompletion.Width := RecOpt.fW;

  ClearHexEditor(HexEditor);
end;

procedure TFormEditor.FormDestroy(Sender: TObject);
var
  F: TFileStream;
begin
  if not DirectoryExists(ExtractFilePath(ParamStr(0)) + 'Options') then
    CreateDir(ExtractFilePath(ParamStr(0)) + 'Options');

  if ListBoxFile.Items.Text <> '' then
  begin
    ListBoxFile.Items.SaveToFile(ExtractFilePath(ParamStr(0)) + LastFiles);
    ListBoxFile.Items.Clear;
  end;

  RecOpt.fH := SynCompletion.NbLinesInWindow;
  RecOpt.fW := SynCompletion.Width;

  F := TFileStream.Create(ExtractFilePath(ParamStr(0)) + SynCompletionParam,
    fmCreate);
  F.Write(RecOpt, SizeOf(RecOpt));
  F.Free;
end;

procedure TFormEditor.FormShow(Sender: TObject);
var
  S, Ext: AnsiString;
begin
  if ParamCount >= 1 then
  begin
    S := ParamStr(1);
    Ext := LowerCase(ExtractFileExt(S));

    if Ext = '.prt' then
      LoadProject(S);

    if Ext = '.asm' then
      LoadAsmOrIncFile(S);

    if Ext = '.inc' then
      LoadAsmOrIncFile(S);
  end;

  LoadLastFiles;
end;

function TFormEditor.GetFullPath(const Path: AnsiString): AnsiString;
var
  fName: PAnsiChar;
  FPath: array [0 .. 255] of AnsiChar;
  S: AnsiString;
begin

  ZeroMemory(@FPath, 255);
  if ExtractFileDrive(Path) = '' then
    S := 'C:\' + Trim(Path)
  else
    S := Trim(Path);

  GetFullPathNameA(PAnsiChar(S), 255, @FPath, fName);
  Result := StrPas(PAnsiChar(@FPath));
end;

procedure TFormEditor.HTML2Click(Sender: TObject);
var
  FileName: string;
  Src: TStringList;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
    begin
      SaveDialogExport.Filter := SynExporterHTML.DefaultFilter;
      SaveDialogExport.FileName := Copy(Caption, 1, Pos('.', Caption) - 1)
        + '.html';

      if not SaveDialogExport.Execute then
        Exit;

      FileName := SaveDialogExport.FileName;

      if ExtractFileExt(FileName) = '' then
        FileName := FileName + '.html';

      SynExporterHTML.Title := Caption;
      SynExporterHTML.Color := fSynMemo.Color;
      SynExporterHTML.Font := fSynMemo.Font;
      SynExporterHTML.ExportAsText := True;
      SynExporterHTML.Highlighter := fSynMemo.Highlighter;

      if fSynMemo.SelText <> '' then
      begin
        Src := TStringList.Create;
        Src.Text := fSynMemo.SelText;
        SynExporterHTML.ExportAll(Src);
        Src.Free;
      end
      else
        SynExporterHTML.ExportAll(fSynMemo.Lines);

      SynExporterHTML.SaveToFile(FileName);
    end;
end;

procedure TFormEditor.Include1Click(Sender: TObject);
var
  Str: AnsiString;
  F: TextFile;
begin
  SaveDialog.Filter := 'Include (*.inc)|*.inc';
  SaveDialog.FileName := 'Include.inc';
  if SaveDialog.Execute then
  begin
    Str := SaveDialog.FileName;

    AssignFile(F, Str);
{$I-}
    Rewrite(F);
{$I+}
    if IOResult <> 0 then
    begin
      MessageBoxA(Handle, 'Произошла ошибка при создании файла.', 'Ошибка!',
        MB_ICONERROR or MB_OK);
      Exit;
    end
    else
      CloseFile(F);

    if FindNode(ExtractFileName(Str), False) then
    begin
      PageReset(Str);
      Exit;
    end;

    ExplorerProject.BeginUpdate;
    NodeTemp := ExplorerProject.AddChild(NodeDirInclude);
    ExpFieldPrt := ExplorerProject.GetNodeData(NodeTemp);
    with ExpFieldPrt^ do
    begin
      NameNode := ExtractFileName(Str);
      FilePath := Str;
      Project := False;
      DirBol := False;
      Source := False;
      Include := True;
    end;

    if FindPage(Str) then
      PageReset(Str)
    else
      CreatePage(Str);

    ExplorerProject.FullExpand;
    ExplorerProject.EndUpdate;
    ModifiProjectFile(ProjectFile);
  end;
end;

procedure TFormEditor.N100Click(Sender: TObject);
var
  S: AnsiString;
  I: Integer;
  F: TextFile;
begin
  S := HexEditor.SelText;
  if S = '' then
  begin
    HexEditor.SelectAll;
    S := HexEditor.SelText;
  end;

  if S = '' then
  begin
    MessageBoxA(Handle, 'Нет данных для сохранения.', 'Ошибка!', MB_ICONERROR or MB_OK);
    Exit;
  end;

  SaveDialog.Filter := 'Binary (*.bin)|*.bin';

  if ProjectName <> '' then
    SaveDialog.FileName := ProjectName + '.bin'
  else
    SaveDialog.FileName := 'Temp.bin';

  if not SaveDialog.Execute then
    Exit;

  AssignFile(F, SaveDialog.FileName);
{$I-}
  Rewrite(F);
{$I+}
  if IOResult <> 0 then
  begin
    MessageBoxA(Handle, 'Произошла ошибка при создании файла.', 'Ошибка!', MB_ICONERROR or MB_OK);
  end
  else
  begin
    Write(F, S);
    CloseFile(F);
  end;
end;

procedure TFormEditor.N103Click(Sender: TObject);
begin
  AddSeparator(1);
end;

procedure TFormEditor.N104Click(Sender: TObject);
begin
  AddSeparator(2);
end;

procedure TFormEditor.N105Click(Sender: TObject);
begin
  FormGotoLine.ShowModal;
end;

procedure TFormEditor.N106Click(Sender: TObject);
begin
  ExplorerVarDblClick(ExplorerVar);
end;

procedure TFormEditor.N10Click(Sender: TObject);
begin
  FormOptions.ShowModal;
end;

procedure TFormEditor.N12Click(Sender: TObject);
begin
  ShowMessage('F1');
end;

procedure TFormEditor.N13Click(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

procedure TFormEditor.N17Click(Sender: TObject);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    (PageControl1.ActivePage as TMyTabSheet).fSynMemo.Undo;

  PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
end;

procedure TFormEditor.N18Click(Sender: TObject);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    (PageControl1.ActivePage as TMyTabSheet).fSynMemo.Redo;

  PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
end;

procedure TFormEditor.N20Click(Sender: TObject);
begin
  SendMessage(ActiveControl.Handle, WM_CUT, 0, 0);

  if ActiveControl is TSynMemo then
    PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
end;

procedure TFormEditor.N21Click(Sender: TObject);
begin
  SendMessage(ActiveControl.Handle, WM_COPY, 0, 0);
end;

procedure TFormEditor.N22Click(Sender: TObject);
begin
  SendMessage(ActiveControl.Handle, WM_PASTE, 0, 0);

  if ActiveControl is TSynMemo then
    PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
end;

procedure TFormEditor.N23Click(Sender: TObject);
begin
  if not(PageControl1.ActivePage is TMyTabSheet) then
    Exit;
  with FormFindInFile do
  begin
    EditFindText.Text := (PageControl1.ActivePage as TMyTabSheet)
      .fSynMemo.SelText;
    ShowModal;
    if (ModalResult <> mrOk) or (EditFindText.Text = '') then
      Exit;
    FindStrInFile(EditFindText.Text);
    EditFindText.Text := '';
  end;
end;

procedure TFormEditor.N24Click(Sender: TObject);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    (PageControl1.ActivePage as TMyTabSheet).ProcFind('');
end;

procedure TFormEditor.N26Click(Sender: TObject);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with FormSearchReplaceText do
    begin
      ShowModal;
      if (EditSearchText.Text <> '') and (EditReplaceText.Text <> '') and
        (ModalResult = mrOk) then
      begin
        (PageControl1.ActivePage as TMyTabSheet)
          .SearchReplaceText(EditSearchText.Text, EditReplaceText.Text);
        PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
      end;
    end;
end;

procedure TFormEditor.N27Click(Sender: TObject);
begin
  if not N27.Checked then
  begin
    Splitter1.Visible := False;
    PanelProjectStruc.Visible := False;
  end
  else
  begin
    PanelProjectStruc.Visible := True;
    Splitter1.Visible := True;
    Panel1.Visible := True;
  end;

  if (not N27.Checked) and (not N28.Checked) then
    Panel1.Visible := False;
end;

procedure TFormEditor.N28Click(Sender: TObject);
begin
  if N28.Checked then
  begin
    PanelProjectStruc.Align := alNone;
    PanelProjectStruc.Align := alTop;
    PanelStructure.Visible := True;
    Splitter1.Visible := True;
    Panel1.Visible := True;
  end
  else
  begin
    PanelStructure.Visible := False;
    Splitter1.Visible := False;
    PanelProjectStruc.Align := alClient;
  end;

  if (not N27.Checked) and (not N28.Checked) then
    Panel1.Visible := False;
end;

procedure TFormEditor.N29Click(Sender: TObject);
begin
  PageControlMesAndHex.Visible := N29.Checked;
  Splitter5.Visible := N29.Checked;
  PanelCloseH_D.Visible := N29.Checked;
end;

procedure TFormEditor.N2Click(Sender: TObject);
var
  Res: Boolean;
begin
  with FormNewProject do
  begin
    ShowModal;

    if F = '' then
      Exit;

    Res := LoadProject(F);
    Application.ProcessMessages;

    if Res then
      SaveProjectAs;

    F := '';
  end;
end;

procedure TFormEditor.N30Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, 'calc.exe', nil, nil, SW_SHOWNORMAL);
end;

procedure TFormEditor.N33Click(Sender: TObject);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    (PageControl1.ActivePage as TMyTabSheet).SaveToFile;
end;

procedure TFormEditor.N34Click(Sender: TObject);
begin
  if LoadProjectB then
    SaveProjectAs;
end;

procedure TFormEditor.N36Click(Sender: TObject);
begin
  Close;
end;

procedure TFormEditor.N37Click(Sender: TObject);
var
  I: Integer;
  S: AnsiString;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
  begin
    MyTabSh := (PageControl1.ActivePage as TMyTabSheet);
    S := 'Сохранить файл ' + MyTabSh.Caption + '?';
    if MyTabSh.Modifi then
      if MessageBoxA(Handle, PAnsiChar(S), 'Внимание!', MB_ICONQUESTION or
        MB_YESNO) = mrYes then
        MyTabSh.SaveToFile;

    S := MyTabSh.fFile;
    I := PageControl1.ActivePageIndex;
    MyTabSh.Free;
    PageControl1.ActivePageIndex := I - 1;

    if (PageControl1.ActivePage is TMyTabSheet) then
    begin
      MyTabSh := (PageControl1.ActivePage as TMyTabSheet);

      ActiveControl := MyTabSh.fSynMemo;
      SynCompletion.Editor := MyTabSh.fSynMemo;
      SynHint.Editor := MyTabSh.fSynMemo;
      SynCompletionJump.Editor := MyTabSh.fSynMemo;

      TMySynAsmSyn(MyTabSh.fSynMemo.Highlighter).SelectWord :=
        MyTabSh.SelectWord;
      MyTabSh.fSynMemo.Repaint;

      PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);

      with StatusBar1 do
      begin
        Panels[0].Text := 'Строка: ' + IntToStr(MyTabSh.fSynMemo.CaretY);
        Panels[1].Text := 'Столбец: ' + IntToStr(MyTabSh.fSynMemo.CaretX);

        if MyTabSh.fSynMemo.InsertMode then
          Panels[2].Text := 'Вставка'
        else
          Panels[2].Text := 'Перезаписать';

        Panels[3].Text := 'Файл: ' + MyTabSh.fFile;
      end;
    end
    else
    begin
      ExplorerVar.Clear;

      with StatusBar1 do
      begin
        Panels[0].Text := 'Строка:';
        Panels[1].Text := 'Столбец:';
        Panels[2].Text := 'Вставка';
        Panels[3].Text := 'Файл:';
      end;
    end;

    AddLastFiles(S);
    LoadLastFiles;
  end;
end;

procedure TFormEditor.N38Click(Sender: TObject);
begin
  Vis(False);
  CloseProject;
end;

procedure TFormEditor.N3Click(Sender: TObject);
var
  F, Ext: AnsiString;
  I: Integer;
begin
  OpenFileDialog.FileName := '';
  OpenFileDialog.Filter :=
    'Project (*.ptr)|*.prt|Source (*.asm)|*.asm|Include (*.inc)|*.inc';

  if OpenFileDialog.Execute then
    for I := 0 to OpenFileDialog.Files.Count - 1 do
    begin
      F := OpenFileDialog.Files.Strings[I];
      if not FileExists(F) then
      begin
        MessageBoxA(Handle, PAnsiChar('Файл ' + F + ' не найден!'), 'Ошибка!',
          MB_ICONERROR or MB_OK);
        Continue;
      end;

      Ext := LowerCase(ExtractFileExt(F));

      if Ext = '.prt' then
        LoadProject(F);

      if (Ext = '.asm') or (Ext = '.inc') then
        LoadAsmOrIncFile(F);
    end;
end;

procedure TFormEditor.N41Click(Sender: TObject);
var
  SearchRec: TSearchRec;
  Ext, FileAddName: AnsiString;
  BolSource, BolInclude: Boolean;
  I: Integer;
begin
  OpenFileDialog.FileName := '';
  OpenFileDialog.Filter := 'Source (*.asm)|*.asm|Include (*.inc)|*.inc';

  if not OpenFileDialog.Execute then
    Exit;

  ExplorerProject.BeginUpdate;
  for I := 0 to OpenFileDialog.Files.Count - 1 do
  begin
    FileAddName := OpenFileDialog.Files.Strings[I];
    if not FileExists(FileAddName) then
    begin
      MessageBoxA(Handle, PAnsiChar('Файл ' + FileAddName + ' не найден!'),
        'Ошибка!', MB_ICONERROR or MB_OK);
      Continue;
    end;

    BolSource := False;
    BolInclude := False;
    Ext := ExtractFileExt(FileAddName);

    if LowerCase(Ext) = '.asm' then
      if FindNode(ExtractFileName(FileAddName), True) then
      begin
        NodeTemp := nil;
        MessageBoxA(Handle,
          PAnsiChar('Файл ' + AnsiString(ExtractFileName(FileAddName)) +
          ' уже добавлен в проект!'), 'Внимание!', MB_ICONSTOP or MB_OK);
      end
      else
      begin
        BolSource := True;
        NodeTemp := ExplorerProject.AddChild(NodeDirSource);
      end;

    if LowerCase(Ext) = '.inc' then
      if FindNode(ExtractFileName(FileAddName), False) then
      begin
        NodeTemp := nil;
        MessageBoxA(Handle,
          PAnsiChar('Файл ' + AnsiString(ExtractFileName(FileAddName)) +
          ' уже добавлен в проект!'), 'Внимание!', MB_ICONSTOP or MB_OK);
      end
      else
      begin
        BolInclude := True;
        NodeTemp := ExplorerProject.AddChild(NodeDirInclude);
      end;

    if NodeTemp = nil then
      Continue;

    ExpFieldPrt := ExplorerProject.GetNodeData(NodeTemp);

    with ExpFieldPrt^ do
    begin
      NameNode := ExtractFileName(FileAddName);
      FilePath := FileAddName;
      Project := False;
      DirBol := False;
      Source := BolSource;
      Include := BolInclude;
    end;
  end;

  if FindPage(FileAddName) then
    PageReset(FileAddName)
  else
    CreatePage(FileAddName);

  ExplorerProject.FullExpand;
  ExplorerProject.EndUpdate;
  ModifiProjectFile(ProjectFile);
end;

procedure TFormEditor.N44Click(Sender: TObject);
begin
  SaveAll;
end;

procedure TFormEditor.N46Click(Sender: TObject);
begin
  with ExplorerProject do
    EditNode(FocusedNode, -1);
end;

procedure TFormEditor.N48Click(Sender: TObject);
begin
  ShellExecuteA(Handle, nil, PAnsiChar(ProjectPath), nil, nil, SW_SHOW);
end;

procedure TFormEditor.N50Click(Sender: TObject);
  procedure FindAndDeletePage(const FindName: AnsiString);
  var
    I: Integer;
    Str, Str2: AnsiString;
    S: AnsiString;
  begin
    Str := LowerCase(FindName);

    for I := 1 to PageControl1.PageCount - 1 do
    begin
      Str2 := LowerCase(TMyTabSheet(PageControl1.Pages[I]).fFile);

      if Str = Str2 then
      begin
        if (PageControl1.Pages[I] as TMyTabSheet).Modifi then
        begin
          S := 'Сохранить файл ' + (PageControl1.Pages[I] as TMyTabSheet)
            .Caption + '?';
          if MessageBoxA(Handle, PAnsiChar(S), 'Внимание!', MB_ICONQUESTION or
            MB_YESNO) = mrYes then
            (PageControl1.Pages[I] as TMyTabSheet).SaveToFile;
        end;

        (PageControl1.Pages[I] as TMyTabSheet).Free;
        PageControl1.ActivePageIndex := I - 1;
        Break;
      end;
    end;
  end;

var
  Data: PExplorerFieldPrt;
  I: Integer;
  S: AnsiString;
begin
  if ExplorerProject.FocusedNode = nil then
    Exit;

  Data := ExplorerProject.GetNodeData(ExplorerProject.FocusedNode);
  S := 'Удалить файл ' + Data^.FilePath + ' из проекта?';
  if MessageBoxA(Handle, PAnsiChar(S), 'Внимание!', MB_ICONQUESTION or MB_YESNO)
    = mrYes then
  begin
    FindAndDeletePage(Data^.FilePath);
    ExplorerProject.DeleteSelectedNodes;
    ModifiProjectFile(ProjectFile);
  end;
end;

procedure TFormEditor.N51Click(Sender: TObject);
begin
  if not FindPage(ProjectFile) then
    CreatePage(ProjectFile);
end;

procedure TFormEditor.N54Click(Sender: TObject);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    Clipboard.AsText := (PageControl1.ActivePage as TMyTabSheet).fFile;
end;

procedure TFormEditor.N55Click(Sender: TObject);
var
  S: AnsiString;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
  begin
    S := (PageControl1.ActivePage as TMyTabSheet).fFile;
    ShellExecuteA(Handle, 'OPEN', 'EXPLORER', PAnsiChar('/select, ' + S), '',
      SW_NORMAL);
  end;
end;

procedure TFormEditor.N58Click(Sender: TObject);
begin
  SaveAll;
end;

procedure TFormEditor.N60Click(Sender: TObject);
var
  I, Len: Integer;
  InString, OutString: TStringList;
  Str: string;
  A, B: TBufferCoord;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
    begin
      InString := TStringList.Create;
      OutString := TStringList.Create;
      InString.Text := fSynMemo.SelText;
      Len := fSynMemo.SelLength;

      A := fSynMemo.BlockBegin;
      B := fSynMemo.BlockEnd;

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
      fSynMemo.BlockBegin := A;
      fSynMemo.BlockEnd := B;
      InString.Free;
      OutString.Free;
      PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
    end;
end;

procedure TFormEditor.N66Click(Sender: TObject);
begin
  AddOrDelSpace;
end;

procedure TFormEditor.N67Click(Sender: TObject);
begin
  AddOrDelSpace(False);
end;

procedure TFormEditor.N72Click(Sender: TObject);
begin
  RegisterSymbol;
end;

procedure TFormEditor.N73Click(Sender: TObject);
begin
  RegisterSymbol(False);
end;

procedure TFormEditor.N78Click(Sender: TObject);
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    (PageControl1.ActivePage as TMyTabSheet).BFindNext(nil);
end;

procedure TFormEditor.N79Click(Sender: TObject);
begin
  WinExec('charmap', SW_NORMAL);
end;

procedure TFormEditor.N80Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, 'notepad.exe', nil, nil, SW_SHOWNORMAL);
end;

procedure TFormEditor.N81Click(Sender: TObject);
begin
  with FormParamRun do
  begin
    EditParam.Text := ParamRunProg;
    ShowModal;

    if ModalResult = mrOk then
      ParamRunProg := EditParam.Text;
  end;
end;

procedure TFormEditor.N82Click(Sender: TObject);
begin
  WinExec('cmd.exe', SW_NORMAL);
end;

procedure TFormEditor.N85Click(Sender: TObject);
  function DelComent(const S: string): string;
  var
    I, Len: Integer;
    BCom: Boolean;
    Str: string;
  begin
    BCom := False;
    Str := Trim(S);
    Len := Length(Str);
    for I := 1 to Len do
    begin
      case Str[I] of
        ';':
          BCom := True;
        #10, #13:
          BCom := False;
      end;

      if not BCom then
        Result := Result + Str[I];
    end;
  end;

var
  S, S2: string;
  I, J, K, B: Integer;
  C: AnsiChar;
begin
  if not(PageControl1.ActivePage is TMyTabSheet) then
    Exit;

  with (PageControl1.ActivePage as TMyTabSheet) do
  begin
    S := fSynMemo.Lines.Strings[fSynMemo.CaretY - 1];
    S := DelComent(S);

    if (S = '') or (Pos('include', LowerCase(S)) <= 0) then
      Exit;

    S := Copy(S, 8, Length(S));
    S2 := '';
    for I := 1 to Length(S) do
      if not(S[I] in [#39, '"']) then
        S2 := S2 + S[I];

    S2 := Trim(S2);
    S := GetFullPath(ProjectPath + S2);

    if not FileExists(S) then
    begin
      S := GetFullPath(S2);
      if not FileExists(S) then
      begin
        S := ExtractFilePath((PageControl1.ActivePage as TMyTabSheet).fFile);
        S := GetFullPath(S + Trim(S2));
        if not FileExists(S) then
        begin
          S := GetFullPath(Trim(FormOptions.EditINC.Text) + '\' + S2);
          if not FileExists(S) then
            Exit;
        end;
      end;
    end;

    if not FindPage(S) then
      CreatePage(S);
  end;
end;

procedure TFormEditor.N86Click(Sender: TObject);
var
  S, S2: string;
  Tab: TMyTabSheet;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
    begin
      S := fSynMemo.WordAtCursor;
      if S = '' then
        Exit;

      S2 := fSynMemo.Text;
      Scan := TScan.Create;
      Scan.FindInclude(S2);
      FindVar;
      Scan.BeginScan(S2);

      case FindVarNameAndPath(S) of
        tkImport:
          begin
            if ptrImport^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrImport^.fBeginChar;
              fSynMemo.SelEnd := ptrImport^.fEndChar;
            end
            else
            begin
              if FindPage(ptrImport^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrImport^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrImport^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrImport^.fEndChar;
            end;
          end;

        tkInterface:
          begin
            if ptrInterface^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrInterface^.fBeginChar;
              fSynMemo.SelEnd := ptrInterface^.fEndChar;
            end
            else
            begin
              if FindPage(ptrInterface^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrInterface^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrInterface^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrInterface^.fEndChar;
            end;
          end;

        tkMacro:
          begin
            if ptrMacro^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrMacro^.fBeginChar;
              fSynMemo.SelEnd := ptrMacro^.fEndChar;
            end
            else
            begin
              if FindPage(ptrMacro^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrMacro^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrMacro^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrMacro^.fEndChar;
            end;
          end;

        tkStruct:
          begin
            if ptrStruct^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrStruct^.fBeginChar;
              fSynMemo.SelEnd := ptrStruct^.fEndChar;
            end
            else
            begin
              if FindPage(ptrStruct^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrStruct^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrStruct^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrStruct^.fEndChar;
            end;
          end;

        tkStruc:
          begin
            if ptrStruc^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrStruc^.fBeginChar;
              fSynMemo.SelEnd := ptrStruc^.fEndChar;
            end
            else
            begin
              if FindPage(ptrStruc^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrStruc^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrStruc^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrStruc^.fEndChar;
            end;
          end;

        tkProc:
          begin
            if ptrProc^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrProc^.fBeginChar;
              fSynMemo.SelEnd := ptrProc^.fEndChar;
            end
            else
            begin
              if FindPage(ptrProc^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrProc^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrProc^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrProc^.fEndChar;
            end;
          end;

        tkVar:
          begin
            if ptrVar^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrVar^.fBeginChar;
              fSynMemo.SelEnd := ptrVar^.fEndChar;
            end
            else
            begin
              if FindPage(ptrVar^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrVar^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrVar^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrVar^.fEndChar;
            end;
          end;

        tkType:
          begin
            if ptrType^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrType^.fBeginChar;
              fSynMemo.SelEnd := ptrType^.fEndChar;
            end
            else
            begin
              if FindPage(ptrType^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrType^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrType^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrType^.fEndChar;
            end;
          end;

        tkLabel:
          begin
            if ptrLabel^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrLabel^.fBeginChar;
              fSynMemo.SelEnd := ptrLabel^.fEndChar;
            end
            else
            begin
              if FindPage(ptrLabel^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrLabel^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrLabel^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrLabel^.fEndChar;
            end;
          end;

        tkConst:
          begin
            if ptrConst^.FInc = nil then
            begin
              fSynMemo.SelStart := ptrConst^.fBeginChar;
              fSynMemo.SelEnd := ptrConst^.fEndChar;
            end
            else
            begin
              if FindPage(ptrConst^.FInc^.fName) then
                Tab := TMyTabSheet(PageControl1.ActivePage)
              else
                Tab := CreatePage(ptrConst^.FInc^.fName);

              Tab.fSynMemo.SelStart := ptrConst^.fBeginChar;
              Tab.fSynMemo.SelEnd := ptrConst^.fEndChar;
            end;
          end;
      end;

      Scan.Free;
      ActiveControl := TMyTabSheet(PageControl1.ActivePage).fSynMemo;
    end;
end;

procedure TFormEditor.PageControl1Change(Sender: TObject);
var
  S: AnsiString;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
  begin
    MyTabSh := (PageControl1.ActivePage as TMyTabSheet);
    ActiveControl := MyTabSh.fSynMemo;
    SynCompletion.Editor := MyTabSh.fSynMemo;
    SynHint.Editor := MyTabSh.fSynMemo;
    SynCompletionJump.Editor := MyTabSh.fSynMemo;
    TMySynAsmSyn(MyTabSh.fSynMemo.Highlighter).SelectWord := MyTabSh.SelectWord;
    MyTabSh.fSynMemo.Repaint;

    S := MyTabSh.fFile;

    if not LoadProjectB then
    begin
      ProjectFile := S;
      ProjectPath := ExtractFilePath(S);
      ProjectName := ExtractFileName(S);
      ProjectName := Copy(ProjectName, 1, Pos('.', ProjectName) - 1);
    end;

    PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);

    with StatusBar1 do
    begin
      Panels[0].Text := 'Строка: ' + IntToStr(MyTabSh.fSynMemo.CaretY);
      Panels[1].Text := 'Столбец: ' + IntToStr(MyTabSh.fSynMemo.CaretX);

      if MyTabSh.fSynMemo.InsertMode then
        Panels[2].Text := 'Вставка'
      else
        Panels[2].Text := 'Перезаписать';

      Panels[3].Text := 'Файл: ' + S;
    end;
  end
  else
  begin
    ExplorerVar.Clear;
    with StatusBar1 do
    begin
      Panels[0].Text := 'Строка:';
      Panels[1].Text := 'Столбец:';
      Panels[2].Text := 'Вставка';
      Panels[3].Text := 'Файл:';
    end;
  end;
end;

procedure TFormEditor.PageControl1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  I: Integer;
  MPos: TPoint;
  S: AnsiString;
begin
  I := PageControl1.IndexOfTabAt(MousePos.x, MousePos.y);
  if I < 0 then
    Exit;

  PageControl1.ActivePageIndex := I;
  GetCursorPos(MPos);
  if I > 0 then
  begin
    MyTabSh := (PageControl1.ActivePage as TMyTabSheet);
    ActiveControl := MyTabSh.fSynMemo;
    SynCompletion.Editor := MyTabSh.fSynMemo;
    SynHint.Editor := MyTabSh.fSynMemo;
    SynCompletionJump.Editor := MyTabSh.fSynMemo;
    TMySynAsmSyn(MyTabSh.fSynMemo.Highlighter).SelectWord := MyTabSh.SelectWord;
    MyTabSh.fSynMemo.Repaint;

    S := MyTabSh.fFile;

    if not LoadProjectB then
    begin
      ProjectFile := S;
      ProjectPath := ExtractFilePath(S);
      ProjectName := ExtractFileName(S);
      ProjectName := Copy(ProjectName, 1, Pos('.', ProjectName) - 1);
    end;

    PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);

    with StatusBar1 do
    begin
      Panels[0].Text := 'Строка: ' + IntToStr(MyTabSh.fSynMemo.CaretY);
      Panels[1].Text := 'Столбец: ' + IntToStr(MyTabSh.fSynMemo.CaretX);

      if MyTabSh.fSynMemo.InsertMode then
        Panels[2].Text := 'Вставка'
      else
        Panels[2].Text := 'Перезаписать';

      Panels[3].Text := 'Файл: ' + S;
    end;

    PMenuTab.Popup(MPos.x, MPos.y);
  end
  else
  begin
    ExplorerVar.Clear;
    with StatusBar1 do
    begin
      Panels[0].Text := 'Строка:';
      Panels[1].Text := 'Столбец:';
      Panels[2].Text := 'Вставка';
      Panels[3].Text := 'Файл:';
    end;
  end;
end;

procedure TFormEditor.PageControl1MouseMove(Sender: TObject; Shift: TShiftState;
  x, y: Integer);
begin
  ActPage := PageControl1.IndexOfTabAt(x, y);
end;

procedure TFormEditor.SaveAll;
var
  I: Integer;
begin
  for I := 1 to PageControl1.PageCount - 1 do
    if PageControl1.Pages[I] is TMyTabSheet then
      with (PageControl1.Pages[I] as TMyTabSheet) do
      begin
        SaveToFile;
        fSynMemo.ActiveLineColor := clNone;
      end;
end;

procedure TFormEditor.SaveDialogCanClose(Sender: TObject;
  var CanClose: Boolean);
var
  SearchRec: TSearchRec;
  Str, S: AnsiString;
begin
  CanClose := False;
  Str := SaveDialog.FileName;

  if FindFirst(Str, faAnyFile, SearchRec) = 0 then
  begin
    S := 'Файл ' + ExtractFileName(Str) + ' уже существует. Заменить?';
    if MessageBoxA(SaveDialog.Handle, PAnsiChar(S), 'Внимание!',
      MB_ICONQUESTION or MB_YESNO) = mrYes then
      CanClose := True;
  end
  else
    CanClose := True;

  FindClose(SearchRec);
end;

procedure TFormEditor.Source1Click(Sender: TObject);
var
  Str: AnsiString;
  F: TextFile;
begin
  SaveDialog.Filter := 'Source (*.asm)|*.asm';
  SaveDialog.FileName := 'Source.asm';
  if SaveDialog.Execute then
  begin
    Str := SaveDialog.FileName;

    AssignFile(F, Str);
{$I-}
    Rewrite(F);
{$I+}
    if IOResult <> 0 then
    begin
      MessageBoxA(Handle, 'Произошла ошибка при создании файла.', 'Ошибка!',
        MB_ICONERROR or MB_OK);
      Exit;
    end
    else
      CloseFile(F);

    if FindNode(ExtractFileName(Str), True) then
    begin
      PageReset(Str);
      Exit;
    end;

    ExplorerProject.BeginUpdate;
    NodeTemp := ExplorerProject.AddChild(NodeDirSource);
    ExpFieldPrt := ExplorerProject.GetNodeData(NodeTemp);
    with ExpFieldPrt^ do
    begin
      NameNode := ExtractFileName(Str);
      FilePath := Str;
      Project := False;
      DirBol := False;
      Source := True;
      Include := False;
    end;

    if FindPage(Str) then
      PageReset(Str)
    else
      CreatePage(Str);

    ExplorerProject.FullExpand;
    ExplorerProject.EndUpdate;
    ModifiProjectFile(ProjectFile);
  end;
end;

procedure TFormEditor.SynCompletionCodeCompletion(Sender: TObject;
  var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char);
var
  x, I: Integer;
  Line: string;
  C: Char;
  Find: Boolean;
  DotCount: Integer;
begin
  Find := False;
  DotCount := 0;

  with (PageControl1.ActivePage as TMyTabSheet) do
  begin
    x := fSynMemo.CaretXY.Char - 1;
    Line := fSynMemo.Lines[fSynMemo.CaretXY.Line - 1];

    for I := Length(Line) downto 1 do
      if (Line[I] = '.') and (not(Line[I] in [#1 .. #32])) then
      begin
        Find := True;
        Inc(DotCount);

        if DotCount = 2 then
          Break;
      end;

    if (Find) and (Value <> '') and (Value[1] = '.') then
      Value := Copy(Value, 2, Length(Value));
  end;

  PostMessage(FormEditor.Handle, WM_UPDATEEXPLORER_VAR, 0, 0);
end;

procedure TFormEditor.SynCompletionExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: string; var x, y: Integer;
  var CanExecute: Boolean);

  function GetName(const S: string; var S2, S3: string): Boolean;
  var
    I: Integer;
    Dot: Integer;
  begin
    Dot := 0;
    Result := False;
    for I := Length(S) downto 1 do
    begin
      if S[I] = '.' then
        Inc(Dot)
      else

        if S[I] in [#1 .. #32]
      { , '(', ')', '[', ']', ',', '=', '\', '/', ':'] } then
        Break
      else if Dot = 0 then
        S2 := S[I] + S2
      else
        S3 := S[I] + S3;

      if Dot > 1 then
      begin
        Result := True;
        Break;
      end
    end;

    // S2 := Trim(S2);
    // S3 := Trim(S3);
  end;

  function stl(const nam: string): string;
  begin
    Result := '\color{clNavy}\style{-B}' + nam +
      '\color{clNone}\column{}\style{+B}';
  end;

  function IsWordBreakChar(AChar: WideChar): Boolean;
  begin
    Result := (Pos(AChar, '()[],=\/:') > 0);
  end;

  function GetPreviousToken(AEditor: TCustomSynEdit): string;
  var
    Line: string;
    x: Integer;
  begin
    Result := '';
    if not Assigned(AEditor) then
      Exit;

    Line := AEditor.Lines[AEditor.CaretXY.Line - 1];
    x := AEditor.CaretXY.Char - 1;
    if (x = 0) or (x > Length(Line)) or (Length(Line) = 0) then
      Exit;

    if IsWordBreakChar(Line[x]) then
      Exit; // Dec(X);

    while (x > 0) and not(IsWordBreakChar(Line[x])) do
    begin
      Result := Line[x] + Result;
      Dec(x);
    end;
  end;

label
  Next;

var
  S, SVarNam, SVarNam2, Line: string;
  ptrP: PField;
  FindB, Dot: Boolean;
  I: Integer;
  C: Char;
begin
  with (PageControl1.ActivePage as TMyTabSheet) do
  begin
    S := fSynMemo.Lines.Text;
    Scan := TScan.Create;

    Dot := GetName(GetPreviousToken(fSynMemo), SVarNam, SVarNam2);

    with SynCompletion do
    begin
      ItemList.BeginUpdate;
      InsertList.BeginUpdate;
      ClearList;

      if SVarNam2 <> '' then
      begin
        S := fSynMemo.Lines.Text;
        Scan.FindInclude(S);
        FindVar;
        Scan.BeginScan(S);

        ptrVar := ListVar;
        while ptrVar <> nil do
        begin
          if ptrVar^.fName = SVarNam2 then
            Break;
          ptrVar := ptrVar^.fNext;
        end;

        if ptrVar <> nil then
        begin
          ptrStruct := ListStruct;
          while ptrStruct <> nil do
          begin
            if ptrStruct^.fName = ptrVar^.fTypeShort then
              Break;
            ptrStruct := ptrStruct^.fNext;
          end;

          if ptrStruct <> nil then
          begin
            ptrP := ptrStruct^.fField;
            while ptrP <> nil do
            begin
              InsertList.Add(ptrP^.fName);
              ItemList.Add(stl('var') + ptrP^.fName +
                ':\color{clBlue}\style{-B} ' + ptrP^.fType);
              ptrP := ptrP^.fNext;
            end;

            S := ptrStruct^.fType;
            ptrStruct := ListStruct;
            while ptrStruct <> nil do
            begin
              if ptrStruct^.fName = S then
                Break;
              ptrStruct := ptrStruct^.fNext;
            end;

            if ptrStruct <> nil then
            begin
              ptrP := ptrStruct^.fField;
              while ptrP <> nil do
              begin
                InsertList.Add(ptrP^.fName);
                ItemList.Add(stl('var') + ptrP^.fName +
                  ':\color{clBlue}\style{-B} ' + ptrP^.fType);
                ptrP := ptrP^.fNext;
              end;
            end;
          end;
        end
        else
        begin
          S := '';
          FindB := False;

          ptrStruct := ListStruct;
          while ptrStruct <> nil do
          begin

            ptrP := ptrStruct^.fField;
            while ptrP <> nil do
            begin
              if ptrP^.fName = SVarNam2 then
              begin
                S := ptrP^.fType;
                FindB := True;
                Break;
              end;
              ptrP := ptrP^.fNext;
            end;

            if FindB then
              Break;

            ptrStruct := ptrStruct^.fNext;
          end;

          ptrStruct := ListStruct;
          while ptrStruct <> nil do
          begin
            if ptrStruct^.fName = S then
              Break;
            ptrStruct := ptrStruct^.fNext;
          end;

          if ptrStruct <> nil then
          begin
            ptrP := ptrStruct^.fField;
            while ptrP <> nil do
            begin
              InsertList.Add(ptrP^.fName);
              ItemList.Add(stl('var') + ptrP^.fName +
                ':\color{clBlue}\style{-B} ' + ptrP^.fType);
              ptrP := ptrP^.fNext;
            end;

            S := ptrStruct^.fType;
            ptrStruct := ListStruct;
            while ptrStruct <> nil do
            begin
              if ptrStruct^.fName = S then
                Break;
              ptrStruct := ptrStruct^.fNext;
            end;

            if ptrStruct <> nil then
            begin
              ptrP := ptrStruct^.fField;
              while ptrP <> nil do
              begin
                InsertList.Add(ptrP^.fName);
                ItemList.Add(stl('var') + ptrP^.fName +
                  ':\color{clBlue}\style{-B} ' + ptrP^.fType);
                ptrP := ptrP^.fNext;
              end;
            end;
          end;
        end;

        ItemList.EndUpdate;
        InsertList.EndUpdate;
        Scan.Free;

        if SVarNam <> '' then
          CurrentInput := SVarNam;
        Exit;
      end;

      if not Dot then
      begin
        Line := fSynMemo.Lines[fSynMemo.CaretXY.Line - 1];
        Line := Copy(Line, 1, fSynMemo.CaretXY.Char - 1);

        for I := Length(Line) downto 1 do
        begin
          C := Line[I];
          if (C in [#1 .. #32]) or
            (not(C in ['0' .. '9', 'A' .. 'Z', 'a' .. 'z', '_', '.'])) then
            Break
          else
            Dot := C = '.';
        end;
      end;

      if Dot then
        CurrentInput := '.' + CurrentInput;

      Scan.ClearList;
      S := fSynMemo.Lines.Text;
      Scan.FindInclude(S);
      FindVar;
      Scan.BeginScan(S);

      ptrImport := ListImport;
      while ptrImport <> nil do
      begin
        InsertList.Add(ptrImport^.fName);
        ItemList.Add(stl('import') + ptrImport^.fName +
          '->\color{clBlue}\style{-B} ' + ptrImport^.fData);
        ptrImport := ptrImport^.fNext;
      end;
      // ***************************************************************************

      ptrInterface := ListInterface;
      while ptrInterface <> nil do
      begin
        InsertList.Add(ptrInterface^.fName);
        ItemList.Add(stl('interface') + ptrInterface^.fName);
        ptrInterface := ptrInterface^.fNext;
      end;
      // ***************************************************************************

      ptrType := ListType;
      while ptrType <> nil do
      begin
        InsertList.Add(ptrType^.fName);
        ItemList.Add(stl('type') + ptrType^.fName + ':\color{clBlue}\style{-B} '
          + UpperCase(ptrType^.fTypeName) + ' ' + ptrType^.fTypeLong);
        ptrType := ptrType^.fNext;
      end;
      // ***************************************************************************

      ptrMacro := ListMacro;
      while ptrMacro <> nil do
      begin
        InsertList.Add(ptrMacro^.fName);
        ItemList.Add(stl('macro') + ptrMacro^.fName);
        ptrMacro := ptrMacro^.fNext;
      end;
      // ***************************************************************************

      ptrStruct := ListStruct;
      while ptrStruct <> nil do
      begin
        InsertList.Add(ptrStruct^.fName);
        ItemList.Add(stl('struct') + ptrStruct^.fName);
        ptrStruct := ptrStruct^.fNext;
      end;
      // ***************************************************************************

      ptrStruc := ListStruc;
      while ptrStruc <> nil do
      begin
        InsertList.Add(ptrStruc^.fName);
        ItemList.Add(stl('struc') + ptrStruc^.fName);
        ptrStruc := ptrStruc^.fNext;
      end;
      // ***************************************************************************

      ptrProc := ListProc;
      while ptrProc <> nil do
      begin
        InsertList.Add(ptrProc^.fName);
        ItemList.Add(stl('proc') + ptrProc^.fName);
        // + '\style{-B}(' + ptrProc^.fData + ')');
        ptrProc := ptrProc^.fNext;
      end;
      // ***************************************************************************

      ptrLabel := ListLabel;
      while ptrLabel <> nil do
      begin
        InsertList.Add(ptrLabel^.fName);
        ItemList.Add(stl('label') + ptrLabel^.fName);
        ptrLabel := ptrLabel^.fNext;
      end;
      // ***************************************************************************

      ptrConst := ListConst;
      while ptrConst <> nil do
      begin
        InsertList.Add(ptrConst^.fName);
        ItemList.Add(stl('const') + ptrConst^.fName +
          '\color{clBlue}\style{-B} = ' + ptrConst^.fData);
        ptrConst := ptrConst^.fNext;
      end;
      // ***************************************************************************

      ptrVar := ListVar;
      while ptrVar <> nil do
      begin
        InsertList.Add(ptrVar^.fName);
        ItemList.Add(stl('var') + ptrVar^.fName + ':\color{clBlue}\style{-B} ' +
          ptrVar^.fTypeLong);
        ptrVar := ptrVar^.fNext;
      end;

      ItemList.EndUpdate;
      InsertList.EndUpdate;
    end;
    Scan.Free;
  end;
end;

procedure TFormEditor.SynHintExecute(Kind: SynCompletionType; Sender: TObject;
  var CurrentInput: string; var x, y: Integer; var CanExecute: Boolean);

  function stl(const nam: string): string;
  begin
    Result := '\color{clNavy}\style{+B}' + nam +
      '\color{clNone}\column{}\style{-B}';
  end;

var
  S, S2: string;
begin
  if (PageControl1.ActivePage is TMyTabSheet) then
    with (PageControl1.ActivePage as TMyTabSheet) do
    begin
      S := fSynMemo.WordAtCursor;
      if S = '' then
      begin
        CanExecute := False;
        Exit;
      end;

      SynHint.ClearList;

      S2 := fSynMemo.Text;
      Scan := TScan.Create;
      Scan.FindInclude(S2);
      FindVar;
      Scan.BeginScan(S2);

      case FindVarNameAndPath(S) of
        tkImport:
          begin
            if ptrImport^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrImport^.FInc^.fName;

            SynHint.ItemList.Text :=
              stl('import ' + ptrImport^.fName + ' -> ' + ptrImport^.fData) +
              ' - ' + ExtractFileName(S2);
          end;

        tkInterface:
          begin
            if ptrInterface^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrInterface^.FInc^.fName;

            SynHint.ItemList.Text := '\color{clNavy}\style{+B}interface ' +
              ptrInterface^.fName + '\color{clNone}\style{-B} - ' +
              ExtractFileName(S2);
          end;

        tkMacro:
          begin
            if ptrMacro^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrMacro^.FInc^.fName;

            SynHint.ItemList.Text := '\color{clNavy}\style{+B}macro ' +
              ptrMacro^.fName + '\color{clNone}\style{-B} - ' +
              ExtractFileName(S2);
          end;

        tkStruct:
          begin
            if ptrStruct^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrStruct^.FInc^.fName;

            SynHint.ItemList.Text := '\color{clNavy}\style{+B}struct ' +
              ptrStruct^.fName + '\color{clNone}\style{-B} - ' +
              ExtractFileName(S2);
          end;

        tkStruc:
          begin
            if ptrStruc^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrStruc^.FInc^.fName;

            SynHint.ItemList.Text := '\color{clNavy}\style{+B}struc ' +
              ptrStruc^.fName + '\color{clNone}\style{-B} - ' +
              ExtractFileName(S2);
          end;

        tkProc:
          begin
            if ptrProc^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrProc^.FInc^.fName;

            SynHint.ItemList.Text := '\color{clNavy}\style{+B}proc ' +
              ptrProc^.fName + '\color{clNone}\style{-B} - ' +
              ExtractFileName(S2);
          end;

        tkVar:
          begin
            if ptrVar^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrVar^.FInc^.fName;

            SynHint.ItemList.Text :=
              stl('var ' + ptrVar^.fName + ': ' + ptrVar^.fTypeLong) + ' - ' +
              ExtractFileName(S2);
          end;

        tkType:
          begin
            if ptrType^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrType^.FInc^.fName;

            SynHint.ItemList.Text :=
              stl('type ' + ptrType^.fName + ': ' +
              UpperCase(ptrType^.fTypeName) + ' ' + ptrType^.fTypeLong) + ' - '
              + ExtractFileName(S2);
          end;

        tkLabel:
          begin
            if ptrLabel^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrLabel^.FInc^.fName;

            SynHint.ItemList.Text := '\color{clNavy}\style{+B}label ' +
              ptrLabel^.fName + '\color{clNone}\style{-B} - ' +
              ExtractFileName(S2);
          end;

        tkConst:
          begin
            if ptrConst^.FInc = nil then
              S2 := fFile
            else
              S2 := ptrConst^.FInc^.fName;

            SynHint.ItemList.Text :=
              stl('const ' + ptrConst^.fName + ' = ' + ptrConst^.fData) + ' - '
              + ExtractFileName(S2);
          end;
      else
        CanExecute := False;
      end;

      Scan.Free;
    end;
end;

procedure TFormEditor.ToolButton10Click(Sender: TObject);
begin
  FileCompile(ProjectFile);
end;

procedure TFormEditor.ToolButton6Click(Sender: TObject);
begin
  if LoadProjectB then
    LoadProject(ProjectFile);
end;

procedure TFormEditor.ToolButton7Click(Sender: TObject);
begin
  FileCompile(ProjectFile, True);
end;

procedure TFormEditor.ToolButton8Click(Sender: TObject);
begin
  CloseProgAndDBG;
end;

procedure TFormEditor.ToolButton9Click(Sender: TObject);
var
  S: AnsiString;
begin
  if not FileExists(DBG) then
  begin
    MessageBoxA(Handle, 'Отладчик не найден. ' +
      'Проверти путь в настройках программы!', 'Ошибка!',
      MB_ICONERROR or MB_OK);
    Exit;
  end;

  S := ProjectPath + ProjectName;
  if (FileExists(S + '.com')) or (FileExists(S + '.exe')) or
    (FileExists(S + '.dll')) then
    RunDBG
  else
    MessageBoxA(Handle, 'Файл *.com, *.exe, *.dll не найден!', 'Внимание!',
      MB_ICONINFORMATION or MB_OK);
end;

procedure TFormEditor.MenuLastFilesClick(Sender: TObject);
  function GetName(const S: string): string;
  var
    I, Len: Integer;
  begin
    Len := Length(S);
    for I := 1 to Len do
      if S[I] <> '&' then
        Result := Result + S[I];
  end;

var
  S, Ext: AnsiString;
begin
  S := GetName(TMenuItem(Sender).Caption);
  S := Copy(S, Pos('-', S) + 2, Length(S));

  if not FileExists(S) then
  begin
    MessageBoxA(Handle, PAnsiChar('Файл ' + S + ' не найден!'), 'Ошибка!',
      MB_ICONSTOP or MB_OK);
    Exit;
  end;

  Ext := LowerCase(ExtractFileExt(S));
  if Ext = '.prt' then
    LoadProject(S);

  if (Ext = '.asm') or (Ext = '.inc') then
    LoadAsmOrIncFile(S);
end;

procedure TFormEditor.LoadLastFiles;
var
  I: Integer;
  M: TMenuItem;
  Ext: string;
begin
  with ListBoxFile.Items do
  begin
    BeginUpdate;
    for I := 0 to N32.Count - 1 do
      N32.Items[0].Destroy;

    for I := 0 to Count - 1 do
    begin
      M := TMenuItem.Create(MainMenu);
      M.OnClick := MenuLastFilesClick;
      M.Caption := IntToStr(I + 1) + ' - ' + Strings[I];

      Ext := LowerCase(ExtractFileExt(Strings[I]));
      if Ext = '.prt' then
        M.ImageIndex := 36
      else if Ext = '.asm' then
        M.ImageIndex := 37
      else if Ext = '.inc' then
        M.ImageIndex := 38;

      N32.Add(M);
    end;

    if N32.Count = 0 then
    begin
      M := TMenuItem.Create(MainMenu);
      M.Caption := 'Пусто';
      N32.Add(M);
    end;

    EndUpdate;
  end;
end;

procedure TFormEditor.AddLastFiles(const FileName: string);
begin
  if FileName = '' then
    Exit;

  with ListBoxFile.Items do
  begin
    if Count = 20 then
      Delete(19);

    Insert(0, FileName);
  end;
end;

function TFormEditor.LoadProject(const FileName: AnsiString): Boolean;
var
  Str: AnsiString;
  I, J: Integer;
begin
  Result := False;

  if FileName = '' then
    Exit;

  if not FileExists(FileName) then
  begin
    MessageBoxA(Handle, PAnsiChar('Файл ' + FileName + ' не найден!'),
      'Ошибка!', MB_ICONERROR or MB_OK);
    Exit;
  end;

  CloseProject;
  ProjectFile := FileName;

  Ini := TIniFile.Create(ProjectFile);
  with ExplorerProject do
  begin
    BeginUpdate;

    ProjectPath := ExtractFilePath(ProjectFile);
    ProjectName := ExtractFileName(ProjectFile);
    ProjectName := Copy(ProjectName, 1, Pos('.', ProjectName) - 1);

    NodeDirPtr := AddChild(nil);
    ExpFieldPrt := GetNodeData(NodeDirPtr);
    with ExpFieldPrt^ do
    begin
      NameNode := ProjectName;
      FilePath := ProjectFile;
      Project := True;
      DirBol := False;
      Source := False;
      Include := False;
    end;

    NodeDirSource := AddChild(NodeDirPtr);
    ExpFieldPrt := GetNodeData(NodeDirSource);
    with ExpFieldPrt^ do
    begin
      NameNode := 'Source';
      FilePath := '';
      Project := False;
      DirBol := True;
      Source := False;
      Include := False;
    end;

    J := Ini.ReadInteger('options', 'countAsm', J);
    for I := 1 to J do
    begin
      Str := Ini.ReadString('asm', 'asm' + IntToStr(I), Str);

      if (not FileExists(ProjectPath + ExtractFileName(Str))) or
        (FindNode(ExtractFileName(Str), True)) or (ExtractFileExt(Str) = '')
      then
        Continue;

      NodeSource := AddChild(NodeDirSource);
      ExpFieldPrt := GetNodeData(NodeSource);
      with ExpFieldPrt^ do
      begin
        NameNode := Str;
        FilePath := ProjectPath + ExtractFileName(Str);
        Project := False;
        DirBol := False;
        Source := True;
        Include := False;
      end;
    end;

    NodeDirInclude := AddChild(NodeDirPtr);
    ExpFieldPrt := GetNodeData(NodeDirInclude);
    with ExpFieldPrt^ do
    begin
      NameNode := 'Include';
      FilePath := '';
      Project := False;
      DirBol := True;
      Source := False;
      Include := False;
    end;

    J := Ini.ReadInteger('options', 'countInc', J);
    for I := 1 to J do
    begin
      Str := Ini.ReadString('inc', 'inc' + IntToStr(I), Str);

      if (not FileExists(ProjectPath + ExtractFileName(Str))) or
        (FindNode(ExtractFileName(Str), False)) or (ExtractFileExt(Str) = '')
      then
        Continue;

      NodeInclude := AddChild(NodeDirInclude);
      ExpFieldPrt := GetNodeData(NodeInclude);
      with ExpFieldPrt^ do
      begin
        NameNode := Str;
        FilePath := ProjectPath + ExtractFileName(Str);
        Project := False;
        DirBol := False;
        Source := False;
        Include := True;
      end;
    end;
    EndUpdate;

    Ini.Free;

    FullExpand;

    NodeTemp := GetNext(NodeDirSource);
    ExpFieldPrt := GetNodeData(NodeTemp);

    if ExpFieldPrt^.FilePath <> '' then
      CreatePage(ExpFieldPrt^.FilePath);

  end;

  Vis(True);
  LoadProjectB := True;
  ModifiProjectFile(ProjectFile);
  Result := True;
end;

procedure TFormEditor.LoadAsmOrIncFile(const FileName: AnsiString);
var
  I: Integer;
  B: Boolean;
  Str, Str2: AnsiString;
begin
  if FileName = '' then
    Exit;

  if not FileExists(FileName) then
  begin
    MessageBoxA(Handle, PAnsiChar('Файл ' + FileName + ' не найден!'),
      'Ошибка!', MB_ICONERROR or MB_OK);
    Exit;
  end;

  Vis(True);

  if not LoadProjectB then
  begin
    ProjectFile := FileName;
    ProjectPath := ExtractFilePath(FileName);
    ProjectName := ExtractFileName(FileName);
    ProjectName := Copy(ProjectName, 1, Pos('.', ProjectName) - 1);
    ToolButton6.Enabled := False;
    N34.Enabled := False;
  end;

  B := False;
  Str := LowerCase(FileName);

  for I := 1 to PageControl1.PageCount - 1 do
  begin
    Str2 := LowerCase(TMyTabSheet(PageControl1.Pages[I]).fFile);

    if Str = Str2 then
    begin
      B := True;
      PageControl1.ActivePage := PageControl1.Pages[I];
      ActiveControl := (PageControl1.ActivePage as TMyTabSheet).fSynMemo;
      Break;
    end;
  end;

  if not B then
    CreatePage(FileName);
end;

procedure TFormEditor.Vis(Status: Boolean);
begin
  ToolButton4.Enabled := Status;
  ToolButton6.Enabled := Status;
  ToolButton7.Enabled := Status;
  ToolButton8.Enabled := Status;
  ToolButton9.Enabled := Status;
  ToolButton10.Enabled := Status;
  ToolButton11.Enabled := Status;
  ToolButton12.Enabled := Status;
  ToolButton13.Enabled := Status;
  ToolButton15.Enabled := Status;
  ToolButton16.Enabled := Status;
  ToolButton17.Enabled := Status;
  ToolButton20.Enabled := Status;
  ToolButton21.Enabled := Status;
  ToolButton22.Enabled := Status;
  ToolButton23.Enabled := Status;
  N9.Enabled := Status;
  N14.Enabled := Status;
  N15.Enabled := Status;
  N16.Enabled := Status;
  N17.Enabled := Status;
  N18.Enabled := Status;
  N20.Enabled := Status;
  N21.Enabled := Status;
  N22.Enabled := Status;
  N23.Enabled := Status;
  N24.Enabled := Status;
  N26.Enabled := Status;
  N33.Enabled := Status;
  N34.Enabled := Status;
  N58.Enabled := Status;
  N60.Enabled := Status;
  N65.Enabled := Status;
  N66.Enabled := Status;
  N67.Enabled := Status;
  N71.Enabled := Status;
  N78.Enabled := Status;
  N81.Enabled := Status;
  N85.Enabled := Status;
  N89.Enabled := Status;
  N105.Enabled := Status;
  N122.Enabled := Status;
end;

procedure TFormEditor.ClearP;
begin
  ExpFieldPrt := nil;
  ExpFieldVar := nil;

  NodeDirPtr := nil;
  NodeDirSource := nil;
  NodeDirInclude := nil;
  NodeSource := nil;
  NodeInclude := nil;

  varNodeDirInclude := nil;
  varNodeDirImport := nil;
  varNodeDirInterface := nil;
  varNodeDirMacro := nil;
  varNodeDirStruct := nil;
  varNodeDirProc := nil;
  varNodeDirLabel := nil;
  varNodeDirConst := nil;
  NodeDirVar := nil;
  NodeDirType := nil;
  NodeTemp := nil;
end;

end.
