unit Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  Spin, SynHighlighterAsm, SynEdit, SynMemo, Buttons,
  ImgList, System.ImageList;

type
  TFormOptions = class(TForm)
    PageControl1: TPageControl;
    Prog: TTabSheet;
    CodeEditor: TTabSheet;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    ColorEdit: TColorBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEditTab: TSpinEdit;
    ColorComent: TColorBox;
    Label5: TLabel;
    Check1Coment: TCheckBox;
    Check2Coment: TCheckBox;
    Check3Coment: TCheckBox;
    BFont: TButton;
    FontDialog1: TFontDialog;
    Label7: TLabel;
    Check1Number: TCheckBox;
    ColorNumber: TColorBox;
    Check2Number: TCheckBox;
    Check3Number: TCheckBox;
    Label8: TLabel;
    Check1String: TCheckBox;
    ColorString: TColorBox;
    Check2String: TCheckBox;
    Check3String: TCheckBox;
    MemoDir: TMemo;
    Label9: TLabel;
    Check1Dir: TCheckBox;
    ColorDir: TColorBox;
    Check2Dir: TCheckBox;
    Check3Dir: TCheckBox;
    MemoCommand: TMemo;
    Label10: TLabel;
    ColorCommand: TColorBox;
    Check1Command: TCheckBox;
    Check2Command: TCheckBox;
    Check3Command: TCheckBox;
    MemoReg: TMemo;
    Label11: TLabel;
    ColorReg: TColorBox;
    Check1Reg: TCheckBox;
    Check2Reg: TCheckBox;
    Check3Reg: TCheckBox;
    MemoRaz: TMemo;
    Label12: TLabel;
    ColorRaz: TColorBox;
    Check1Raz: TCheckBox;
    Check2Raz: TCheckBox;
    Check3Raz: TCheckBox;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    EditFASM: TEdit;
    BFasm: TButton;
    Label6: TLabel;
    EditDBG: TEdit;
    BDBG: TButton;
    SynMemoOpt: TSynMemo;
    Panel2: TPanel;
    EditFont: TEdit;
    Label13: TLabel;
    EditINC: TEdit;
    BINC: TButton;
    TabSheet9: TTabSheet;
    Label14: TLabel;
    MemoJump: TMemo;
    Check1Jump: TCheckBox;
    ColorJump: TColorBox;
    Check2Jump: TCheckBox;
    Check3Jump: TCheckBox;
    TabSheet10: TTabSheet;
    MemoCommandFPU: TMemo;
    Label15: TLabel;
    ColorCommandFPU: TColorBox;
    Check1CommandFPU: TCheckBox;
    Check2CommandFPU: TCheckBox;
    Check3CommandFPU: TCheckBox;
    ImageList1: TImageList;
    ColorBoxActiveLine: TColorBox;
    Label16: TLabel;
    procedure BFasmClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BFontClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BDBGClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure BINCClick(Sender: TObject);
  private
    procedure ApplyOptions(Clos: Boolean = False);
  public
    MySynAsmSyn: TSynCustomAsmHighlighter;
    constructor Create(AOwner: TComponent); override;
  end;

var
  FormOptions: TFormOptions;

var
  CompilerFASM: AnsiString;
  DBG: AnsiString;

implementation

uses Main, TabSheet, RegistryExt;

{$R *.dfm}

const
  OptionsFileName = 'Options\Options.opt';

procedure TFormOptions.ApplyOptions(Clos: Boolean = False);
var
  I: Integer;
begin
  CompilerFASM := EditFASM.Text + ' ';
  DBG := EditDBG.Text + ' ';

  FreeAndNil(MySynAsmSyn);

  SynMemoOpt.Color := ColorEdit.Selected;
  SynMemoOpt.Font := EditFont.Font;
  if SpinEditTab.Value >= 1 then
    SynMemoOpt.TabWidth := SpinEditTab.Value;

  SynMemoOpt.ActiveLineColor := ColorBoxActiveLine.Selected;

  with Opt do
  begin
    CommentAttri.Style := [];

    if Check1Coment.Checked then
      Include(CommentAttri.Style, fsBold);

    if Check2Coment.Checked then
      Include(CommentAttri.Style, fsItalic);

    if Check3Coment.Checked then
      Include(CommentAttri.Style, fsUnderline);

    CommentAttri.Foreground := ColorComent.Selected;
    // ==============================================================================
    NumberAttri.Style := [];

    if Check1Number.Checked then
      Include(NumberAttri.Style, fsBold);

    if Check2Number.Checked then
      Include(NumberAttri.Style, fsItalic);

    if Check3Number.Checked then
      Include(NumberAttri.Style, fsUnderline);

    NumberAttri.Foreground := ColorNumber.Selected;
    // ==============================================================================
    StringAttri.Style := [];

    if Check1String.Checked then
      Include(StringAttri.Style, fsBold);

    if Check2String.Checked then
      Include(StringAttri.Style, fsItalic);

    if Check3String.Checked then
      Include(StringAttri.Style, fsUnderline);

    StringAttri.Foreground := ColorString.Selected;
    // ==============================================================================
    DirAttri.Style := [];

    if Check1Dir.Checked then
      Include(DirAttri.Style, fsBold);

    if Check2Dir.Checked then
      Include(DirAttri.Style, fsItalic);

    if Check3Dir.Checked then
      Include(DirAttri.Style, fsUnderline);

    DirAttri.Foreground := ColorDir.Selected;
    // ==============================================================================
    JumpAttri.Style := [];

    if Check1Jump.Checked then
      Include(JumpAttri.Style, fsBold);

    if Check2Jump.Checked then
      Include(JumpAttri.Style, fsItalic);

    if Check3Jump.Checked then
      Include(JumpAttri.Style, fsUnderline);

    JumpAttri.Foreground := ColorJump.Selected;
    // ==============================================================================
    OperAttri.Style := [];

    if Check1Command.Checked then
      Include(OperAttri.Style, fsBold);

    if Check2Command.Checked then
      Include(OperAttri.Style, fsItalic);

    if Check3Command.Checked then
      Include(OperAttri.Style, fsUnderline);

    OperAttri.Foreground := ColorCommand.Selected;
    // ==============================================================================
    OperAttriFPU.Style := [];

    if Check1CommandFPU.Checked then
      Include(OperAttriFPU.Style, fsBold);

    if Check2CommandFPU.Checked then
      Include(OperAttriFPU.Style, fsItalic);

    if Check3CommandFPU.Checked then
      Include(OperAttriFPU.Style, fsUnderline);

    OperAttriFPU.Foreground := ColorCommandFPU.Selected;

    // ==============================================================================
    RegAttri.Style := [];

    if Check1Reg.Checked then
      Include(RegAttri.Style, fsBold);

    if Check2Reg.Checked then
      Include(RegAttri.Style, fsItalic);

    if Check3Reg.Checked then
      Include(RegAttri.Style, fsUnderline);

    RegAttri.Foreground := ColorReg.Selected;
    // ==============================================================================
    RazAttri.Style := [];

    if Check1Raz.Checked then
      Include(RazAttri.Style, fsBold);

    if Check2Raz.Checked then
      Include(RazAttri.Style, fsItalic);

    if Check3Raz.Checked then
      Include(RazAttri.Style, fsUnderline);

    RazAttri.Foreground := ColorRaz.Selected;
  end;

  MySynAsmSyn := TSynCustomAsmHighlighter.Create(
    LowerCase(Trim(MemoCommand.Text)),
    LowerCase(Trim(MemoCommandFPU.Text)),
    LowerCase(Trim(MemoDir.Text)),
    LowerCase(Trim(MemoJump.Text)),
    LowerCase(Trim(MemoReg.Text)),
    LowerCase(Trim(MemoRaz.Text)),
    Opt
  );

  with FormEditor.PageControl1 do
    for I := 1 to PageCount - 1 do
      if Pages[I] is TCustomTabSheet then
        (Pages[I] as TCustomTabSheet).UpdateOptions;

  if (MySynAsmSyn <> nil) and (Clos) then
    Close;
end;

procedure TFormOptions.BDBGClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    EditDBG.Text := OpenDialog1.FileName;
end;

procedure TFormOptions.BFasmClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    EditFASM.Text := OpenDialog1.FileName;
end;

procedure TFormOptions.Button1Click(Sender: TObject);
begin
  ApplyOptions(True);
  SetEnvironmentVariableA('INCLUDE', PAnsiChar(AnsiString(EditINC.Text)));
end;

procedure TFormOptions.Button3Click(Sender: TObject);
begin
  ApplyOptions;
  SetEnvironmentVariableA('INCLUDE', PAnsiChar(AnsiString(EditINC.Text)));
end;

procedure TFormOptions.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    RegisterFileType(True, False, False)
  else
    UnRegisterFileType(True, False, False);
end;

procedure TFormOptions.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
    RegisterFileType(False, True, False)
  else
    UnRegisterFileType(False, True, False);
end;

procedure TFormOptions.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
    RegisterFileType(False, False, True)
  else
    UnRegisterFileType(False, False, True);
end;

constructor TFormOptions.Create(AOwner: TComponent);
begin
  if FileExists(ExtractFilePath(ParamStr(0)) + OptionsFileName) then
  begin
    CreateNew(AOwner);
    try
       ReadComponentResFile(ExtractFilePath(ParamStr(0)) + OptionsFileName, Self);
    except
      DeleteFile(ExtractFilePath(ParamStr(0)) + OptionsFileName);
    end;
  end
  else
    inherited Create(AOwner);
end;

procedure TFormOptions.FormCreate(Sender: TObject);
begin
  ApplyOptions;
  SetEnvironmentVariableA('INCLUDE', PAnsiChar(AnsiString(EditINC.Text)));
end;

procedure TFormOptions.FormDestroy(Sender: TObject);
begin
  if not DirectoryExists(ExtractFilePath(ParamStr(0)) + 'Options') then
    CreateDir(ExtractFilePath(ParamStr(0)) + 'Options');

  WriteComponentResFile(ExtractFilePath(ParamStr(0)) + OptionsFileName, Self);

  FreeAndNil(MySynAsmSyn);
end;

procedure TFormOptions.BFontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    EditFont.Text := FontDialog1.Font.Name + ', ' + IntToStr(FontDialog1.Font.Size);
    SynMemoOpt.Font := FontDialog1.Font;
    EditFont.Font := FontDialog1.Font;
  end;
end;

procedure TFormOptions.BINCClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do
    try
      Options := [fdoPickFolders];
      if Execute then
        EditINC.Text := FileName;
    finally
      Free;
    end;
end;

end.
