unit DelForExTestFiles;

{$OPTIMIZATION off}

interface

uses
  Classes,
  SysUtils,
  TestFrameWork,
  GX_CodeFormatterTypes,
  GX_CodeFormatterSettings,
  GX_CodeFormatterDefaultSettings,
  GX_CodeFormatterEngine;

type
  TTestTestfiles = class(TTestCase)
  private
    FFormatter: TCodeFormatterEngine;
    procedure TestFile(const _Filename: string; _AllowFaiure: Boolean = False);
  protected
    function GetFormatSettings: TCodeFormatterEngineSettings; virtual; abstract;
    function GetResultDir: string; virtual; abstract;
    function GetConfigDirBS: string;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure testAbstractSealedClass;
    procedure testAngledBrackets;
    procedure testAsm;
    procedure testAsmProblem1;
    procedure testAssemblerNewlines;
    procedure testClassVar;
    procedure testCommentEnd;
    procedure testCompilerDirectives;
    procedure testConstSet;
    procedure testConstSetWithComment;
    procedure testConstSetWithCommentAtEnd;
    procedure testControlChars;
    procedure testDisableFormatComment;
    procedure testDotFloat;
    procedure testElseAtEnd;
    procedure testEmptyProgram;
    procedure testEmptyStringAssignment;
    procedure testEmptyUnit;
    procedure testFormula;
    procedure testHashCharStrings;
    procedure testHexNumbers;
    procedure testIfdefs;
    procedure testIfElseendif;
    procedure testIfThenElse;
    procedure testIfThenTry;
    procedure testIndentComment;
    procedure testJustOpeningComment;
    procedure testJustOpeningStarCommentInAsm;
    procedure testLargeFile;
    procedure testOperatorOverloading;
    procedure testQuotesError;
    procedure testRecordMethod;
    procedure testSingleElse;
    procedure testSlashCommentToCurly;
    procedure testStarCommentAtEol;
    procedure testStrictVisibility;
    procedure testStringWithSingleQuotes;
    procedure testTabBeforeEndInAsm;
    procedure testTripleQuotes;
    procedure testUnmatchedElse;
    procedure testUnmatchedEndif;
    procedure testUnmatchedIfdef;
    procedure testUnterminatedString;
    procedure testClassPropertiesCurrentlyFails;
    procedure testCurlyHalfCommentEndCurrentlyFails;
    procedure testGenericClassCurrentlyFails;
    procedure testNestedClassCurrentlyFails;
  end;

type
  TTestFilesHeadworkFormatting = class(TTestTestfiles)
  protected
    function GetFormatSettings: TCodeFormatterEngineSettings; override;
    function GetResultDir: string; override;
  published
  end;

type
  TTestFilesBorlandFormatting = class(TTestTestfiles)
  protected
    function GetFormatSettings: TCodeFormatterEngineSettings; override;
    function GetResultDir: string; override;
  end;

type
  TTestFilesDelforFormatting = class(TTestTestfiles)
  protected
    function GetFormatSettings: TCodeFormatterEngineSettings; override;
    function GetResultDir: string; override;
  end;

type
  TTestFilesTwmFormatting = class(TTestTestfiles)
  protected
    function GetFormatSettings: TCodeFormatterEngineSettings; override;
    function GetResultDir: string; override;
  end;

implementation

uses
  Dialogs,
  GX_CodeFormatterConfigHandler;

{ TTestTestfiles }

function TTestTestfiles.GetConfigDirBS: string;
begin
  Result := 'source\packagewiz\';
end;

procedure TTestTestfiles.SetUp;
var
  Settings: TCodeFormatterEngineSettings;
begin
  inherited;
  Settings := GetFormatSettings;
  FFormatter := TCodeFormatterEngine.Create;
  FFormatter.Settings.Settings := Settings;
end;

procedure TTestTestfiles.TearDown;
begin
  inherited;
  FFormatter.Free;
end;

procedure TTestTestfiles.TestFile(const _Filename: string; _AllowFaiure: Boolean);
var
  Filename: string;
  InFile: string;
  ExpectedFile: string;
  ExpectedText: TStringList;
  st: TStringList;
begin
  Filename := 'testfile_' + _Filename + '.pas';
  InFile := 'source\unittests\testcases\input\' + Filename;
  ExpectedFile := 'source\unittests\testcases\expected-' + GetResultDir + '\' + Filename;
  ExpectedText := nil;
  st := TStringList.Create;
  try
    st.LoadFromFile(InFile);
    ExpectedText := TStringList.Create;
    ExpectedText.LoadFromFile(ExpectedFile);
    FFormatter.Execute(st);
    try
      CheckEquals(ExpectedText.Text, st.Text, 'error in output');
    except
      st.SaveToFile('source\unittests\testcases\output-' + GetResultDir + '\' + Filename);
      if not _AllowFaiure then
        raise;
    end;
  finally
    ExpectedText.Free;
    st.Free;
  end;
end;

procedure TTestTestfiles.testStarCommentAtEol;
begin
  TestFile('StarCommentAtEol');
end;

procedure TTestTestfiles.testSlashCommentToCurly;
begin
  TestFile('SlashCommentToCurly');
end;

procedure TTestTestfiles.testStrictVisibility;
begin
  TestFile('strictvisibility');
end;

procedure TTestTestfiles.testCompilerDirectives;
begin
  TestFile('compilerdirectives');
end;

procedure TTestTestfiles.testAssemblerNewlines;
begin
  TestFile('assemblernewline');
end;

procedure TTestTestfiles.testIfdefs;
begin
  TestFile('ifdefs');
end;

procedure TTestTestfiles.testUnmatchedIfdef;
begin
  TestFile('unmatchedifdef');
end;

procedure TTestTestfiles.testUnmatchedElse;
begin
  TestFile('unmatchedelse');
end;

procedure TTestTestfiles.testUnmatchedEndif;
begin
  TestFile('unmatchedendif');
end;

procedure TTestTestfiles.testIfElseendif;
begin
  TestFile('IfElseEndif');
end;

procedure TTestTestfiles.testIfThenElse;
begin
  TestFile('ifthenelse');
end;

procedure TTestTestfiles.testIfThenTry;
begin
  Testfile('ifthentry');
end;

procedure TTestTestfiles.testDisableFormatComment;
begin
  Testfile('DisableFormatComment');
end;

procedure TTestTestfiles.testLargeFile;
begin
  Testfile('xdom_3_1');
end;

procedure TTestTestfiles.testNestedClassCurrentlyFails;
begin
  Testfile('NestedClass', True);
end;

procedure TTestTestfiles.testOperatorOverloading;
begin
  Testfile('OperatorOverloading');
end;

procedure TTestTestfiles.testTripleQuotes;
begin
  Testfile('triplequotes');
end;

procedure TTestTestfiles.testSingleElse;
begin
  TestFile('singleelse');
end;

procedure TTestTestfiles.testQuotesError;
begin
  TestFile('QuotesError');
end;

procedure TTestTestfiles.testRecordMethod;
begin
  TestFile('RecordMethod');
end;

procedure TTestTestfiles.testJustOpeningComment;
begin
  TestFile('OpeningCommentOnly');
end;

procedure TTestTestfiles.testElseAtEnd;
begin
  TestFile('ElseAtEnd');
end;

procedure TTestTestfiles.testJustOpeningStarCommentInAsm;
begin
  // I actually thought this would crash...
  TestFile('OpeningStarCommentInAsm');
end;

procedure TTestTestfiles.testTabBeforeEndInAsm;
begin
  TestFile('TabBeforeEndInAsm');
end;

procedure TTestTestfiles.testEmptyProgram;
begin
  TestFile('EmptyProgram');
end;

procedure TTestTestfiles.testEmptyUnit;
begin
  TestFile('EmptyUnit');
end;

procedure TTestTestfiles.testIndentComment;
begin
  TestFile('IndentComment');
end;

procedure TTestTestfiles.testUnterminatedString;
begin
  TestFile('UnterminatedString');
end;

procedure TTestTestfiles.testStringWithSingleQuotes;
begin
  // note this actually contains a string with the TEXT #13#10:
  // >hello ' #13#10);<
  TestFile('StringWithSingleQuote');
end;

procedure TTestTestfiles.testEmptyStringAssignment;
begin
  TestFile('EmptyStringAssignment');
end;

procedure TTestTestfiles.testHashCharStrings;
begin
  TestFile('HashCharStrings');
end;

procedure TTestTestfiles.testDotFloat;
begin
  TestFile('DotFloat');
end;

procedure TTestTestfiles.testHexNumbers;
begin
  TestFile('HexNumbers');
end;

procedure TTestTestfiles.testConstSet;
begin
  TestFile('ConstSet');
end;

procedure TTestTestfiles.testConstSetWithComment;
begin
  TestFile('ConstSetWithComment');
end;

procedure TTestTestfiles.testConstSetWithCommentAtEnd;
begin
  TestFile('ConstSetWithCommentAtEnd');
end;

procedure TTestTestfiles.testControlChars;
begin
  TestFile('ControlChars');
end;

procedure TTestTestfiles.testFormula;
begin
  TestFile('Formula');
end;

procedure TTestTestfiles.testGenericClassCurrentlyFails;
begin
  TestFile('GenericClass', True);
end;

procedure TTestTestfiles.testAbstractSealedClass;
begin
  TestFile('AbstractSealedClass');
end;

procedure TTestTestfiles.testAngledBrackets;
begin
  TestFile('AngledBrackets');
end;

procedure TTestTestfiles.testAsm;
begin
  TestFile('asm');
end;

procedure TTestTestfiles.testAsmProblem1;
begin
  TestFile('AsmProblem1');
end;

procedure TTestTestfiles.testClassPropertiesCurrentlyFails;
begin
  TestFile('ClassProperties', True);
end;

procedure TTestTestfiles.testClassVar;
begin
  TestFile('ClassVar');
end;

procedure TTestTestfiles.testCommentEnd;
begin
  TestFile('CommentEnd');
end;

procedure TTestTestfiles.testCurlyHalfCommentEndCurrentlyFails;
begin
  TestFile('CurlyHalfCommentEnd', True);
end;

{ TTestFilesHeadworkFormatting }

function TTestFilesHeadworkFormatting.GetFormatSettings: TCodeFormatterEngineSettings;
var
  Settings: TCodeFormatterSettings;
begin
  Settings := TCodeFormatterSettings.Create;
  try
    TCodeFormatterConfigHandler.ImportFromFile(GetConfigDirBS + 'DelForExOptions-headwork.ini', Settings);
    Result := Settings.Settings;
  finally
    Settings.Free;
  end;
end;

function TTestFilesHeadworkFormatting.GetResultDir: string;
begin
  Result := 'headwork';
end;

{ TTestFilesBorlandFormatting }

function TTestFilesBorlandFormatting.GetFormatSettings: TCodeFormatterEngineSettings;
begin
  Result := BorlandDefaults;
end;

function TTestFilesBorlandFormatting.GetResultDir: string;
begin
  Result := 'borland';
end;

{ TTestFilesDelforFormatting }

function TTestFilesDelforFormatting.GetFormatSettings: TCodeFormatterEngineSettings;
var
  Settings: TCodeFormatterSettings;
begin
  Settings := TCodeFormatterSettings.Create;
  try
    TCodeFormatterConfigHandler.ImportFromFile(GetConfigDirBS + 'DelForExOptions-Default.ini', Settings);
    Result := Settings.Settings;
  finally
    Settings.Free;
  end;
end;

function TTestFilesDelforFormatting.GetResultDir: string;
begin
  Result := 'default';
end;

{ TTestFilesTwmFormatting }

function TTestFilesTwmFormatting.GetFormatSettings: TCodeFormatterEngineSettings;
var
  Settings: TCodeFormatterSettings;
begin
  Settings := TCodeFormatterSettings.Create;
  try
    TCodeFormatterConfigHandler.ImportFromFile(GetConfigDirBS + 'DelForExOptions-twm.ini', Settings);
    Result := Settings.Settings;
  finally
    Settings.Free;
  end;
end;

function TTestFilesTwmFormatting.GetResultDir: string;
begin
  Result := 'twm';
end;

initialization
  RegisterTest(TTestFilesHeadworkFormatting.Suite);
  RegisterTest(TTestFilesBorlandFormatting.Suite);
  RegisterTest(TTestFilesDelforFormatting.Suite);
  RegisterTest(TTestFilesTwmFormatting.Suite);
end.

