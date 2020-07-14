unit RegistryExt;

interface

uses
  Windows, Registry, Forms;

function RegisterFileType(ProjectExt, SourceExt, IncludeExt: Boolean): Boolean;
procedure UnRegisterFileType(ProjectExt, SourceExt, IncludeExt: Boolean);

implementation

const
  FileProjectExt = '.prt';
  FileProjectType = 'ProjectFile';
  // BackUpFileType = 'FASM Editor BackUp';

  FileSourceExt = '.asm';
  FileSourceType = 'SourceFile';
  // BackUpFileType = 'FASM Editor BackUp';

  FileIncludeExt = '.inc';
  FileIncludeType = 'IncludeFile';
  // BackUpFileType = 'FASM Editor BackUp';

procedure UnRegisterFileType(ProjectExt, SourceExt, IncludeExt: Boolean);
var
  PrevDefaultVal: string;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;
    if ProjectExt then
    begin
      DeleteKey(FileProjectExt);
      DeleteKey(FileProjectExt);
    end;

    if SourceExt then
    begin
      DeleteKey(FileSourceExt);
      DeleteKey(FileSourceExt);
    end;

    if IncludeExt then
    begin
      DeleteKey(FileIncludeExt);
      DeleteKey(FileIncludeExt);
    end;

    CloseKey;
    Free;
  end;

  SystemParametersInfo(SPI_SETICONTITLELOGFONT, 0, nil, SPIF_SENDWININICHANGE);
  // SystemParametersInfo(SPI_GETICONTITLELOGFONT, 0, nil, SPIF_SENDWININICHANGE);
end;

function RegisterFileType(ProjectExt, SourceExt, IncludeExt: Boolean): Boolean;
var
  PrevDefaultVal: string;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;

    if ProjectExt then
    begin
      OpenKey(FileProjectExt, True);
      begin
        PrevDefaultVal := ReadString('');

        WriteString('', FileProjectType);
        CloseKey;
        CreateKey(FileProjectType);

        OpenKey(FileProjectType + '\DefaultIcon', True);
        WriteString('', Application.ExeName + ',1');
        CloseKey;

        OpenKey(FileProjectType + '\shell\open\command', True);
        WriteString('', Application.ExeName + ' "%1"');

      end;
    end;

    if SourceExt then
    begin
      OpenKey(FileSourceExt, True);
      begin
        PrevDefaultVal := ReadString('');

        WriteString('', FileSourceType);
        CloseKey;
        CreateKey(FileSourceType);

        OpenKey(FileSourceType + '\DefaultIcon', True);
        WriteString('', Application.ExeName + ',2');
        CloseKey;

        OpenKey(FileSourceType + '\shell\open\command', True);
        WriteString('', Application.ExeName + ' "%1"');

      end;
    end;

    if IncludeExt then
    begin
      OpenKey(FileIncludeExt, True);
      begin
        PrevDefaultVal := ReadString('');

        WriteString('', FileIncludeType);
        CloseKey;
        CreateKey(FileIncludeType);

        OpenKey(FileIncludeType + '\DefaultIcon', True);
        WriteString('', Application.ExeName + ',3');
        CloseKey;

        OpenKey(FileIncludeType + '\shell\open\command', True);
        WriteString('', Application.ExeName + ' "%1"');

      end;
    end;

    CloseKey;
    Free;
  end;
  SystemParametersInfo(SPI_SETICONTITLELOGFONT, 0, nil, SPIF_SENDWININICHANGE);
  // SystemParametersInfo(SPI_GETICONTITLELOGFONT, 0, nil, SPIF_SENDWININICHANGE);
end;

end.
