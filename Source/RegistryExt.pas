unit RegistryExt;

interface

uses
  Windows, Registry, Forms;

function RegisterFileType(Ext1, Ext2, Ext3: Boolean): Boolean;
procedure UnRegisterFileType(Ext1, Ext2, Ext3: Boolean);

implementation

const
  FileExt1 = '.prt';
  FileType1 = 'ProjectFile';
  // BackUpFileType1 = 'FASM Editor BackUp';

  FileExt2 = '.asm';
  FileType2 = 'SourceFile';
  // BackUpFileType2 = 'FASM Editor BackUp';

  FileExt3 = '.inc';
  FileType3 = 'IncludeFile';
  // BackUpFileType3 = 'FASM Editor BackUp';

procedure UnRegisterFileType(Ext1, Ext2, Ext3: Boolean);
var
  PrevDefaultVal: string;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;
    if Ext1 then
    begin
      DeleteKey(FileExt1);
      DeleteKey(FileExt1);
    end;

    if Ext2 then
    begin
      DeleteKey(FileExt2);
      DeleteKey(FileExt2);
    end;

    if Ext3 then
    begin
      DeleteKey(FileExt3);
      DeleteKey(FileExt3);
    end;

    CloseKey;
    Free;
  end;

  SystemParametersInfo(SPI_SETICONTITLELOGFONT, 0, nil, SPIF_SENDWININICHANGE);
  // SystemParametersInfo(SPI_GETICONTITLELOGFONT, 0, nil, SPIF_SENDWININICHANGE);
end;

function RegisterFileType(Ext1, Ext2, Ext3: Boolean): Boolean;
var
  PrevDefaultVal: string;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;

    if Ext1 then
    begin
      OpenKey(FileExt1, True);
      begin
        PrevDefaultVal := ReadString('');

        WriteString('', FileType1);
        CloseKey;
        CreateKey(FileType1);

        OpenKey(FileType1 + '\DefaultIcon', True);
        WriteString('', Application.ExeName + ',1');
        CloseKey;

        OpenKey(FileType1 + '\shell\open\command', True);
        WriteString('', Application.ExeName + ' "%1"');

      end;
    end;

    if Ext2 then
    begin
      OpenKey(FileExt2, True);
      begin
        PrevDefaultVal := ReadString('');

        WriteString('', FileType2);
        CloseKey;
        CreateKey(FileType2);

        OpenKey(FileType2 + '\DefaultIcon', True);
        WriteString('', Application.ExeName + ',2');
        CloseKey;

        OpenKey(FileType2 + '\shell\open\command', True);
        WriteString('', Application.ExeName + ' "%1"');

      end;
    end;

    if Ext3 then
    begin
      OpenKey(FileExt3, True);
      begin
        PrevDefaultVal := ReadString('');

        WriteString('', FileType3);
        CloseKey;
        CreateKey(FileType3);

        OpenKey(FileType3 + '\DefaultIcon', True);
        WriteString('', Application.ExeName + ',3');
        CloseKey;

        OpenKey(FileType3 + '\shell\open\command', True);
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
