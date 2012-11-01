// parses Delphi code into a token collection
// Original Author:     Egbert van Nes (http://www.dow.wau.nl/aew/People/Egbert_van_Nes.html)
// Contributors:        Thomas Mueller (http://www.dummzeuch.de)
// Jens Borrisholt (Jens@borrisholt.dk) - Cleaning up the code, and making it aware of seval language features

unit GX_CodeFormatterParser;

{$I GX_CondDefine.inc}

interface

uses
  SysUtils,
  Classes,
  GX_PascalTokenList,
  GX_CodeFormatterTypes,
  GX_CodeFormatterSettings,
  GX_CodeFormatterTokens;

type
  TIdentifiersList = class(TStringList)
  private
    FIdentifiersCase: TCase;
  public
    constructor Create(const _IdentifiersCase: TCase); reintroduce;
    function AddIdentifier(const _s: string): string;
  end;

type
  {: usage:
     Tokens := TCodeFormatterParser.Execute(Text, Settings); }
  TCodeFormatterParser = class
  private
    FSpacePerIndent: Integer;
    FStartCommentOut: AnsiString;
    FEndCommentOut: AnsiString;
  private
    FTokens: TPascalTokenList;
    FReadingAsm: Boolean;
    FAsmComment: TWordType;
    FPrevLine: TLineFeed;
    FPrevType: TWordType;
    FLeftPointBracket: Integer;
    FIdentifiers: TIdentifiersList;
    {: ReadAsm does very simple parsing only to find comments because this
       influences finding the matching "end". No formatting is done
       later to asm code }
    procedure ReadAsm(var ABuff: PAnsiChar);
    function ReadHalfComment(out ADest: string; var ASource: PAnsiChar): TWordType;
    function ReadWord(out ADest: string; var ASource: PAnsiChar): TWordType;
    {: Adds a single line of text to the parse tree }
    procedure AddLine(ABuff: PAnsiChar);
    procedure DoExecute(AText: TStrings);
  public
    constructor Create(ASettings: TCodeFormatterSettings);
    destructor Destroy; override;
    {: parses the text and returns a parse tree }
    class function Execute(AText: TStrings; ASettings: TCodeFormatterSettings): TPascalTokenList;
  end;

implementation

constructor TCodeFormatterParser.Create(ASettings: TCodeFormatterSettings);
begin
  inherited Create;
  FSpacePerIndent := ASettings.SpacePerIndent;
  FStartCommentOut := ASettings.StartCommentOut;
  FEndCommentOut := ASettings.EndCommentOut;
  FLeftPointBracket := 0;
  FReadingAsm := False;
  FPrevLine := nil;
  FPrevType := wtNothing;
  FTokens := TPascalTokenList.Create(500);
  FIdentifiers := TIdentifiersList.Create(ASettings.Identifiers);
end;

destructor TCodeFormatterParser.Destroy;
begin
  FreeAndNil(FIdentifiers);
  inherited;
end;

class function TCodeFormatterParser.Execute(AText: TStrings; ASettings: TCodeFormatterSettings): TPascalTokenList;
var
  Parser: TCodeFormatterParser;
begin
  Parser := TCodeFormatterParser.Create(ASettings);
  try
    Parser.DoExecute(AText);
    Result := Parser.FTokens;
  finally
    Parser.Free;
  end;
end;

procedure TCodeFormatterParser.DoExecute(AText: TStrings);
var
  i: Integer;
begin
  for i := 0 to AText.Count - 1 do
    AddLine(PAnsiChar(AnsiString(AText[i])));
end;

procedure TCodeFormatterParser.AddLine(ABuff: PAnsiChar);
var
  s: string;
begin
  FPrevLine := TLineFeed.Create(0, FSpacePerIndent);
  FTokens.Add(FPrevLine);

  if FReadingAsm then
    ReadAsm(ABuff);

  while (ABuff^ <> #0) do begin
    if FPrevType in [wtHalfComment, wtHalfStarComment, wtHalfOutComment] then
      FPrevType := ReadHalfComment(s, ABuff)
    else
      FPrevType := ReadWord(s, ABuff);

    if FPrevType = wtSpaces then begin
      if (FPrevLine <> nil) and (FPrevLine.FNoOfSpaces = 0) then begin
        FPrevLine.FNoOfSpaces := Length(s);
        FPrevLine.FOldNoOfSpaces := FPrevLine.FNoOfSpaces;
      end;
    end else begin
      FTokens.Add(TExpression.Create(FPrevType, s));

      if FReadingAsm and (ABuff^ <> #0) then
        ReadAsm(ABuff);
    end;
  end;

  if FTokens.Count >= MaxCollectionSize - 100 then
    raise ECodeFormatter.Create('File to large to reformat')
end;

procedure TCodeFormatterParser.ReadAsm(var ABuff: PAnsiChar);
var
  P: PAnsiChar;
  FirstNonWhitespace: PAnsiChar;
  s: string;
begin
  P := ABuff;
  FirstNonWhitespace := ABuff;

  while FirstNonWhitespace^ in [Tab, Space] do
    Inc(FirstNonWhitespace);

  while p^ <> #0 do begin
    case FAsmComment of
      wtHalfComment: begin
          if P^ = '}' then
            FAsmComment := wtWord;
          Inc(P);
        end;

      wtHalfStarComment: begin
          if (P^ = '*') and ((P + 1)^ = ')') then begin
            FAsmComment := wtWord;
            Inc(P);
          end;

          Inc(P);
        end;
    else // case
      if ((P = ABuff) or ((P - 1)^ in [' ', Tab]))
        and (StrLIComp(P, 'end', 3) = 0)
        and ((P + 3)^ in [#0, ';', ' ', Tab]) then begin // 'end' of assembler
        FReadingAsm := False;

        if FirstNonWhitespace <> P then begin
          SetString(s, FirstNonWhitespace, p - FirstNonWhitespace - 1);
          FTokens.Add(TExpression.Create(wtAsm, s));
        end;

        ABuff := P;
        Exit;
      end else if P^ = '{' then begin // '{' comment
        Inc(P);

        while (P^ <> '}') and (P^ <> #0) do
          Inc(P);

        if p^ = #0 then
          FAsmComment := wtHalfComment
        else
          Inc(P);
      end else if (P^ = '(') and ((P + 1)^ = '*') then begin // '(*' comment
        Inc(p, 2);
        while (P^ <> #0) and ((P^ <> '*') or ((P + 1)^ <> ')')) do
          Inc(P);
        if p^ = #0 then
          FAsmComment := wtHalfStarComment
        else
          Inc(P, 2);
      end else if (P^ = '/') and ((P + 1)^ = '/') then begin // '//' comment
        Inc(p, 2);
        while P^ <> #0 do begin
          Inc(P);
        end
      end else
        Inc(P);
    end; // case
  end; // while

  SetString(s, ABuff, StrLen(ABuff));
  FTokens.Add(TExpression.Create(wtAsm, s));
  ABuff := P;
end;

function TCodeFormatterParser.ReadWord(out ADest: string; var ASource: PAnsiChar): TWordType;
const
  IdentifierTerminators = [
    '+', '-', '*', '/', '=',
    '(', ')', '[', ']', '{', '}',
    ',', ';', ':', '.',
    '<', '>', '@', '^',
    Space, '''', Tab, #0];
  { TODO -otwm -cfixme : This allows strings like #a which is wrong, but there is no easy way to fix it. }
  StringControlChars = ['0'..'9', 'a'..'z', 'A'..'Z', '#', '^', '$'];
var
  P: PAnsiChar;

  {: Reads a string literal, on exit p points behind the last character of the string
     @returns either wtString or wtErrorString }

  function ReadString: TWordType;
  begin
    Result := wtString;
    while True do begin
      Inc(P);
      case p^ of
        #0: begin
            // unterminated string (invalid Pascal code but we must deal with it anyway)
            Result := wtErrorString;
            Exit;
          end;

        #39: {// '} begin // we found either a quoted single quote or the end quote
            Inc(p);

            case p^ of
              #39: begin // skip quoted single quote
                  ; // do nothing, we just skipped it
                end;

              '#', '^': begin
                  // todo: this is not really correct code:
                  // 'hello'#^523 is not a valid string literal
                  while P^ in StringControlChars do
                    Inc(P);

                  if P^ <> #39 then begin
                    // we found the end of the string
                    Exit;
                  end;
                end;
            else
              // we found the ending quote
              Exit;
            end;
          end;
      end; // case
    end;

    // we never get here, exiting the function is done via several Exit statements
  end;

  {: Reads an identifier, on exit p points behind the last character of the identifier }

  procedure ReadIdentifier;
  begin
    Result := wtWord;
    { TODO -otwm -ccheck : Shouldn't that rather check for valid identifiers?
      Note that Delphi 2005 allows non ascii characters for identifiers, e.g. "M�ller" is a valid
      identifier! }
    while not (p^ in IdentifierTerminators) do
      Inc(P);
  end;

  // this handles the formatting enabling / disabling strings
  // default: '{(*}' ... '{*)}'

  function CheckDisableComments(out AResult: TWordType): Boolean;
  var
    Len: Integer;
  begin
    Result := (FStartCommentOut <> '') and (FEndCommentOut <> '');
    if not Result then
      Exit;

    Len := Length(FStartCommentOut);
    Result := StrLIComp(P, PAnsiChar(FStartCommentOut), Len) = 0;

    if not Result then
      Exit;

    AResult := wtHalfOutComment;
    Inc(P, Len);
    Len := Length(FEndCommentOut);

    while P^ <> #0 do begin
      if StrLIComp(P, PAnsiChar(FEndCommentOut), Len) = 0 then begin
        Inc(P, Len - 1);
        AResult := wtFullOutComment;
        Break;
      end;

      Inc(P);
    end;
  end;

begin
  P := ASource;

  if P^ in [Tab, Space] then begin
    Result := wtSpaces;
    while (P^ in [Tab, Space]) do
      Inc(P);
  end else if CheckDisableComments(Result) then begin
  end else
    case P^ of
      '{': begin
          Result := wtHalfComment;

          while not (P^ in ['}', #0]) do
            Inc(P);

          if (P^ = '}') then begin
            Result := wtFullComment;
            if (ASource + 1)^ = '$' then
              Result := wtCompDirective;

            Inc(p);
          end;
        end;

      #39: begin
          // single quote '
          Result := ReadString;
        end;

      '^': begin // string starting with ^A or so or the ^ operator
          Inc(p);
          if (P^ in ['a'..'z', 'A'..'Z']) and ((P + 1)^ in [#39, '^', '#']) then begin
            Result := wtString;

            while P^ in StringControlChars do
              Inc(P);

            if P^ = #39 then
              Result := ReadString;
          end else begin
            Result := wtOperator;
          end;
        end;
      '+', '-', '*', '=',
        ')', '[', ']', '}',
        ',', ';',
        '@': begin
          Result := wtOperator;
          Inc(p);
        end;

      '<': begin
          Result := wtOperator;
          Inc(p);
          if p^ in ['=', '>'] then // <= or <>
            Inc(p);
        end;

      '>', ':': begin
          Result := wtOperator;
          Inc(p);
          if p^ = '=' then // >= or :=
            Inc(P);
        end;

      '.': begin // .. or .) { TODO -otwm -ccheck : What about .9 for a float? It works, but why? }
          Result := wtOperator;
          Inc(p);
          case p^ of
            '.':
              Inc(P);
            ')': begin
                Dec(FLeftPointBracket);
                Inc(P);
              end;
          end;
        end;

      '(': begin // (. or (*
          Result := wtOperator;
          Inc(p);

          case p^ of
            '.': begin // (. (has precendence over .9, so '(.9)' is an error)
                Inc(FLeftPointBracket);
                Inc(P);
              end;

            '*': begin
                Inc(p);
                Result := wtHalfStarComment;

                while (P^ <> #0) and ((P^ <> '*') or ((P + 1)^ <> ')')) do
                  Inc(P);

                if p^ <> #0 then begin
                  Inc(P);
                  Result := wtFullComment;
                  if (ASource + 2)^ = '$' then
                    Result := wtCompDirective;

                  Inc(p);
                end;
              end;
          end; // case
        end;

      '/': begin // / or //
          if ((P + 1)^ = '/') then begin
            Result := wtFullComment;
            while P^ <> #0 do
              Inc(P);
          end else begin
            Result := wtOperator;
            Inc(p);
          end;
        end;

      '$': begin
          Result := wtHexNumber;
          Inc(P);

          while UpCase(P^) in ['0'..'9', 'A'..'F'] do
            Inc(P);
        end;
      '#': begin
          { TODO -otwm -cfixme :
            Ttis is for upper casing hex numbers, but it is rather ugly.
            It also misses those embedded in strings 'bla'#1d'blub' and will change #10^j to #10^J }
          Result := wtHexNumber;

          while P^ in StringControlChars do
            Inc(P);

          if P^ = #39 then begin
            // single quote
            Result := ReadString;
          end;
        end;

      '0'..'9': begin
          Result := wtNumber;
          while (P^ in ['0'..'9', '.']) and not (strLComp(P, '..', 2) = 0)
            and not ((FLeftPointBracket > 0) and (strLComp(P, '.)', 2) = 0)) do
            Inc(P);

          if UpCase(P^) = 'E' then
            if (P + 1)^ in ['0'..'9', '-', '+'] then begin
              Inc(P, 2);
              while (P^ in ['0'..'9']) do
                Inc(P);
            end;
        end;
    else
      ReadIdentifier;
    end;

  SetString(ADest, ASource, P - ASource);

  // This is for changing the casing of identifiers without adding them to
  // the global list.
  ADest := FIdentifiers.AddIdentifier(ADest);

  if SameText(ADest, AnsiString('asm')) then begin
    FReadingAsm := True;
    FAsmComment := wtWord;
  end;

  if (P^ = #0) then
    ASource := P
  else begin
    if (P^ in [Tab, Space]) then
      Inc(P);

    ASource := P;
  end;
end;

function TCodeFormatterParser.ReadHalfComment(out ADest: string; var ASource: PAnsiChar): TWordType;
var
  Len: Integer;
  P: PAnsiChar;
  FirstNonSpace: PAnsiChar;
  EndComment: AnsiString;
  EndCommentType: TWordType;
begin
  P := ASource;
  FirstNonSpace := ASource;

  while P^ in [Tab, Space] do
    Inc(P);

  if (FPrevLine <> nil) and (FPrevLine.FNoOfSpaces = 0) then begin
    FPrevLine.FNoOfSpaces := P - ASource;
    FPrevLine.FOldNoOfSpaces := P - ASource;
    FirstNonSpace := p;
  end;

  Result := FPrevType;

  case FPrevType of
    wtHalfComment: begin
        EndComment := '}';
        EndCommentType := wtFullComment;
      end;

    wtHalfStarComment: begin
        EndComment := '*)';
        EndCommentType := wtFullComment;
      end;

    wtHalfOutComment: begin
        EndComment := FEndCommentOut;
        EndCommentType := wtFullOutComment;
      end;
  else
    raise ECodeFormatter.Create('internal error: ReadHalfComment should only be called if FPrevType in [wtHalfComment, wtHalfStarComment, wtHalfOutComment]');
  end;

  Len := Length(EndComment);
  while (P^ <> #0) do begin
    if StrLIComp(P, PAnsiChar(EndComment), Len) = 0 then begin
      Result := EndCommentType;
      Inc(P, Len);
      Break;
    end;

    Inc(P);
  end;

  SetString(ADest, FirstNonSpace, P - FirstNonSpace);

  if P^ = #0 then
    ASource := P
  else
    ASource := P;
end;

{ TIdentifiersList }

function TIdentifiersList.AddIdentifier(const _s: string): string;
begin
  case FIdentifiersCase of
    rfLowerCase:
      Result := LowerCase(_s);
    rfUpperCase:
      Result := UpperCase(_s);
    rfFirstUp: begin
        Result := AnsiLowerCase(_s);
        Result[1] := AnsiUpperCase(_s)[1];
      end;
    rfUnchanged:
      Result := _s;
    rfFirstOccurrence:
      Result := Strings[Add(_s)];
  end;
end;

constructor TIdentifiersList.Create(const _IdentifiersCase: TCase);
begin
  inherited Create;
  FIdentifiersCase := _IdentifiersCase;
  CaseSensitive := False;
  Sorted := True;
  Duplicates := dupIgnore;
end;

end.
