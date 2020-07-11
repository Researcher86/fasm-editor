unit ScanAsmFile;

interface

uses
  SysUtils, StrUtils, Classes, Constants;

type
  TTokenKind = (tkImport, tkInterface, tkMacro, tkStruct, tkStruc, tkProc,
    tkLabel, tkConst, tkVar, tkType, tkUnknown);

type
  PInclude = ^TInclude;

  TInclude = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fNext: PInclude;
  end;

type
  PImport = ^TImport;

  TImport = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fData: string;
    fInc: PInclude;
    fNext: PImport;
  end;

type
  PInterface = ^TInterface;

  TInterface = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fInc: PInclude;
    fNext: PInterface;
  end;

type
  PMacro = ^TMacro;

  TMacro = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fData: string;
    fInc: PInclude;
    fNext: PMacro;
  end;

type
  PField = ^TField;

  TField = packed record
    fName: string;
    fType: string;
    fNext: PField;
  end;

  PStruct = ^TStruct;

  TStruct = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fType: string;
    fField: PField;
    fInc: PInclude;
    fNext: PStruct;
  end;

type
  PStruc = ^TStruc;

  TStruc = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fData: string;
    fInc: PInclude;
    fNext: PStruc;
  end;

type
  PProc = ^TProc;

  TProc = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fData: string;
    fInc: PInclude;
    fNext: PProc;
  end;

type
  PLabel = ^T_Label;

  T_Label = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fInc: PInclude;
    fNext: PLabel;
  end;

type
  PConst = ^TConst;

  TConst = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fData: string;
    fInc: PInclude;
    fNext: PConst;
  end;

type
  PVar = ^TVar;

  TVar = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fTypeLong: string;
    fTypeShort: string;
    fData: string;
    fInc: PInclude;
    fNext: PVar;
  end;

type
  PType = ^TType;

  TType = packed record
    fBeginChar: Integer;
    fEndChar: Integer;
    fName: string;
    fTypeName: string;
    fTypeLong: string;
    fTypeShort: string;
    fInc: PInclude;
    fNext: PType;
  end;

type
  TScan = class
  private
    fInc: PInclude;
    fBeginChar: Integer;
    fEndChar: Integer;
    fNamVarPos: Integer;
    fTokenID: TTokenKind;
    fPos: Integer;
    fLen: Integer;
    fName, fTemp { ,
      fInvalidName } : string;
    fString: string;
    procedure GetInclude;
    procedure GetImport;
    procedure GetInterfase;
    procedure GetMacro;
    procedure GetStruct;
    procedure GetStruc;
    procedure GetProc;
    procedure GetLabel;
    procedure GetConst;
    procedure GetVar;
    procedure GetType;
    procedure Ident;
    function IsIdentChar: Boolean; inline;
    function IsNumberChar: Boolean; inline;
    function IsIdentName(var S: string): Boolean; // уское место
    // function IsInvalidName(var S: string): Boolean; // уское место
    procedure DelComent(var S: string); inline;
  public
    constructor Create;
    destructor Destroy; override;
    function GetLongNameType(const S: string): string;
    procedure BeginScan(var S: string; Include: PInclude = nil);
    procedure FindVar(ProjectPath: string; IncPath: string);
    function FindVarNameAndPath(const VarName: string): TTokenKind;
    procedure FindInclude(var S: string);
    procedure ClearList;
  end;

type
  TMyStringList = class(TStringList)
  public
    fFile: string;
    procedure LoadFromFile(const FileName: string);
  end;

var
  Scan: TScan;
  ListInclude, ptrInclude, KInc: PInclude;
  ListImport, ptrImport, KImp: PImport;
  ListInterface, ptrInterface, KInt: PInterface;
  ListMacro, ptrMacro, KMac: PMacro;
  ListStruct, ptrStruct, KStr: PStruct;
  ListStruc, ptrStruc, KStr2: PStruc;
  ListProc, ptrProc, KProc: PProc;
  ListLabel, ptrLabel, KLab: PLabel;
  ListConst, ptrConst, KCon: PConst;
  ListVar, ptrVar, KVar: PVar;
  ListType, ptrType, KType: PType;

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

function TScan.FindVarNameAndPath(const VarName: string): TTokenKind;
begin
  ptrImport := ListImport;
  while ptrImport <> nil do
  begin

    if ptrImport^.fName = VarName then
    begin
      Result := tkImport;
      Exit;
    end;

    ptrImport := ptrImport^.fNext;
  end;

  ptrInterface := ListInterface;
  while ptrInterface <> nil do
  begin

    if ptrInterface^.fName = VarName then
    begin
      Result := tkInterface;
      Exit;
    end;

    ptrInterface := ptrInterface^.fNext;
  end;

  ptrMacro := ListMacro;
  while ptrMacro <> nil do
  begin

    if ptrMacro^.fName = VarName then
    begin
      Result := tkMacro;
      Exit;
    end;

    ptrMacro := ptrMacro^.fNext;
  end;

  ptrStruct := ListStruct;
  while ptrStruct <> nil do
  begin

    if ptrStruct^.fName = VarName then
    begin
      Result := tkStruct;
      Exit;
    end;

    ptrStruct := ptrStruct^.fNext;
  end;

  ptrStruc := ListStruc;
  while ptrStruc <> nil do
  begin

    if ptrStruc^.fName = VarName then
    begin
      Result := tkStruc;
      Exit;
    end;

    ptrStruc := ptrStruc^.fNext;
  end;

  ptrProc := ListProc;
  while ptrProc <> nil do
  begin

    if ptrProc^.fName = VarName then
    begin
      Result := tkProc;
      Exit;
    end;

    ptrProc := ptrProc^.fNext;
  end;

  ptrLabel := ListLabel;
  while ptrLabel <> nil do
  begin

    if (ptrLabel^.fName = VarName) or (ptrLabel^.fName = '.' + VarName) then
    begin
      Result := tkLabel;
      Exit;
    end;

    ptrLabel := ptrLabel^.fNext;
  end;

  ptrConst := ListConst;
  while ptrConst <> nil do
  begin

    if ptrConst^.fName = VarName then
    begin
      Result := tkConst;
      Exit;
    end;

    ptrConst := ptrConst^.fNext;
  end;

  ptrVar := ListVar;
  while ptrVar <> nil do
  begin

    if ptrVar^.fName = VarName then
    begin
      Result := tkVar;
      Exit;
    end;

    ptrVar := ptrVar^.fNext;
  end;

  ptrType := ListType;
  while ptrType <> nil do
  begin

    if ptrType^.fName = VarName then
    begin
      Result := tkType;
      Exit;
    end;

    ptrType := ptrType^.fNext;
  end;
end;

procedure TScan.FindVar(ProjectPath: string; IncPath: string);
var
  S: string;
  Src: TMyStringList;
  ptrIncludeTemp: PInclude;
begin
  Src := TMyStringList.Create;

  ptrIncludeTemp := nil;
  ptrIncludeTemp := ListInclude;
  while ptrIncludeTemp <> nil do
  begin
    if FileExists(GetFullPath(ptrIncludeTemp^.fName)) then
      Src.LoadFromFile(GetFullPath(ptrIncludeTemp^.fName))

    else if FileExists(ProjectPath + ptrIncludeTemp^.fName) then
      Src.LoadFromFile(ProjectPath + ptrIncludeTemp^.fName)

    else if FileExists(GetFullPath(IncPath + '\' + ptrIncludeTemp^.fName)) then
      Src.LoadFromFile(GetFullPath(IncPath + '\' + ptrIncludeTemp^.fName));

    S := Src.Text;
    Scan.FindInclude(S);
    ptrIncludeTemp := ptrIncludeTemp^.fNext;
  end;

  ptrInclude := ListInclude;
  while ptrInclude <> nil do
  begin
    if FileExists(GetFullPath(ptrInclude^.fName)) then
      Src.LoadFromFile(GetFullPath(ptrInclude^.fName))
    else if FileExists(ProjectPath + ptrInclude^.fName) then
      Src.LoadFromFile(ProjectPath + ptrInclude^.fName)
    else if FileExists(GetFullPath(IncPath + '\' + ptrInclude^.fName)) then
      Src.LoadFromFile(GetFullPath(IncPath + '\' + ptrInclude^.fName))

    else
    begin
      ptrIncludeTemp := ListInclude;
      while ptrIncludeTemp <> nil do
      begin
        S := GetFullPath(ExtractFilePath(ptrIncludeTemp^.fName) + ptrInclude^.fName);
        if FileExists(S) then
        begin
          Src.LoadFromFile(S);
          Break;
        end;
        ptrIncludeTemp := ptrIncludeTemp^.fNext;
      end;
    end;

    ptrInclude^.fName := Src.fFile;
    S := Src.Text;
    Scan.BeginScan(S, ptrInclude);
    ptrInclude := ptrInclude^.fNext;
  end;
  Src.Free;
end;

function TScan.GetLongNameType(const S: string): string;
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

// *****************************************************************************

procedure TScan.GetInclude;
var
  S, S2: string;
begin
  S := '';

  while not(fString[fPos] in [#34, #39, #10, #13]) do
  begin
    Inc(fPos);
  end;

  Inc(fPos);

  while not(fString[fPos] in [#34, #39, #10, #13]) do
  begin
    S := S + fString[fPos];
    Inc(fPos);
  end;

  fEndChar := fPos;
  if (S = '') or (Pos(',' + LowerCase(S) + ',', LowerCase(SInclude)) > 0) then
    Exit;

  SInclude := SInclude + S + ',';

  New(ptrInclude);
  ptrInclude^.fBeginChar := fBeginChar;
  ptrInclude^.fEndChar := fEndChar;
  ptrInclude^.fName := S;
  ptrInclude^.fNext := nil;

  if KInc = nil then
  begin
    KInc := ptrInclude;
    ListInclude := ptrInclude;
  end
  else
  begin
    KInc^.fNext := ptrInclude;
    KInc := KInc^.fNext;
  end;
end;

// *****************************************************************************

procedure TScan.GetImport;
var
  S, S2: string;
  Z: Boolean;
begin
  S := '';
  while fString[fPos] in [#1 .. #32] do
  begin
    Inc(fPos);
  end;

  while IsIdentChar do
  begin
    S := S + fString[fPos];
    Inc(fPos);
  end;

  if (S = '') { or (IsInvalidName(S)) } then
    Exit;

  repeat
    S := '';
    S2 := '';
    Z := False;

    while (not IsIdentChar) and (not(fString[fPos] in [#10, #13])) do
    begin
      if fString[fPos] = ',' then
        Z := True;

      if fString[fPos] = '\' then
        while (not(IsIdentChar)) and (not(fString[fPos] in [#34, #39])) do
          Inc(fPos)
      else
        Inc(fPos);
    end;

    if not Z then
      Break;

    fBeginChar := fPos - 1;

    while IsIdentChar do
    begin
      S := S + fString[fPos];
      Inc(fPos);
    end;

    // if IsInvalidName(S) then Break;

    Z := False;
    while (not IsIdentChar) and (not(fString[fPos] in [#34, #39])) do
    begin
      if fString[fPos] = ',' then
        Z := True;
      Inc(fPos);
    end;

    if not Z then
      Break;

    while (IsIdentChar) or (fString[fPos] in [#34, #39]) do
    begin
      S2 := S2 + fString[fPos];
      Inc(fPos);
    end;

    fEndChar := fPos - 1;

    if S2 = '' then
      Break;

    // if Pos(',' + S + ',', SImport) <= 0 then
    begin
      // SImport := SImport + S + ',';
      New(ptrImport);
      ptrImport^.fBeginChar := fBeginChar;
      ptrImport^.fEndChar := fEndChar;
      ptrImport^.fName := S;
      ptrImport^.fData := S2;
      ptrImport^.fInc := fInc;
      ptrImport^.fNext := nil;

      if KImp = nil then
      begin
        KImp := ptrImport;
        ListImport := ptrImport;
      end
      else
      begin
        KImp^.fNext := ptrImport;
        KImp := KImp^.fNext;
      end;
    end;

  until fString[fPos] in [#10, #13];
end;

// *****************************************************************************

procedure TScan.GetInterfase;
var
  S: string;
  Z, B: Boolean;
begin
  B := True;
  repeat
    S := '';
    Z := False;

    while (not IsIdentChar) and (not(fString[fPos] in [#10, #13])) do
    begin
      if not B then
        if fString[fPos] = ',' then
          Z := True;

      if Z then
        if fString[fPos] = '\' then
          while not IsIdentChar do
            Inc(fPos)
        else
          Inc(fPos)
      else
        Inc(fPos);
    end;

    if (not B) and (not Z) then
      Break;

    fBeginChar := fPos - 1;
    while IsIdentChar do
    begin
      S := S + fString[fPos];
      Inc(fPos);
    end;
    fEndChar := fPos - 1;

    if (S = '') { or (IsInvalidName(S)) } then
      Break;

    B := False;

    // if Pos(',' + S + ',', SInterfase) <= 0 then
    begin
      SInterfase := SInterfase + S + ',';

      New(ptrInterface);
      ptrInterface^.fBeginChar := fBeginChar;
      ptrInterface^.fEndChar := fEndChar;
      ptrInterface^.fName := S;
      ptrInterface^.fInc := fInc;
      ptrInterface^.fNext := nil;

      if KInt = nil then
      begin
        KInt := ptrInterface;
        ListInterface := ptrInterface;
      end
      else
      begin
        KInt^.fNext := ptrInterface;
        KInt := KInt^.fNext;
      end;
    end;

  until fString[fPos] in [#10, #13];
end;

// *****************************************************************************

procedure TScan.GetMacro;
var
  S: string;
  I: Integer;
  Ok: Boolean;
begin
  S := '';
  I := 0;
  Ok := False;

  while (not IsIdentChar) and (not(fString[fPos] in [#10, #13])) do
  begin
    Inc(fPos);
  end;

  fBeginChar := fPos - 1;
  while IsIdentChar do
  begin
    S := S + fString[fPos];
    Inc(fPos);
  end;
  fEndChar := fPos - 1;

  while fPos <= fLen do
  begin
    if fString[fPos] = '{' then
    begin
      Inc(I);
      Ok := True;
    end;

    if fString[fPos] = '}' then
      Dec(I);

    if (Ok) and (I = 0) then
      Break;

    Inc(fPos);
  end;

  if (S = '') { or (IsInvalidName(S)) } then
    Exit;
  // if Pos(',' + S + ',', SMacro) > 0 then Exit;

  // SMacro := SMacro + S + ',';

  New(ptrMacro);
  ptrMacro^.fBeginChar := fBeginChar;
  ptrMacro^.fEndChar := fEndChar;
  ptrMacro^.fName := S;
  ptrMacro^.fInc := fInc;
  ptrMacro^.fNext := nil;

  if KMac = nil then
  begin
    KMac := ptrMacro;
    ListMacro := ptrMacro;
  end
  else
  begin
    KMac^.fNext := ptrMacro;
    KMac := KMac^.fNext;
  end;
end;

// *****************************************************************************

procedure TScan.GetStruct;
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
  S, Nam, T: string;
  Ex, N: Boolean;
  ptrP, ptrW, K: PField;
begin
  Next := 1;
  Nam := '';
  T := '';
  Ex := False;
  N := True;
  ptrP := nil;
  ptrW := nil;
  K := nil;

  while (not IsIdentChar) and (not(fString[fPos] in [#10, #13])) do
  begin
    Inc(fPos);
  end;

  fBeginChar := fPos - 1;
  while IsIdentChar do
  begin
    Nam := Nam + fString[fPos];
    Inc(fPos);
  end;
  fEndChar := fPos - 1;

  if Nam = '' then
    Exit;

  while (not IsIdentChar) and (not(fString[fPos] in [#10, #13])) do
  begin
    Inc(fPos);
  end;

  while IsIdentChar do
  begin
    T := T + fString[fPos];
    Inc(fPos);
  end;

  repeat
    S := '';
    while not IsIdentChar do
      if fPos = fLen then
      begin
        Ex := True;
        Break;
      end
      else
        Inc(fPos);

    while IsIdentChar do
    begin
      S := S + fString[fPos];
      if fPos = fLen then
      begin
        Ex := True;
        Break;
      end
      else
        Inc(fPos);
    end;

    if NameBegin(S) then
      Inc(Next);
    if NameEnd(S) then
      Dec(Next);

    if (not NameEnd(S)) and (not NameBegin(S)) then
      if (N) and (not TypeName(S)) then
      begin
        N := False;
        New(ptrW);
        ptrW^.fName := S;
        ptrW^.fType := '';
        ptrW^.fNext := nil;

        if K = nil then
        begin
          K := ptrW;
          ptrP := ptrW;
        end
        else
        begin
          K^.fNext := ptrW;
          K := K^.fNext;
        end;
      end
      else
      begin
        N := True;

        if (ptrW <> nil) and (ptrW^.fType = '') then
          ptrW^.fType := GetLongNameType(S);

        while not(fString[fPos] in [#10, #13]) do
          Inc(fPos);
      end;

  until (Next = 0) or Ex;

  // if IsInvalidName(Nam) then Exit;

  // if Pos(',' + Nam + ',', SStruct) <= 0 then
  begin
    SStruct := SStruct + Nam + ',';

    New(ptrStruct);
    ptrStruct^.fBeginChar := fBeginChar;
    ptrStruct^.fEndChar := fEndChar;
    ptrStruct^.fName := Nam;
    ptrStruct^.fType := T;
    ptrStruct^.fField := ptrP;
    ptrStruct^.fInc := fInc;
    ptrStruct^.fNext := nil;

    if KStr = nil then
    begin
      KStr := ptrStruct;
      ListStruct := ptrStruct;
    end
    else
    begin
      KStr^.fNext := ptrStruct;
      KStr := KStr^.fNext;
    end;
  end;
  fName := '';
  fTemp := '';
end;

// *****************************************************************************

procedure TScan.GetStruc;
var
  S: string;
begin
  while (not IsIdentChar) and (not(fString[fPos] in [#10, #13])) do
  begin
    Inc(fPos);
  end;

  fBeginChar := fPos - 1;
  while IsIdentChar do
  begin
    S := S + fString[fPos];
    Inc(fPos);
  end;
  fEndChar := fPos - 1;

  if S = '' then
    Exit;

  // if IsInvalidName(S) then Exit;

  // if Pos(',' + S + ',', SStruc) <= 0 then
  begin
    SStruc := SStruc + S + ',';

    New(ptrStruc);
    ptrStruc^.fBeginChar := fBeginChar;
    ptrStruc^.fEndChar := fEndChar;
    ptrStruc^.fName := S;
    ptrStruc^.fData := '';
    ptrStruc^.fInc := fInc;
    ptrStruc^.fNext := nil;

    if KStr2 = nil then
    begin
      KStr2 := ptrStruc;
      ListStruc := ptrStruc;
    end
    else
    begin
      KStr2^.fNext := ptrStruc;
      KStr2 := KStr2^.fNext;
    end;
  end;
  fName := '';
  fTemp := '';
end;

// *****************************************************************************

procedure TScan.GetProc;
var
  S, S2: string;
begin
  S := '';
  S2 := '';

  while (not IsIdentChar) and (not(fString[fPos] in [#10, #13])) do
  begin
    Inc(fPos);
  end;

  fBeginChar := fPos - 1;
  while IsIdentChar do
  begin
    S := S + fString[fPos];
    Inc(fPos);
  end;
  fEndChar := fPos - 1;

  if (S = '') { or (IsInvalidName(S)) } then
    Exit;

  Inc(fPos);

  while not(fString[fPos] in [#10, #13]) do
  begin
    if fString[fPos] = '\' then
    begin
      Inc(fPos);
      while fString[fPos] in [#1 .. #32] do
        Inc(fPos);
    end;

    if IsIdentChar or (fString[fPos] = ',') then
      S2 := S2 + fString[fPos]
    else
      // if IsInvalidName(S) then
      S2 := '';

    Inc(fPos);
  end;

  // if Pos(',' + S + ',', SProc) > 0 then Exit;

  // SProc := SProc + S + ',';

  New(ptrProc);
  ptrProc^.fBeginChar := fBeginChar;
  ptrProc^.fEndChar := fEndChar;
  ptrProc^.fName := S;
  ptrProc^.fData := S2;
  ptrProc^.fInc := fInc;
  ptrProc^.fNext := nil;

  if KProc = nil then
  begin
    KProc := ptrProc;
    ListProc := ptrProc;
  end
  else
  begin
    KProc^.fNext := ptrProc;
    KProc := KProc^.fNext;
  end;
end;

// *****************************************************************************

procedure TScan.GetLabel;
var
  S: string;
begin
  S := '';

  if fName = '' then
    S := fTemp
  else
    S := fName;

  if (S = '') { or (IsInvalidName(S)) {or
    (Pos(',' + S + ',', SLabel) > 0) } then
    Exit;

  // SLabel := SLabel + S + ',';

  New(ptrLabel);
  ptrLabel^.fBeginChar := fBeginChar;
  ptrLabel^.fEndChar := fEndChar;
  ptrLabel^.fName := S;
  ptrLabel^.fInc := fInc;
  ptrLabel^.fNext := nil;

  if KLab = nil then
  begin
    KLab := ptrLabel;
    ListLabel := ptrLabel;
  end
  else
  begin
    KLab^.fNext := ptrLabel;
    KLab := KLab^.fNext;
  end;
end;

// *****************************************************************************

procedure TScan.GetConst;
var
  S, S2: string;
  I: Integer;
begin
  S := '';
  S2 := '';

  if fName = '' then
    S := fTemp
  else
    S := fName;

  if (S = '') { or (IsInvalidName(S)) {or
    (Pos(',' + S + ',', SConst) > 0) } then
    Exit;

  // SConst := SConst + S + ',';

  while not(fString[fPos] in [#10, #13]) do
  begin
    S2 := S2 + fString[fPos];
    Inc(fPos);
  end;

  fEndChar := fPos;

  for I := Length(S2) downto 1 do
    if S2[I] in [#1 .. #32] then
      // ==============================================
      Dec(fEndChar)
    else
      Break;

  S2 := Trim(S2);
  if S2 = '' then
    Exit;

  New(ptrConst);
  ptrConst^.fBeginChar := fBeginChar;
  ptrConst^.fEndChar := fEndChar;
  ptrConst^.fName := S;
  ptrConst^.fData := S2;
  ptrConst^.fInc := fInc;
  ptrConst^.fNext := nil;

  if KCon = nil then
  begin
    KCon := ptrConst;
    ListConst := ptrConst;
  end
  else
  begin
    KCon^.fNext := ptrConst;
    KCon := KCon^.fNext;
  end;
end;

// *****************************************************************************

procedure TScan.GetVar;
begin
  while not(fString[fPos] in [#10, #13]) do
  begin
    Inc(fPos);
  end;

  if (fTemp = '') { or (IsInvalidName(fTemp)) //or
    {(Pos(',' + fTemp + ',', SVar) > 0) } then
  begin
    fName := '';
    Exit;
  end;

  // SVar := SVar + fTemp + ',';

  // locals,endl
  New(ptrVar);
  ptrVar^.fBeginChar := fNamVarPos;
  ptrVar^.fEndChar := fEndChar;
  ptrVar^.fName := fTemp;
  ptrVar^.fTypeLong := GetLongNameType(fName);
  ptrVar^.fTypeShort := fName;
  ptrVar^.fInc := fInc;
  ptrVar^.fNext := nil;

  if KVar = nil then
  begin
    KVar := ptrVar;
    ListVar := ptrVar;
  end
  else
  begin
    KVar^.fNext := ptrVar;
    KVar := KVar^.fNext;
  end;

  fTemp := '';
  fName := '';
end;

// *****************************************************************************

procedure TScan.GetType;
var
  S: string;
begin
  // name nameType Type         // GLenum	   fix dd
  if fTemp = '' then
  begin
    fName := '';
    Exit;
  end;

  S := '';

  while (not IsIdentChar) and (not(fString[fPos] in [#10, #13])) do
  begin
    Inc(fPos);
  end;

  while IsIdentChar do
  begin
    S := S + fString[fPos];
    Inc(fPos);
  end;
  fEndChar := fPos - 1;

  if S = '' then
  begin
    fName := '';
    Exit;
  end;

  New(ptrType);
  ptrType^.fBeginChar := fNamVarPos;
  ptrType^.fEndChar := fEndChar;
  ptrType^.fName := fTemp;
  ptrType^.fTypeName := fName;

  ptrType^.fTypeLong := GetLongNameType(S);
  ptrType^.fTypeShort := S;
  ptrType^.fInc := fInc;
  ptrType^.fNext := nil;

  if KType = nil then
  begin
    KType := ptrType;
    ListType := ptrType;
  end
  else
  begin
    KType^.fNext := ptrType;
    KType := KType^.fNext;
  end;

  fTemp := '';
  fName := '';
end;

// *****************************************************************************

procedure TScan.Ident;
begin
  case fTokenID of
    tkImport:
      GetImport;
    tkInterface:
      GetInterfase;
    tkMacro:
      GetMacro;
    tkStruct:
      GetStruct;
    tkStruc:
      GetStruc;
    tkProc:
      GetProc;
    tkVar:
      GetVar;
    tkType:
      GetType;
    tkLabel:
      GetLabel;
    tkConst:
      GetConst;
  end;
end;

// *****************************************************************************

function TScan.IsIdentChar: Boolean;
begin
  case fString[fPos] of
    '_', '0' .. '9', 'A' .. 'Z', 'a' .. 'z':
      Result := True;
  else
    Result := False;
  end;
end;

// *****************************************************************************

function TScan.IsNumberChar: Boolean;
begin
  case fString[fPos] of
    '0' .. '9', '.', 'a' .. 'f', 'h', 'A' .. 'F', 'H':
      Result := True;
  else
    Result := False;
  end;
end;

// *****************************************************************************

function TScan.IsIdentName(var S: string): Boolean;
var
  S2: string;
begin
  S2 := LowerCase(S);
  Result := False;

  if S2 = 'import' then
  begin
    fTokenID := tkImport;
    Result := True;
  end
  else if S2 = 'interface' then
  begin
    fTokenID := tkInterface;
    Result := True;
  end
  else if S2 = 'macro' then
  begin
    fTokenID := tkMacro;
    Result := True;
  end
  else if S2 = 'struct' then
  begin
    fTokenID := tkStruct;
    Result := True;
  end
  else if S2 = 'struc' then
  begin
    fTokenID := tkStruc;
    Result := True;
  end
  else if S2 = 'proc' then
  begin
    fTokenID := tkProc;
    Result := True;
  end
  else if (S2 = 'db') or (S2 = 'dw') or // rb и т.д.
    (S2 = 'dd') or (S2 = 'dq') or (S2 = 'dt') or (S2 = 'equ') then
  begin
    fTokenID := tkVar;
    Result := True;
  end
  else if (S2 = 'fix') { or (S2 = 'dw') or
    (S2 = 'dd') or (S2 = 'dq') or
    (S2 = 'dt') or (S2 = 'equ') } then
  begin
    fTokenID := tkType;
    Result := True;
  end
  else if (Pos(',' + S + ',', SStruct) > 0) or (Pos(',' + S + ',', SStruc) > 0)
    or (Pos(',' + S + ',', SInterfase) > 0) then
  begin
    fTokenID := tkVar;
    Result := True;
  end;
end;

// *****************************************************************************

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

// *****************************************************************************

constructor TScan.Create;
begin
  inherited Create;

  ListInclude := nil;
  ListImport := nil;
  ListInterface := nil;
  ListMacro := nil;
  ListStruct := nil;
  ListStruc := nil;
  ListProc := nil;
  ListLabel := nil;
  ListConst := nil;
  ListVar := nil;
  ListType := nil;

  ptrInclude := nil;
  ptrImport := nil;
  ptrInterface := nil;
  ptrMacro := nil;
  ptrStruct := nil;
  ptrStruc := nil;
  ptrProc := nil;
  ptrLabel := nil;
  ptrConst := nil;
  ptrVar := nil;
  ptrType := nil;

  KInc := nil;
  KImp := nil;
  KInt := nil;
  KMac := nil;
  KStr := nil;
  KStr2 := nil;
  KProc := nil;
  KLab := nil;
  KCon := nil;
  KVar := nil;
  KType := nil;

  fInc := nil;

  SInclude := ',';
  // SImport := ',';
  SInterfase := ',';
  // SMacro := ',';
  SStruct := ',';
  SStruc := ',';
  // SProc := ',';
  // SLabel := ',';
  // SConst := ',';
  // SVar := ',';

  // fInvalidName := ',' + Mnemonics + ',' + MnemonicsDir + ',' + MnemonicsRegist + ',';
end;

// *****************************************************************************

destructor TScan.Destroy;
begin
  ClearList;

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

  fName := '';
  fTemp := '';
  // fInvalidName := '';
  fString := '';

  inherited Destroy;
end;

// *****************************************************************************

procedure TScan.ClearList;
var
  ptrP, ptrW: PField;
begin
  while ListInclude <> nil do
  begin
    ptrInclude := ListInclude;
    ListInclude := ListInclude^.fNext;
    Dispose(ptrInclude);
  end;

  while ListImport <> nil do
  begin
    ptrImport := ListImport;
    ListImport := ListImport^.fNext;
    Dispose(ptrImport);
  end;

  while ListInterface <> nil do
  begin
    ptrInterface := ListInterface;
    ListInterface := ListInterface^.fNext;
    Dispose(ptrInterface);
  end;

  while ListMacro <> nil do
  begin
    ptrMacro := ListMacro;
    ListMacro := ListMacro^.fNext;
    Dispose(ptrMacro);
  end;

  while ListStruct <> nil do
  begin
    ptrStruct := ListStruct;

    ptrP := ptrStruct^.fField;
    while ptrP <> nil do
    begin
      ptrW := ptrP;
      ptrP := ptrP^.fNext;
      Dispose(ptrW);
    end;

    ListStruct := ListStruct^.fNext;
    Dispose(ptrStruct);
  end;

  while ListStruc <> nil do
  begin
    ptrStruc := ListStruc;
    ListStruc := ListStruc^.fNext;
    Dispose(ptrStruc);
  end;

  while ListProc <> nil do
  begin
    ptrProc := ListProc;
    ListProc := ListProc^.fNext;
    Dispose(ptrProc);
  end;

  while ListLabel <> nil do
  begin
    ptrLabel := ListLabel;
    ListLabel := ListLabel^.fNext;
    Dispose(ptrLabel);
  end;

  while ListConst <> nil do
  begin
    ptrConst := ListConst;
    ListConst := ListConst^.fNext;
    Dispose(ptrConst);
  end;

  while ListVar <> nil do
  begin
    ptrVar := ListVar;
    ListVar := ListVar^.fNext;
    Dispose(ptrVar);
  end;

  while ListType <> nil do
  begin
    ptrType := ListType;
    ListType := ListType^.fNext;
    Dispose(ptrType);
  end;
end;

// *****************************************************************************

procedure TScan.FindInclude(var S: string);
var
  I: Integer;
begin
  DelComent(S);
  fPos := 1;
  fName := '';

  fLen := Length(fString);
  while fPos <= fLen do
    case fString[fPos] of
      'A' .. 'Z', 'a' .. 'z':
        begin
          fName := '';
          fBeginChar := fPos - 1;

          repeat
            fName := fName + fString[fPos];
            Inc(fPos);
          until not IsIdentChar;

          if LowerCase(fName) = 'include' then
            GetInclude;
        end;
      #1 .. #32:
        begin
          while fString[fPos] in [#1 .. #32] do
            Inc(fPos);
        end;
      #34:
        begin
          repeat
            Inc(fPos);
          until fString[fPos] in [#10, #13, #34];
          Inc(fPos);
        end;
      #39:
        begin
          repeat
            Inc(fPos);
          until fString[fPos] in [#10, #13, #39];
          Inc(fPos);
        end;
      '{':
        begin
          I := 0;
          Inc(I);
          Inc(fPos);

          repeat
            if fString[fPos] = '{' then
              Inc(I);
            if fString[fPos] = '}' then
              Dec(I);

            Inc(fPos);
          until (I = 0) or (fPos >= fLen);

          fName := '';
        end;
    else
      Inc(fPos);
    end;
end;

// *****************************************************************************

procedure TScan.BeginScan(var S: string; Include: PInclude = nil);
var
  I: Integer;
begin
  DelComent(S);
  fInc := Include;
  fPos := 1;
  fName := '';
  fTemp := '';
  fTokenID := tkUnknown;
  fBeginChar := 0;
  fEndChar := 0;
  fNamVarPos := 0;

  fLen := Length(fString);
  repeat
    case fString[fPos] of
      'A' .. 'Z', 'a' .. 'z', '_', '.':
        begin
          fName := '';
          fBeginChar := fPos - 1;

          repeat
            fName := fName + fString[fPos];
            Inc(fPos);
          until not IsIdentChar;

          fEndChar := fPos - 1;

          if IsIdentName(fName) then
            Ident;

          fNamVarPos := fBeginChar;
          fTemp := fName;
        end;
      #1 .. #32:
        begin
          while fString[fPos] in [#1 .. #32] do
            Inc(fPos);
        end;
      #34:
        begin
          repeat
            Inc(fPos);
          until fString[fPos] in [#10, #13, #34];
          Inc(fPos);
          fName := '';
          fTemp := '';
        end;
      #39:
        begin
          repeat
            Inc(fPos);
          until fString[fPos] in [#10, #13, #39];
          Inc(fPos);
          fName := '';
          fTemp := '';
        end;
      ':':
        begin
          fTokenID := tkLabel;
          fEndChar := fPos;
          Inc(fPos);
          Ident;
          fName := '';
          fTemp := '';
        end;
      '=':
        begin
          fTokenID := tkConst;
          Inc(fPos);
          Ident;
          fName := '';
          fTemp := '';
        end;
      '0' .. '9':
        begin
          repeat
            Inc(fPos);
          until not IsNumberChar;
          fName := '';
          fTemp := '';
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
          Inc(fPos);

          repeat
            if fString[fPos] = '{' then
              Inc(I);
            if fString[fPos] = '}' then
              Dec(I);

            Inc(fPos);
          until (I = 0) or (fPos >= fLen);

          fName := '';
          fTemp := '';
        end;
    else
      begin
        Inc(fPos);
        fName := '';
        fTemp := '';
      end;
    end;
  until fPos >= fLen;
end;

// *****************************************************************************

procedure TScan.DelComent(var S: string);
label
  Next;
var
  I: Integer;
begin
  I := 1;
  fString := TrimRight(S) + #10#13;

Next:
  I := PosEx(';', fString, I);
  if I > 0 then
  begin
    while not(fString[I] in [#10, #13]) do
    begin
      fString[I] := #32;
      Inc(I);
    end;
    goto Next;
  end;
end;

// *****************************************************************************
{ TMyStringList }

procedure TMyStringList.LoadFromFile(const FileName: string);
begin
  fFile := FileName;
  inherited LoadFromFile(FileName);
end;

end.
