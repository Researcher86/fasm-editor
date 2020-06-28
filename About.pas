unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage;

type
  TFormAbout = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

{$R *.dfm}

end.
