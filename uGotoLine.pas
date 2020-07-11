unit uGotoLine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TFormGotoLine = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGotoLine: TFormGotoLine;

implementation

uses Main, MyTabSheet;

{$R *.dfm}

procedure TFormGotoLine.Button1Click(Sender: TObject);
var
  I: Integer;
  Find: Boolean;
  S, Mes: string;
begin
  S := ComboBox1.Text;

  with FormEditor.PageControl1 do
    if (ActivePage is TMyTabSheet) then
      with (ActivePage as TMyTabSheet) do
      begin
        if (S = '') or (StrToInt(S) = 0) or (StrToInt(S) > fSynMemo.Lines.Count) then
        begin
          Mes := 'Номер строки должен быть между 1 и ' + IntToStr(fSynMemo.Lines.Count);
          MessageBox(Self.Handle, PChar(Mes), 'Ошибка!', MB_ICONERROR or MB_OK);
          Exit;
        end;

        Find := False;
        for I := 0 to ComboBox1.Items.Count - 1 do
          if LowerCase(S) = LowerCase(ComboBox1.Items.Strings[I]) then Find := True;

          if not Find then ComboBox1.Items.Insert(0, S);

          if ComboBox1.Items.Count > 20 then ComboBox1.Items.Delete(20);

          fSynMemo.GotoLineAndCenter(StrToInt(S));
      end;

  Close;
end;

procedure TFormGotoLine.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', #8, #127]) then Key := #0;
end;

procedure TFormGotoLine.FormShow(Sender: TObject);
begin
  with FormEditor.PageControl1 do
    if (ActivePage is TMyTabSheet) then
      with (ActivePage as TMyTabSheet) do
      begin
        Label1.Caption := 'Номер строки (1 - ' + IntToStr(fSynMemo.Lines.Count) + '):';
        ComboBox1.Text := IntToStr(fSynMemo.CaretY);
      end;

  ComboBox1.SetFocus;
end;

end.
