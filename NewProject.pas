unit NewProject;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, ComCtrls, ExtCtrls, ImgList, StdCtrls, System.ImageList;

type
  TFormNewProject = class(TForm)
    Panel1: TPanel;
    ProjectTypeView: TListView;
    ButtonOk: TButton;
    ButtonExit: TButton;
    ImageList: TImageList;
    procedure ProjectTypeViewDblClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    private
      ProjectName: AnsiString;
      ProjectPath: AnsiString;
    public
      F: AnsiString;
    end;

var
  FormNewProject: TFormNewProject;

const
   MS_DOS = 1;
   WIN32 = 2;
   WIN64 = 3;

implementation

uses Main;

{$R *.dfm}

procedure TFormNewProject.ButtonOkClick(Sender: TObject);
begin
  if not Assigned(ProjectTypeView.Selected) then
    ProjectTypeView.Items.Item[0].Selected := True;

  ProjectName := ProjectTypeView.Selected.Caption;
  ProjectPath := AnsiString(ExtractFilePath(ParamStr(0))) + 'Project\';

  if ProjectTypeView.Selected.GroupID = MS_DOS then
    ProjectPath := ProjectPath + 'MS-DOS\';

  if ProjectTypeView.Selected.GroupID = WIN32 then
  begin
    ProjectPath := ProjectPath + 'Win32\';
  end;

  if ProjectTypeView.Selected.GroupID = WIN64 then
  begin
    ProjectPath := ProjectPath + 'Win64\';
  end;

  if ProjectName = 'Window' then
    F := ProjectPath + 'Window\Window.prt';

  if ProjectName = 'Console' then
    F := ProjectPath + 'Console\Console.prt';

  if ProjectName = 'DLL' then
    F := ProjectPath + 'DLL\DLL.prt';

  if ProjectName = 'MSCOFF' then
    F := ProjectPath + 'MSCOFF\MSCOFF.prt';

  if ProjectName = 'Driver' then
    F := ProjectPath + 'Driver\Driver.prt';

  Close;
end;

procedure TFormNewProject.ProjectTypeViewDblClick(Sender: TObject);
begin
  ButtonOkClick(nil);
end;

end.
