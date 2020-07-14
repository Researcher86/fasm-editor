program FEditor;



uses
  Windows,
  Messages,
  SyncObjs,
  Forms,
  Main in 'Main.pas' {FormEditor},
  SynHighlighterAsm in 'Source\SynHighlighterAsm.pas',
  Options in 'Options.pas' {FormOptions},
  NewProject in 'NewProject.pas' {FormNewProject},
  TabSheet in 'Source\TabSheet.pas',
  SearchReplaceText in 'SearchReplaceText.pas' {FormSearchReplaceText},
  About in 'About.pas' {FormAbout},
  FindInFile in 'FindInFile.pas' {FormFindInFile},
  ParamRun in 'ParamRun.pas' {FormParamRun},
  RegistryExt in 'Source\RegistryExt.pas',
  AsmSource in 'Source\AsmSource.pas',
  GotoLine in 'GotoLine.pas' {FormGotoLine},
  ListsExportsDLL in 'ListsExportsDLL.pas' {FormListsExportsDLL},
  Utils in 'Source\Utils.pas';

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
