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
  // Test methods for class TAsmScanner
  TestTAsmScanner = class(TTestCase)
  strict private
    FResourcesPath: string;
    FIncludePath: string;
    FSource: string;
    FProjectPath: string;
    FAsmScanner: TAsmScanner;
    FCustomStringList: TCustomStringList;
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

procedure TestTAsmScanner.SetUp;
begin
  FAsmScanner := TAsmScanner.Create();
  FCustomStringList := TCustomStringList.Create();

  FResourcesPath := ExtractFilePath(ParamStr(0)) + '..\..\Resources\';
  FIncludePath := FResourcesPath + 'INCLUDE\';
  FProjectPath := FResourcesPath + 'RecordVideo\';
end;

procedure TestTAsmScanner.TearDown;
begin
  FAsmScanner.Free();
  FAsmScanner := nil;

  FCustomStringList.Free();
  FCustomStringList := nil;

  FResourcesPath := '';
  FIncludePath := '';
  FSource := '';
  FProjectPath:= '';
end;

procedure TestTAsmScanner.TestRun;
begin
  FCustomStringList.LoadFromFile(FProjectPath + 'Main.asm');
  FSource := FCustomStringList.Text;

  FAsmScanner.Run(FProjectPath, FSource, FIncludePath);

  CheckNotEquals(0, FAsmScanner.ListInclude.Count, 'List Include');
  CheckNotEquals(0, FAsmScanner.ListImport.Count, 'List Import');
//  CheckNotEquals(0, FAsmScanner.ListInterface.Count, 'List Interface');
  CheckNotEquals(0, FAsmScanner.ListMacro.Count, 'List Macro');
  CheckNotEquals(0, FAsmScanner.ListStruct.Count, 'List Struct');
  CheckNotEquals(0, FAsmScanner.ListStruc.Count, 'List Struc');
  CheckNotEquals(0, FAsmScanner.ListProcedure.Count, 'List Procedure');
  CheckNotEquals(0, FAsmScanner.ListLabel.Count, 'List Label');
  CheckNotEquals(0, FAsmScanner.ListConst.Count, 'List Const');
  CheckNotEquals(0, FAsmScanner.ListVar.Count, 'List Var');
//  CheckNotEquals(0, FAsmScanner.ListType.Count, 'List Type');
end;

procedure TestTAsmScanner.TestFindInstructionByName;
var
  ReturnValue: TAsmIntruction;
begin
  FCustomStringList.LoadFromFile(FProjectPath + 'Main.asm');
  FSource := FCustomStringList.Text;
  FAsmScanner.Run(FProjectPath, FSource, FIncludePath);

  ReturnValue := FAsmScanner.FindInstructionByName('BITMAPINFO');

  CheckEquals('BITMAPINFO', ReturnValue.FName, 'Incorrect Instruction Name!');
  CheckEquals('Data.inc', ExtractFileName(ReturnValue.FInclude.FName), 'Incorrect Instruction Include File Name!');
end;

procedure TestTAsmScanner.TestFindVarByName;
var
  ReturnValue: TAsmVar;
begin
  FCustomStringList.LoadFromFile(FProjectPath + 'Main.asm');
  FSource := FCustomStringList.Text;
  FAsmScanner.Run(FProjectPath, FSource, FIncludePath);

  ReturnValue := FAsmScanner.FindVarByName('_title');

  CheckEquals('_title', ReturnValue.FName, 'Incorrect Var Name!');
  CheckNull(ReturnValue.FInclude, 'Var Include Not Null!');
end;

procedure TestTAsmScanner.TestFindStructByName;
var
  ReturnValue: TAsmStruct;
begin
  FCustomStringList.LoadFromFile(FProjectPath + 'Main.asm');
  FSource := FCustomStringList.Text;
  FAsmScanner.Run(FProjectPath, FSource, FIncludePath);

  ReturnValue := FAsmScanner.FindStructByName('RGBQUAD');

  CheckEquals('RGBQUAD', ReturnValue.FName, 'Incorrect Struct Name!');
  CheckEquals('Data.inc', ExtractFileName(ReturnValue.FInclude.FName), 'Incorrect Struct Include File Name!');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTAsmScanner.Suite);
end.

