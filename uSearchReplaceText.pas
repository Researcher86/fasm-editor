unit uSearchReplaceText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormSearchReplaceText = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    EditSearchText: TEdit;
    Label1: TLabel;
    EditReplaceText: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSearchReplaceText: TFormSearchReplaceText;

implementation

{$R *.dfm}

procedure TFormSearchReplaceText.FormShow(Sender: TObject);
begin
  EditSearchText.Text := '';
  EditReplaceText.Text := '';
  EditSearchText.SetFocus;
end;

end.
