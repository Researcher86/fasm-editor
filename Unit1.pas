unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Menus;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    ToolButton4: TToolButton;
    ToolButton15: TToolButton;
    ToolButton14: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton5: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton7: TToolButton;
    ToolButton10: TToolButton;
    ToolButton23: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ImageList1: TImageList;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N32: TMenuItem;
    N31: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N58: TMenuItem;
    N5: TMenuItem;
    N65: TMenuItem;
    RTF2: TMenuItem;
    HTML2: TMenuItem;
    N83: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N4: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N70: TMenuItem;
    N71: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N84: TMenuItem;
    N85: TMenuItem;
    N77: TMenuItem;
    N89: TMenuItem;
    N105: TMenuItem;
    N88: TMenuItem;
    N24: TMenuItem;
    N78: TMenuItem;
    N23: TMenuItem;
    N26: TMenuItem;
    N8: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N6: TMenuItem;
    N14: TMenuItem;
    N9: TMenuItem;
    N122: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N97: TMenuItem;
    N81: TMenuItem;
    N7: TMenuItem;
    N10: TMenuItem;
    N107: TMenuItem;
    DLL1: TMenuItem;
    N98: TMenuItem;
    N30: TMenuItem;
    N80: TMenuItem;
    N79: TMenuItem;
    N82: TMenuItem;
    N11: TMenuItem;
    Win32APIHelp1: TMenuItem;
    N25: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    TreeView1: TTreeView;
    procedure TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
begin
exit;
end;

end.
