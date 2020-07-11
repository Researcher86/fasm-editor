unit FindInFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TFormFindInFile = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    EditFindText: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFindInFile: TFormFindInFile;

implementation

{$R *.dfm}

procedure TFormFindInFile.FormShow(Sender: TObject);
begin
  EditFindText.SetFocus;
end;

end.
