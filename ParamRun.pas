unit ParamRun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls;

type
    TFormParamRun = class(TForm)
      Panel1: TPanel;
      Panel2: TPanel;
      Button1: TButton;
      Button2: TButton;
      EditParam: TEdit;
      Label1: TLabel;
    private
      { Private declarations }
    public
      { Public declarations }
    end;

var
  FormParamRun: TFormParamRun;

implementation

{$R *.dfm}

end.
