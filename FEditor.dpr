program FEditor;



uses
  Windows,
  Messages,
  SyncObjs,
  Forms,
  Main in 'Main.pas' {FormEditor},
  MySynHighlighterAsm in 'Source\MySynHighlighterAsm.pas',
  Options in 'Options.pas' {FormOptions},
  NewProject in 'NewProject.pas' {FormNewProject},
  MyTabSheet in 'Source\MyTabSheet.pas',
  uSearchReplaceText in 'uSearchReplaceText.pas' {FormSearchReplaceText},
  About in 'About.pas' {FormAbout},
  FindInFile in 'FindInFile.pas' {FormFindInFile},
  ParamRun in 'ParamRun.pas' {FormParamRun},
  RegistryExt in 'Source\RegistryExt.pas',
  ScanAsmFile in 'Source\ScanAsmFile.pas',
  uGotoLine in 'uGotoLine.pas' {FormGotoLine},
  uListsExportsDLL in 'uListsExportsDLL.pas' {FormListsExportsDLL},
  Constants in 'Source\Constants.pas';

{$R *.res}
{$R rsrc.RES}

var
  A: ATOM;
  CheckEvent: TEvent;
  F: AnsiString;
begin
  CheckEvent := TEvent.Create(nil, False, True, 'FEDITOR_CHECKEXIST');
  if CheckEvent.WaitFor(10) <> wrSignaled then
  begin
    CheckEvent.Free;

    if ParamCount >= 1 then
    begin
      F := ParamStr(1);
      A := GlobalAddAtomA(PAnsiChar(F));
      PostMessage(GetMainFormHandle, WM_LOADFILE, A, 0);
    end;

    Exit;
  end;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormEditor, FormEditor);
  Application.CreateForm(TFormOptions, FormOptions);
  Application.CreateForm(TFormNewProject, FormNewProject);
  Application.CreateForm(TFormSearchReplaceText, FormSearchReplaceText);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormFindInFile, FormFindInFile);
  Application.CreateForm(TFormParamRun, FormParamRun);
  Application.CreateForm(TFormGotoLine, FormGotoLine);
  Application.CreateForm(TFormListsExportsDLL, FormListsExportsDLL);
  Application.OnShowHint := FormEditor.AppShowHint;
  Application.Run;

  while not Application.Terminated do
    Application.ProcessMessages;

  CheckEvent.Free;
end.
