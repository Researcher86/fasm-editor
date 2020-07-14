unit AsmSource;

interface

uses
  SysUtils,
  StrUtils,
  Generics.Collections,
  Utils;

type
  TTokenKind = (
    tkImport, tkInterface, tkMacro, tkStruct, tkStruc, tkProc,
    tkLabel, tkConst, tkVar, tkType, tkUnknown
  );

type
  TAsmBase = class
    FBeginChar: Integer;
    FEndChar: Integer;
    FName: string;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string);
  end;

  TAsmInclude = class(TAsmBase)
  end;

  TAsmIntruction = class(TAsmBase)
    FInclude: TAsmInclude;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string; Include: TAsmInclude); overload;
  end;

  TAsmImport = class(TAsmIntruction)
    FData: string;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude); overload;
  end;

  TAsmInterface = class(TAsmIntruction)
  end;

  TAsmMacro = class(TAsmIntruction)
    FData: string;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude); overload;
  end;

  TAsmStructField = class
    FName: string;
    FType: string;
  public
    constructor Create(Name: string; _Type: string); overload;
  end;

  TAsmStruct = class(TAsmIntruction)
    FType: string;
    FListField: TList<TAsmStructField>;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string; _Type: string; ListField: TList<TAsmStructField>; Include: TAsmInclude); overload;
    function FindFieldByName(const Name: string): TAsmStructField;
  end;

  TAsmStruc = class(TAsmIntruction)
    FData: string;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude); overload;
  end;

  TAsmProcedure = class(TAsmIntruction)
    FData: string;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude); overload;
  end;

  TAsmLabel = class(TAsmIntruction)
  end;

  TAsmConst = class(TAsmIntruction)
    FData: string;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude); overload;
  end;

  TAsmVar = class(TAsmIntruction)
    FTypeLong: string;
    FTypeShort: string;
    FData: string;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string; TypeLong: string; TypeShort: string; Data: string; Include: TAsmInclude); overload;
  end;

  TAsmType = class(TAsmIntruction)
    FTypeName: string;
    FTypeLong: string;
    FTypeShort: string;
  public
    constructor Create(BeginChar: Integer; EndChar: Integer; Name: string; TypeName: string; TypeLong: string; TypeShort: string; Data: string; Include: TAsmInclude); overload;
  end;

type
  TAsmScanner = class
  private
    FInclude: TAsmInclude;
    FListInclude: TList<TAsmInclude>;
    FListImport: TList<TAsmImport>;
    FListInterface: TList<TAsmInterface>;
    FListMacro: TList<TAsmMacro>;
    FListStruct: TList<TAsmStruct>;
    FListStruc: TList<TAsmStruc>;
    FListProcedure: TList<TAsmProcedure>;
    FListLabel: TList<TAsmLabel>;
    FListConst: TList<TAsmConst>;
    FListVar: TList<TAsmVar>;
    FListType: TList<TAsmType>;

    FBeginChar: Integer;
    FEndChar: Integer;
    FNamVarPosition: Integer;
    FTokenId: TTokenKind;
    FPosition: Integer;
    FLength: Integer;
    FName, FTemp {, FInvalidName } : string;
    FSource: string;
    FTextFile: TCustomStringList;
    procedure GetInclude;
    procedure GetImport;
    procedure GetInterfase;
    procedure GetMacro;
    procedure GetStruct;
    procedure GetStruc;
    procedure GetProcedure;
    procedure GetLabel;
    procedure GetConst;
    procedure GetVar;
    procedure GetType;
    procedure Ident;
    function IsIdentChar(): Boolean; inline;
    function IsNumberChar(): Boolean; inline;
    function IsIdentName(var S: string): Boolean; // узкое место
    // function IsInvalidName(var S: string): Boolean; // узкое место
    function DeleteComments(var S: string): string; inline;
    function RemoveTrash(var S: string): string; inline;
    function GetLongNameType(const S: string): string;
    procedure FindInclude(var Source: string);
    procedure Scan(var Source: string; Include: TAsmInclude = nil);
    procedure MovePositionBeforeIdentChar();
  public
    constructor Create;
    destructor Destroy; override;

    procedure Run(ProjectPath: string; Source: string; IncludePath: string);
    function FindInstructionByName(const Name: string): TAsmIntruction;

    function FindVarByName(const Name: string): TAsmVar;
    function FindStructByName(const Name: string): TAsmStruct;
//    function FindStructFieldByName(const Name: string);

    property ListInclude: TList<TAsmInclude> read FListInclude;
    property ListImport: TList<TAsmImport> read FListImport;
    property ListInterface: TList<TAsmInterface> read FListInterface;
    property ListMacro: TList<TAsmMacro> read FListMacro;
    property ListStruct: TList<TAsmStruct> read FListStruct;
    property ListStruc: TList<TAsmStruc> read FListStruc;
    property ListProcedure: TList<TAsmProcedure> read FListProcedure;
    property ListLabel: TList<TAsmLabel> read FListLabel;
    property ListConst: TList<TAsmConst> read FListConst;
    property ListVar: TList<TAsmVar> read FListVar;
    property ListType: TList<TAsmType>read FListType;
  end;

var
  AsmScanner: TAsmScanner;

implementation

var
  SInclude,
  // SImport,                 // Сохронять имена для поиска
  SInterfase,
  // SMacro,
  SStruct, SStruc: { ,
    SProc,
    SLabel,
    SConst,
    SVar: } string;

constructor TAsmBase.Create(BeginChar: Integer; EndChar: Integer; Name: string);
begin
  FBeginChar := BeginChar;
  FEndChar := EndChar;
  FName := Name;
end;

constructor TAsmIntruction.Create(BeginChar: Integer; EndChar: Integer; Name: string; Include: TAsmInclude);
begin
  inherited Create(BeginChar, EndChar, Name);
  FInclude := Include;
end;

constructor TAsmImport.Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude);
begin
   inherited Create(BeginChar, EndChar, Name, Include);
   FData := Data;
end;

constructor TAsmMacro.Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude);
begin
   inherited Create(BeginChar, EndChar, Name, Include);
   FData := Data;
end;

constructor TAsmStructField.Create(Name: string; _Type: string);
begin
  FName := Name;
  FType := _Type;
end;

constructor TAsmStruct.Create(BeginChar: Integer; EndChar: Integer; Name: string; _Type: string; ListField: TList<TAsmStructField>; Include: TAsmInclude);
begin
  inherited Create(BeginChar, EndChar, Name, Include);
   FType := _Type;
   FListField := ListField;
end;

function TAsmStruct.FindFieldByName(const Name: string): TAsmStructField;
var
  Field: TAsmStructField;
begin
  for Field in FListField.ToArray do
    if Field.FName = Name then
    begin
      Result := Field;
      Exit;
    end;
end;

constructor TAsmStruc.Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude);
begin
   inherited Create(BeginChar, EndChar, Name, Include);
   FData := Data;
end;

constructor TAsmProcedure.Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude);
begin
   inherited Create(BeginChar, EndChar, Name, Include);
   FData := Data;
end;

constructor TAsmConst.Create(BeginChar: Integer; EndChar: Integer; Name: string; Data: string; Include: TAsmInclude);
begin
   inherited Create(BeginChar, EndChar, Name, Include);
   FData := Data;
end;

constructor TAsmVar.Create(BeginChar: Integer; EndChar: Integer; Name: string; TypeLong: string; TypeShort: string; Data: string; Include: TAsmInclude);
begin
   inherited Create(BeginChar, EndChar, Name, Include);
   FTypeLong := TypeLong;
   FTypeShort := TypeShort;
   FData := Data;
end;

constructor TAsmType.Create(BeginChar: Integer; EndChar: Integer; Name: string; TypeName: string; TypeLong: string; TypeShort: string; Data: string; Include: TAsmInclude);
begin
   inherited Create(BeginChar, EndChar, Name, Include);
   FTypeName := TypeName;
   FTypeLong := TypeLong;
   FTypeShort := TypeShort;
end;

function TAsmScanner.FindInstructionByName(const Name: string): TAsmIntruction;
var
  AsmImport: TAsmImport;
  AsmInterface: TAsmInterface;
  AsmMacro: TAsmMacro;
  AsmStruct: TAsmStruct;
  AsmStruc: TAsmStruc;
  AsmProcedure: TAsmProcedure;
  AsmLabel: TAsmLabel;
  AsmConst: TAsmConst;
  AsmVar: TAsmVar;
  AsmType: TAsmType;
begin
  Result := nil;

  for AsmImport in FListImport.ToArray do
    if AsmImport.FName = Name then
    begin
      Result := AsmImport;
      Exit;
    end;

  for AsmInterface in FListInterface.ToArray do
    if AsmInterface.FName = Name then
    begin
      Result := AsmInterface;
      Exit;
    end;

  for AsmMacro in FListMacro.ToArray do
    if AsmMacro.FName = Name then
    begin
      Result := AsmMacro;
      Exit;
    end;

  for AsmStruct in FListStruct.ToArray do
    if AsmStruct.FName = Name then
    begin
      Result := AsmStruct;
      Exit;
    end;

  for AsmStruc in FListStruc.ToArray do
    if AsmStruc.FName = Name then
    begin
      Result := AsmStruc;
      Exit;
    end;

  for AsmProcedure in FListProcedure.ToArray do
    if AsmProcedure.FName = Name then
    begin
      Result := AsmProcedure;
      Exit;
    end;

  for AsmLabel in FListLabel.ToArray do
    if AsmLabel.FName = Name then
    begin
      Result := AsmLabel;
      Exit;
    end;

  for AsmConst in FListConst.ToArray do
    if AsmConst.FName = Name then
    begin
      Result := AsmConst;
      Exit;
    end;

  for AsmVar in FListVar.ToArray do
    if AsmVar.FName = Name then
    begin
      Result := AsmVar;
      Exit;
    end;

  for AsmType in FListType.ToArray do
    if AsmType.FName = Name then
    begin
      Result := AsmType;
      Exit;
    end;
end;

procedure TAsmScanner.Run(ProjectPath: string; Source: string; IncludePath: string);
  procedure RecursiveScanInclude(ProjectPath: string; Source: string; IncludePath: string; IncludeIndex: Integer);
  var
    Text: string;
    Include: TAsmInclude;
  begin
    FindInclude(Source);

    if FListInclude.Count = 0 then
    begin
      Exit;
    end;

    Include := FListInclude.Items[IncludeIndex];

    if FileExists(GetFullPath(Include.FName)) then
      FTextFile.LoadFromFile(GetFullPath(Include.FName))
    else if FileExists(ProjectPath + Include.FName) then
      FTextFile.LoadFromFile(ProjectPath + Include.FName)
    else if FileExists(GetFullPath(IncludePath + '\' + Include.FName)) then
      FTextFile.LoadFromFile(GetFullPath(IncludePath + '\' + Include.FName))
    else
      Exit;

    Include.FName := FTextFile.FFile;
    Text := FTextFile.Text;

    if FListInclude.Count = (IncludeIndex + 1) then
    begin
      Scan(Text, Include);
      Exit;
    end;

    RecursiveScanInclude(ProjectPath, Text, IncludePath, IncludeIndex + 1);
    Scan(Text, Include);
  end;
begin
  RecursiveScanInclude(ProjectPath, Source, IncludePath, 0);
  Scan(Source, nil);
end;

function TAsmScanner.GetLongNameType(const S: string): string;
var
  S2: string;
begin
  S2 := LowerCase(S);
  if S2 = 'db' then
    Result := 'BYTE'
  else if S2 = 'dw' then
    Result := 'WORD'
  else if S2 = 'dd' then
    Result := 'DWORD'
  else if S2 = 'dq' then
    Result := 'QWORD'
  else if S2 = 'dt' then
    Result := 'TWORD'
  else if S2 = 'equ' then
    Result := 'EQU'
  else
    Result := S;
end;

procedure TAsmScanner.GetInclude;
var
  S, S2: string;
begin
  S := '';

  while not(FSource[FPosition] in [#34, #39, #10, #13, #$A, #$D]) do
  begin
    Inc(FPosition);
  end;

  Inc(FPosition);

  while not(FSource[FPosition] in [#34, #39, #10, #13, #$A, #$D]) do
  begin
    S := S + FSource[FPosition];
    Inc(FPosition);
  end;

  FEndChar := FPosition;
  if (S = '') or (Pos(',' + LowerCase(S) + ',', LowerCase(SInclude)) > 0) then
    Exit;

  SInclude := SInclude + S + ',';

  FListInclude.Add(TAsmInclude.Create(FBeginChar, FEndChar, S))
end;

procedure TAsmScanner.GetImport;
var
  S, S2: string;
  Z: Boolean;
begin
  S := '';
  while FSource[FPosition] in [#1..#32, #$A, #$D] do
  begin
    Inc(FPosition);
  end;

  while IsIdentChar() do
  begin
    S := S + FSource[FPosition];
    Inc(FPosition);
  end;

  if (S = '') { or (IsInvalidName(S)) } then
    Exit;

  repeat
    S := '';
    S2 := '';
    Z := False;

    while (not IsIdentChar()) and (not(FSource[FPosition] in [#10, #13, #$A, #$D])) do
    begin
      if FSource[FPosition] = ',' then
        Z := True;

      if FSource[FPosition] = '\' then
        while (not(IsIdentChar())) and (not(FSource[FPosition] in [#34, #39])) do
          Inc(FPosition)
      else
        Inc(FPosition);
    end;

    if not Z then
      Break;

    FBeginChar := FPosition - 1;

    while IsIdentChar() do
    begin
      S := S + FSource[FPosition];
      Inc(FPosition);
    end;

    // if IsInvalidName(S) then Break;

    Z := False;
    while (not IsIdentChar()) and (not(FSource[FPosition] in [#34, #39])) do
    begin
      if FSource[FPosition] = ',' then
        Z := True;
      Inc(FPosition);
    end;

    if not Z then
      Break;

    while (IsIdentChar()) or (FSource[FPosition] in [#34, #39]) do
    begin
      S2 := S2 + FSource[FPosition];
      Inc(FPosition);
    end;

    FEndChar := FPosition - 1;

    if S2 = '' then
      Break;

    // if Pos(',' + S + ',', SImport) <= 0 then
    begin
      // SImport := SImport + S + ',';
      FListImport.Add(TAsmImport.Create(FBeginChar, FEndChar, S, S2, FInclude));
    end;

  until FSource[FPosition] in [#10, #13, #$A, #$D];
end;

procedure TAsmScanner.GetInterfase;
var
  S: string;
  Z, B: Boolean;
begin
  B := True;
  repeat
    S := '';
    Z := False;

    while (not IsIdentChar()) and (not(FSource[FPosition] in [#10, #13, #$A, #$D])) do
    begin
      if not B then
        if FSource[FPosition] = ',' then
          Z := True;

      if Z then
        if FSource[FPosition] = '\' then
          while not IsIdentChar() do
            Inc(FPosition)
        else
          Inc(FPosition)
      else
        Inc(FPosition);
    end;

    if (not B) and (not Z) then
      Break;

    FBeginChar := FPosition - 1;
    while IsIdentChar() do
    begin
      S := S + FSource[FPosition];
      Inc(FPosition);
    end;
    FEndChar := FPosition - 1;

    if (S = '') { or (IsInvalidName(S)) } then
      Break;

    B := False;

    // if Pos(',' + S + ',', SInterfase) <= 0 then
    begin
      SInterfase := SInterfase + S + ',';

      FListInterface.Add(TAsmInterface.Create(FBeginChar, FEndChar, S, FInclude));
    end;

  until FSource[FPosition] in [#10, #13, #$A, #$D];
end;

procedure TAsmScanner.GetMacro;
var
  Name: string;
  I: Integer;
  Ok: Boolean;
begin
  Name := '';
  I := 0;
  Ok := False;

  MovePositionBeforeIdentChar();

  FBeginChar := FPosition - 1;
  while IsIdentChar() do
  begin
    Name := Name + FSource[FPosition];
    Inc(FPosition);
  end;
  FEndChar := FPosition - 1;

  while FPosition <= FLength do
  begin
    if FSource[FPosition] = '{' then
    begin
      Inc(I);
      Ok := True;
    end;

    if FSource[FPosition] = '}' then
      Dec(I);

    if (Ok) and (I = 0) then
      Break;

    Inc(FPosition);
  end;

  if (Name = '') { or (IsInvalidName(S)) } then
    Exit;
  // if Pos(',' + S + ',', SMacro) > 0 then Exit;

  // SMacro := SMacro + S + ',';

  FListMacro.Add(TAsmMacro.Create(FBeginChar, FEndChar, Name, '', FInclude))
end;

procedure TAsmScanner.GetStruct;
  function TypeName(const S: string): Boolean;
  var
    S2: string;
  begin
    S2 := LowerCase(S);
    if (S2 = 'db') or (S2 = 'dw') or (S2 = 'dd') or (S2 = 'dq') or (S2 = 'dt') or (S2 = 'equ') then
      Result := True
    else
      Result := False;
  end;

  function NameBegin(const S: string): Boolean;
  begin
    if LowerCase(S) = 'struct' then
      Result := True
    else if LowerCase(S) = 'union' then
      Result := True
    else
      Result := False;
  end;

  function NameEnd(const S: string): Boolean;
  begin
    if LowerCase(S) = 'ends' then
      Result := True
    else
      Result := False;
  end;

var
  Next: Integer;
  S, Name, _Type: string;
  Ex, N: Boolean;
  ListField: TList<TAsmStructField>;
begin
  Next := 1;
  Name := '';
  _Type := '';
  Ex := False;
  N := True;
  ListField := TList<TAsmStructField>.Create;

  MovePositionBeforeIdentChar();

  FBeginChar := FPosition - 1;
  while IsIdentChar() do
  begin
    Name := Name + FSource[FPosition];
    Inc(FPosition);
  end;
  FEndChar := FPosition - 1;

  if Name = '' then
    Exit;

  MovePositionBeforeIdentChar();

  while IsIdentChar() do
  begin
    _Type := _Type + FSource[FPosition];
    Inc(FPosition);
  end;

  repeat
    S := '';
    while not IsIdentChar() do
      if FPosition = FLength then
      begin
        Ex := True;
        Break;
      end
      else
        Inc(FPosition);

    while IsIdentChar() do
    begin
      S := S + FSource[FPosition];
      if FPosition = FLength then
      begin
        Ex := True;
        Break;
      end
      else
        Inc(FPosition);
    end;

    if NameBegin(S) then
      Inc(Next);
    if NameEnd(S) then
      Dec(Next);

    if (not NameEnd(S)) and (not NameBegin(S)) then
      if (N) and (not TypeName(S)) then
      begin
        N := False;
        ListField.Add(TAsmStructField.Create(S, ''))
      end
      else
      begin
        N := True;
        ListField.Last;

        if (ListField.Last <> nil) and (ListField.Last.FType = '') then
          ListField.Last.FType := GetLongNameType(S);

        while not(FSource[FPosition] in [#10, #13, #$A, #$D]) do
          Inc(FPosition);
      end;

  until (Next = 0) or Ex;

  // if IsInvalidName(Nam) then Exit;

  // if Pos(',' + Nam + ',', SStruct) <= 0 then
  begin
    SStruct := SStruct + Name + ',';

    FListStruct.Add(TAsmStruct.Create(FBeginChar, FEndChar, Name, _Type, ListField, FInclude));
  end;
  FName := '';
  FTemp := '';
end;

procedure TAsmScanner.GetStruc;
var
  S: string;
begin
  MovePositionBeforeIdentChar();

  FBeginChar := FPosition - 1;
  while IsIdentChar() do
  begin
    S := S + FSource[FPosition];
    Inc(FPosition);
  end;
  FEndChar := FPosition - 1;

  if S = '' then
    Exit;

  // if IsInvalidName(S) then Exit;

  // if Pos(',' + S + ',', SStruc) <= 0 then
  begin
    SStruc := SStruc + S + ',';

    FListStruc.Add(TAsmStruc.Create(FBeginChar, FEndChar, S, '', FInclude));
  end;
  FName := '';
  FTemp := '';
end;

procedure TAsmScanner.GetProcedure;
var
  Name, Data: string;
begin
  Name := '';
  Data := '';

  MovePositionBeforeIdentChar();

  FBeginChar := FPosition - 1;
  while IsIdentChar() do
  begin
    Name := Name + FSource[FPosition];
    Inc(FPosition);
  end;
  FEndChar := FPosition - 1;

  if (Name = '') { or (IsInvalidName(S)) } then
    Exit;

  Inc(FPosition);

  while not(FSource[FPosition] in [#10, #13, #$A, #$D]) do
  begin
    if FSource[FPosition] = '\' then
    begin
      Inc(FPosition);
      while FSource[FPosition] in [#1 .. #32] do
        Inc(FPosition);
    end;

    if IsIdentChar() or (FSource[FPosition] = ',') then
      Data := Data + FSource[FPosition]
    else
      // if IsInvalidName(S) then
      Data := '';

    Inc(FPosition);
  end;

  // if Pos(',' + S + ',', SProc) > 0 then Exit;

  // SProc := SProc + S + ',';

  FListProcedure.Add(TAsmProcedure.Create(FBeginChar, FEndChar, Name, Data, FInclude))
end;

procedure TAsmScanner.GetLabel;
var
  Name: string;
begin
  Name := '';

  if FName = '' then
    Name := FTemp
  else
    Name := FName;

  if (Name = '') {or (IsInvalidName(S)) or (Pos(',' + S + ',', SLabel) > 0) } then
    Exit;

  // SLabel := SLabel + S + ',';

  FListLabel.Add(TAsmLabel.Create(FBeginChar, FEndChar, Name, FInclude));
end;

procedure TAsmScanner.GetConst;
var
  Name, Data: string;
  I: Integer;
begin
  Name := '';
  Data := '';

  if FName = '' then
    Name := FTemp
  else
    Name := FName;

  if (Name = '') {or (IsInvalidName(S)) or (Pos(',' + S + ',', SConst) > 0) } then
    Exit;

  // SConst := SConst + S + ',';

  while not(FSource[FPosition] in [#10, #13, #$A, #$D]) do
  begin
    Data := Data + FSource[FPosition];
    Inc(FPosition);
  end;

  FEndChar := FPosition;

  for I := Length(Data) downto 1 do
    if Data[I] in [#1..#32, #$A, #$D] then
      Dec(FEndChar)
    else
      Break;

  Data := Trim(Data);
  if Data = '' then
    Exit;

  FListConst.Add(TAsmConst.Create(FBeginChar, FEndChar, Name, Data, FInclude));
end;

procedure TAsmScanner.GetVar;
begin
  while not(FSource[FPosition] in [#10, #13, #$A, #$D]) do
  begin
    Inc(FPosition);
  end;

  if (FTemp = '') {or (IsInvalidName(fTemp)) or (Pos(',' + fTemp + ',', SVar) > 0)} then
  begin
    FName := '';
    Exit;
  end;

  // SVar := SVar + fTemp + ',';

  // locals,endl
  FListVar.Add(
    TAsmVar.Create(
      FNamVarPosition,
      FEndChar,
      FTemp,
      GetLongNameType(FName),
      FName,
      '',
      FInclude
    )
  );

  FTemp := '';
  FName := '';
end;

procedure TAsmScanner.GetType;
var
  S: string;
begin
  // name nameType Type         // GLenum	   fix dd
  if FTemp = '' then
  begin
    FName := '';
    Exit;
  end;

  S := '';

  MovePositionBeforeIdentChar();

  while IsIdentChar() do
  begin
    S := S + FSource[FPosition];
    Inc(FPosition);
  end;
  FEndChar := FPosition - 1;

  if S = '' then
  begin
    FName := '';
    Exit;
  end;

  FListType.Add(
    TAsmType.Create(
      FNamVarPosition,
      FEndChar,
      FTemp,
      FName,
      GetLongNameType(S),
      S,
      '',
      FInclude
    )
  );

  FTemp := '';
  FName := '';
end;

procedure TAsmScanner.Ident;
begin
  case FTokenId of
    tkImport:
      GetImport();
    tkInterface:
      GetInterfase();
    tkMacro:
      GetMacro();
    tkStruct:
      GetStruct();
    tkStruc:
      GetStruc();
    tkProc:
      GetProcedure();
    tkVar:
      GetVar();
    tkType:
      GetType();
    tkLabel:
      GetLabel();
    tkConst:
      GetConst();
  end;
end;

function TAsmScanner.IsIdentChar(): Boolean;
begin
  case FSource[FPosition] of
    '_', '0' .. '9', 'A' .. 'Z', 'a' .. 'z':
      Result := True;
  else
    Result := False;
  end;
end;

function TAsmScanner.IsNumberChar: Boolean;
begin
  case FSource[FPosition] of
    '0' .. '9', '.', 'a' .. 'f', 'h', 'A' .. 'F', 'H':
      Result := True;
  else
    Result := False;
  end;
end;

function TAsmScanner.IsIdentName(var S: string): Boolean;
var
  S2: string;
begin
  S2 := LowerCase(S);
  Result := False;

  if S2 = 'import' then
  begin
    FTokenId := tkImport;
    Result := True;
  end
  else if S2 = 'interface' then
  begin
    FTokenId := tkInterface;
    Result := True;
  end
  else if S2 = 'macro' then
  begin
    FTokenId := tkMacro;
    Result := True;
  end
  else if S2 = 'struct' then
  begin
    FTokenId := tkStruct;
    Result := True;
  end
  else if S2 = 'struc' then
  begin
    FTokenId := tkStruc;
    Result := True;
  end
  else if S2 = 'proc' then
  begin
    FTokenId := tkProc;
    Result := True;
  end
  else if (S2 = 'db') or (S2 = 'dw') or // rb и т.д.
    (S2 = 'dd') or (S2 = 'dq') or (S2 = 'dt') or (S2 = 'equ') then
  begin
    FTokenId := tkVar;
    Result := True;
  end
  else if (S2 = 'fix') { or (S2 = 'dw') or
    (S2 = 'dd') or (S2 = 'dq') or
    (S2 = 'dt') or (S2 = 'equ') } then
  begin
    FTokenId := tkType;
    Result := True;
  end
  else if (Pos(',' + S + ',', SStruct) > 0) or (Pos(',' + S + ',', SStruc) > 0)
    or (Pos(',' + S + ',', SInterfase) > 0) then
  begin
    FTokenId := tkVar;
    Result := True;
  end;
end;

// function TScan.IsInvalidName(var S: string): Boolean;
// var
// S2: string;
// begin
// S2 := ',' + LowerCase(S) + ',';
// if Pos(S2, fInvalidName) > 0 then
// Result := True
// else
// if IsIdentName(S) then
// Result := True
// else
// Result := False;
// fTokenID := tkUnknown;
// end;

constructor TAsmScanner.Create;
begin
  inherited Create;

  FListInclude := TList<TAsmInclude>.Create;
  FListImport := TList<TAsmImport>.Create;
  FListInterface := TList<TAsmInterface>.Create;
  FListMacro := TList<TAsmMacro>.Create;
  FListStruct := TList<TAsmStruct>.Create;
  FListStruc := TList<TAsmStruc>.Create;
  FListProcedure := TList<TAsmProcedure>.Create;
  FListLabel := TList<TAsmLabel>.Create;
  FListConst := TList<TAsmConst>.Create;
  FListVar := TList<TAsmVar>.Create;
  FListType := TList<TAsmType>.Create;

  FTextFile := TCustomStringList.Create;
end;

destructor TAsmScanner.Destroy;
begin
  SInclude := '';
  // SImport := '';
  SInterfase := '';
  // SMacro := '';
  SStruct := '';
  SStruc := '';
  // SProc := '';
  // SLabel := '';
  // SConst := '';
  // SVar := '';

  FName := '';
  FTemp := '';
  // fInvalidName := '';
  FSource := '';

  inherited Destroy;
end;

procedure TAsmScanner.FindInclude(var Source: string);
var
  I: Integer;
begin
  FSource := DeleteComments(Source);
  FPosition := 1;
  FName := '';

  FLength := Length(FSource);
  while FPosition <= FLength do
    case FSource[FPosition] of
      'A' .. 'Z', 'a' .. 'z':
        begin
          FName := '';
          FBeginChar := FPosition - 1;

          repeat
            FName := FName + FSource[FPosition];
            Inc(FPosition);
          until not IsIdentChar();

          if LowerCase(FName) = 'include' then
            GetInclude();
        end;
      #1..#32:
        begin
          while FSource[FPosition] in [#1..#32] do
            Inc(FPosition);
        end;
      #34:
        begin
          repeat
            Inc(FPosition);
          until FSource[FPosition] in [#10, #13, #$A, #$D, #34];
          Inc(FPosition);
        end;
      #39:
        begin
          repeat
            Inc(FPosition);
          until FSource[FPosition] in [#10, #13, #$A, #$D, #39];
          Inc(FPosition);
        end;
      '{':
        begin
          I := 0;
          Inc(I);
          Inc(FPosition);

          repeat
            if FSource[FPosition] = '{' then
              Inc(I);
            if FSource[FPosition] = '}' then
              Dec(I);

            Inc(FPosition);
          until (I = 0) or (FPosition >= FLength);

          FName := '';
        end;
    else
      Inc(FPosition);
    end;
end;

function TAsmScanner.FindVarByName(const Name: string): TAsmVar;
var
  AsmVar: TAsmVar;
begin
  Result := nil;

  for AsmVar in FListVar.ToArray do
    if AsmVar.FName = Name then
    begin
      Result := AsmVar;
      Exit;
    end;
end;

function TAsmScanner.FindStructByName(const Name: string): TAsmStruct;
var
  Struct: TAsmStruct;
begin
  Result := nil;

  for Struct in FListStruct.ToArray do
    if Struct.FName = Name then
    begin
      Result := Struct;
      Exit;
    end;
end;

procedure TAsmScanner.Scan(var Source: string; Include: TAsmInclude = nil);
var
  I: Integer;
begin
  FSource := DeleteComments(Source);
  FSource := RemoveTrash(FSource);

  FInclude := Include;
  FPosition := 1;
  FName := '';
  FTemp := '';
  FTokenId := tkUnknown;
  FBeginChar := 0;
  FEndChar := 0;
  FNamVarPosition := 0;

  FLength := Length(FSource);
  repeat
    case FSource[FPosition] of
      'A' .. 'Z', 'a' .. 'z', '_', '.':
        begin
          FName := '';
          FBeginChar := FPosition - 1;

          repeat
            FName := FName + FSource[FPosition];
            Inc(FPosition);
          until not IsIdentChar();

          FEndChar := FPosition - 1;

          if IsIdentName(FName) then
            Ident();

          FNamVarPosition := FBeginChar;
          FTemp := FName;
        end;
      #1..#32:
        begin
          while FSource[FPosition] in [#1..#32, #$A, #$D] do
            Inc(FPosition);
        end;
      #34:
        begin
          repeat
            Inc(FPosition);
          until FSource[FPosition] in [#10, #13, #$A, #$D, #34];
          Inc(FPosition);
          FName := '';
          FTemp := '';
        end;
      #39:
        begin
          repeat
            Inc(FPosition);
          until FSource[FPosition] in [#10, #13, #$A, #$D, #39];
          Inc(FPosition);
          FName := '';
          FTemp := '';
        end;
      ':':
        begin
          FTokenId := tkLabel;
          FEndChar := FPosition;
          Inc(FPosition);
          Ident();
          FName := '';
          FTemp := '';
        end;
      '=':
        begin
          FTokenId := tkConst;
          Inc(FPosition);
          Ident();
          FName := '';
          FTemp := '';
        end;
      '0' .. '9':
        begin
          repeat
            Inc(FPosition);
          until not IsNumberChar();
          FName := '';
          FTemp := '';
        end;
      // ',':
      // begin
      // Inc(fPos);
      // fName := '';
      // fTemp := '';
      // end;
      '{':
        begin
          I := 0;
          Inc(I);
          Inc(FPosition);

          repeat
            if FSource[FPosition] = '{' then
              Inc(I);
            if FSource[FPosition] = '}' then
              Dec(I);

            Inc(FPosition);
          until (I = 0) or (FPosition >= FLength);

          FName := '';
          FTemp := '';
        end;
    else
      begin
        Inc(FPosition);
        FName := '';
        FTemp := '';
      end;
    end;
  until FPosition >= FLength;
end;

procedure TAsmScanner.MovePositionBeforeIdentChar();
begin
  while (not IsIdentChar()) and (not(FSource[FPosition] in [#10, #13, #$A, #$D])) do
  begin
    Inc(FPosition);
  end;
end;

function TAsmScanner.DeleteComments(var S: string): string;
label
  Next;
var
  I: Integer;
begin
  I := 1;
  Result := TrimRight(S) + #10#13;

Next:
  I := PosEx(';', Result, I);
  if I > 0 then
  begin
    while not(Result[I] in [#10, #13, #$A, #$D]) do
    begin
      Result[I] := #32;
      Inc(I);
    end;
    goto Next;
  end;
end;

function TAsmScanner.RemoveTrash(var S: string): string;
begin
//  Result := StringReplace(S, #$A, #10, [rfReplaceAll]);
//  Result := StringReplace(Result, #$D, #13, [rfReplaceAll]);
  Result := S;
end;

end.
