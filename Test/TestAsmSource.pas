unit TestAsmSource;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, Utils, Generics.Collections, SysUtils, AsmSource, StrUtils;

type
  // Test methods for class TAsmBase

  TestTAsmBase = class(TTestCase)
  strict private
    FAsmBase: TAsmBase;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmInclude

  TestTAsmInclude = class(TTestCase)
  strict private
    FAsmInclude: TAsmInclude;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmIntruction

  TestTAsmIntruction = class(TTestCase)
  strict private
    FAsmIntruction: TAsmIntruction;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmImport

  TestTAsmImport = class(TTestCase)
  strict private
    FAsmImport: TAsmImport;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmInterface

  TestTAsmInterface = class(TTestCase)
  strict private
    FAsmInterface: TAsmInterface;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmMacro

  TestTAsmMacro = class(TTestCase)
  strict private
    FAsmMacro: TAsmMacro;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmStructField

  TestTAsmStructField = class(TTestCase)
  strict private
    FAsmStructField: TAsmStructField;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmStruct

  TestTAsmStruct = class(TTestCase)
  strict private
    FAsmStruct: TAsmStruct;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFindFieldByName;
  end;
  // Test methods for class TAsmStruc

  TestTAsmStruc = class(TTestCase)
  strict private
    FAsmStruc: TAsmStruc;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmProcedure

  TestTAsmProcedure = class(TTestCase)
  strict private
    FAsmProcedure: TAsmProcedure;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmLabel

  TestTAsmLabel = class(TTestCase)
  strict private
    FAsmLabel: TAsmLabel;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmConst

  TestTAsmConst = class(TTestCase)
  strict private
    FAsmConst: TAsmConst;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmVar

  TestTAsmVar = class(TTestCase)
  strict private
    FAsmVar: TAsmVar;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmType

  TestTAsmType = class(TTestCase)
  strict private
    FAsmType: TAsmType;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TAsmScanner

  TestTAsmScanner = class(TTestCase)
  strict private
    FAsmScanner: TAsmScanner;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRun;
    procedure TestFindInstructionByName;
    procedure TestFindVarByName;
    procedure TestFindStructByName;
  end;

implementation

procedure TestTAsmBase.SetUp;
begin
  FAsmBase := TAsmBase.Create(0, 0, '');
end;

procedure TestTAsmBase.TearDown;
begin
  FAsmBase.Free;
  FAsmBase := nil;
end;

procedure TestTAsmInclude.SetUp;
begin
  FAsmInclude := TAsmInclude.Create(0, 0, '');
end;

procedure TestTAsmInclude.TearDown;
begin
  FAsmInclude.Free;
  FAsmInclude := nil;
end;

procedure TestTAsmIntruction.SetUp;
begin
  FAsmIntruction := TAsmIntruction.Create(0, 0, '', nil);
end;

procedure TestTAsmIntruction.TearDown;
begin
  FAsmIntruction.Free;
  FAsmIntruction := nil;
end;

procedure TestTAsmImport.SetUp;
begin
  FAsmImport := TAsmImport.Create(0, 0, '', '', nil);
end;

procedure TestTAsmImport.TearDown;
begin
  FAsmImport.Free;
  FAsmImport := nil;
end;

procedure TestTAsmInterface.SetUp;
begin
  FAsmInterface := TAsmInterface.Create(0, 0, '');
end;

procedure TestTAsmInterface.TearDown;
begin
  FAsmInterface.Free;
  FAsmInterface := nil;
end;

procedure TestTAsmMacro.SetUp;
begin
  FAsmMacro := TAsmMacro.Create(0, 0, '', '', nil);
end;

procedure TestTAsmMacro.TearDown;
begin
  FAsmMacro.Free;
  FAsmMacro := nil;
end;

procedure TestTAsmStructField.SetUp;
begin
  FAsmStructField := TAsmStructField.Create;
end;

procedure TestTAsmStructField.TearDown;
begin
  FAsmStructField.Free;
  FAsmStructField := nil;
end;

procedure TestTAsmStruct.SetUp;
begin
  FAsmStruct := TAsmStruct.Create(0, 0, '', '', TList<TAsmStructField>.Create(), nil);
end;

procedure TestTAsmStruct.TearDown;
begin
  FAsmStruct.Free;
  FAsmStruct := nil;
end;

procedure TestTAsmStruct.TestFindFieldByName;
var
  ReturnValue: TAsmStructField;
  Name: string;
begin
  // TODO: Setup method call parameters
  ReturnValue := FAsmStruct.FindFieldByName(Name);
  // TODO: Validate method results
end;

procedure TestTAsmStruc.SetUp;
begin
  FAsmStruc := TAsmStruc.Create(0, 0, '', '', nil);
end;

procedure TestTAsmStruc.TearDown;
begin
  FAsmStruc.Free;
  FAsmStruc := nil;
end;

procedure TestTAsmProcedure.SetUp;
begin
  FAsmProcedure := TAsmProcedure.Create(0, 0, '', '', nil);
end;

procedure TestTAsmProcedure.TearDown;
begin
  FAsmProcedure.Free;
  FAsmProcedure := nil;
end;

procedure TestTAsmLabel.SetUp;
begin
  FAsmLabel := TAsmLabel.Create(0, 0, '', nil);
end;

procedure TestTAsmLabel.TearDown;
begin
  FAsmLabel.Free;
  FAsmLabel := nil;
end;

procedure TestTAsmConst.SetUp;
begin
  FAsmConst := TAsmConst.Create(0, 0, '', '', nil);
end;

procedure TestTAsmConst.TearDown;
begin
  FAsmConst.Free;
  FAsmConst := nil;
end;

procedure TestTAsmVar.SetUp;
begin
  FAsmVar := TAsmVar.Create(0, 0, '', '', '', '', nil);
end;

procedure TestTAsmVar.TearDown;
begin
  FAsmVar.Free;
  FAsmVar := nil;
end;

procedure TestTAsmType.SetUp;
begin
  FAsmType := TAsmType.Create(0, 0, '', '', '', '', '', nil);
end;

procedure TestTAsmType.TearDown;
begin
  FAsmType.Free;
  FAsmType := nil;
end;

procedure TestTAsmScanner.SetUp;
begin
  FAsmScanner := TAsmScanner.Create;
end;

procedure TestTAsmScanner.TearDown;
begin
  FAsmScanner.Free;
  FAsmScanner := nil;
end;

procedure TestTAsmScanner.TestRun;
var
  IncludePath: string;
  Source: string;
  ProjectPath: string;
begin
  // TODO: Setup method call parameters
  FAsmScanner.Run(ProjectPath, Source, IncludePath);
  // TODO: Validate method results
end;

procedure TestTAsmScanner.TestFindInstructionByName;
var
  ReturnValue: TAsmIntruction;
  Name: string;
begin
  // TODO: Setup method call parameters
  ReturnValue := FAsmScanner.FindInstructionByName(Name);
  // TODO: Validate method results
end;

procedure TestTAsmScanner.TestFindVarByName;
var
  ReturnValue: TAsmVar;
  Name: string;
begin
  // TODO: Setup method call parameters
  ReturnValue := FAsmScanner.FindVarByName(Name);
  // TODO: Validate method results
end;

procedure TestTAsmScanner.TestFindStructByName;
var
  ReturnValue: TAsmStruct;
  Name: string;
begin
  // TODO: Setup method call parameters
  ReturnValue := FAsmScanner.FindStructByName(Name);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTAsmBase.Suite);
  RegisterTest(TestTAsmInclude.Suite);
  RegisterTest(TestTAsmIntruction.Suite);
  RegisterTest(TestTAsmImport.Suite);
  RegisterTest(TestTAsmInterface.Suite);
  RegisterTest(TestTAsmMacro.Suite);
  RegisterTest(TestTAsmStructField.Suite);
  RegisterTest(TestTAsmStruct.Suite);
  RegisterTest(TestTAsmStruc.Suite);
  RegisterTest(TestTAsmProcedure.Suite);
  RegisterTest(TestTAsmLabel.Suite);
  RegisterTest(TestTAsmConst.Suite);
  RegisterTest(TestTAsmVar.Suite);
  RegisterTest(TestTAsmType.Suite);
  RegisterTest(TestTAsmScanner.Suite);
end.

