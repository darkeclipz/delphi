{ Rosa de Haan, Lars Rotgers, Opdracht 2, 20-9-2019 }
unit ParenthesisChecker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Stack;

type
  TParenthesisCheckerForm = class(TForm)
    EditInput: TEdit;
    Label1: TLabel;
    ButtonTryCheck: TButton;
    ButtonEmpyNotifications: TButton;
    ButtonEmptyForm: TButton;
    MemoOutput: TMemo;
    procedure ButtonTryCheckClick(Sender: TObject);
    procedure ButtonEmptyFormClick(Sender: TObject);
    procedure ButtonEmpyNotificationsClick(Sender: TObject);
  private
    { Private declarations }
    procedure ClearOutput;
    procedure ClearForm;
    procedure AddLineToOutput(Text: String);
    procedure CheckParenthesis;
    function IsParenthesis(Character: Char): Boolean;
    function IsOpeningParenthesis(Character: Char): Boolean;
    function IsClosingParenthesis(Character: Char): Boolean;
    function IsMatch(Left: Char; Right: Char): Boolean;
  public
    { Public declarations }
  end;

var
  ParenthesisCheckerForm: TParenthesisCheckerForm;

implementation

{$R *.dfm}

procedure TParenthesisCheckerForm.ClearOutput;
begin
  { Uitvoer leegmaken. }
  MemoOutput.Lines.Clear;
end;

procedure TParenthesisCheckerForm.ButtonEmptyFormClick(Sender: TObject);
begin
  { Invoer en uitvoer leegmaken. }
  ClearForm;
end;

procedure TParenthesisCheckerForm.ButtonEmpyNotificationsClick(Sender: TObject);
begin
  { Uitvoer leegmaken. }
  ClearOutput;
end;

procedure TParenthesisCheckerForm.ButtonTryCheckClick(Sender: TObject);
begin
  try
    { Uitvoer leegmaken en haakjes controleren. }
    ClearOutput;
    CheckParenthesis;
  except
    on E: Exception do
      { Alle foutmeldingen weergeven in het uitvoerveld. }
      AddLineToOutput(E.Message);
  end;
end;

procedure TParenthesisCheckerForm.CheckParenthesis;
var
  i: Integer;
  CurrentChar: Char;
  Stack: TStack;
  IsInputCorrect: Boolean;
begin
  IsInputCorrect := True;
  Stack := TStack.Create;
  Stack.Instantiate;

  { Alle karakters in het invoerveld bij langsgaan. }
  for i := 1 to Length(EditInput.Text) do { String indexing is 1-based }
  begin
    CurrentChar := EditInput.Text[i];

    { Als het karakter geen haake is, doorgaan naar het volgende karakter. }
    if not IsParenthesis(CurrentChar) then
      continue;

    { Als het een sluithaakje is en er zit niets op de stack, dan
      is dit een verkeerd sluithaakje. }
    if Stack.IsEmpty and IsClosingParenthesis(CurrentChar) then
    begin
      IsInputCorrect := False;
      AddLineToOutput('Sluithaakje teveel voor ' + CurrentChar + ' op positie '
        + IntToStr(i) + '.');
    end;

    { Als het een openingshaakje is, dan deze toevoegen aan de stack. }
    if IsOpeningParenthesis(CurrentChar) then
      Stack.Push(CurrentChar);

    { Als het een sluithaakje is en er zitten element op de stack. }
    if not Stack.IsEmpty and IsClosingParenthesis(CurrentChar) then
    begin
      { Controleren of het sluithaakje overeenkomt met het element
        op de stack. }
      if IsMatch(Stack.Peek, CurrentChar) then
      begin
        { Haakje van de stack afhalen. }
        Stack.Pop;
      end
      else
      begin
        { Haakje kwam niet overeen, dus een verkeerd sluithaakje. }
        IsInputCorrect := False;
        AddLineToOutput('Foutief sluithaakje ' + CurrentChar + ' op positie '
          + IntToStr(i) + '.');
      end;
    end;
  end;

  { Als er nog openingshaakjes op de stack zitten, dan hebben deze
    geen sluithaakje. Hiervoor een foutmelding weergeven. }
  while not Stack.IsEmpty do
  begin
    IsInputCorrect := False;
    AddLineToOutput('Geen sluithaakje voor ' + Stack.Pop + '.');
  end;

  { Als er geen fouten zijn, dan klopt de expressie. }
  if IsInputCorrect then
    AddLineToOutput('Alle haakjes zijn correct gepaard.');
end;

procedure TParenthesisCheckerForm.ClearForm;
begin
  { Formulier leegmaken en focus op het invoerveld leggen. }
  ClearOutput;
  EditInput.Clear;
  EditInput.SetFocus;
end;

procedure TParenthesisCheckerForm.AddLineToOutput(Text: String);
begin
  { Regel toevoegen aan uitvoer. }
  MemoOutput.Lines.Add(Text);
  { Een message queuen op de Windows Message Queue (Win32 API) om in het
    tekstveld een regel naar beneden te scrollen.

    SendMessage(Handle, Message, Parameter1, Parameter2)

    Handle: is een verwijzing naar het formulier element.
    WM_VSCROLL:  Window message om verticaal te scrollen.
    SB_LINEDOWN: Parameter om aan te geven dat er 1 regel naarbeneden moet
                 worden gescrolled.
    0:           Lege parameter.
  }
  SendMessage(MemoOutput.Handle, WM_VSCROLL, SB_LINEDOWN, 0); { Scroll to end. }
end;

function TParenthesisCheckerForm.IsParenthesis(Character: Char): Boolean;
begin
  { True als het een haakje is. }
  Result := IsOpeningParenthesis(Character) or IsClosingParenthesis(Character);
end;

function TParenthesisCheckerForm.IsOpeningParenthesis(Character: Char): Boolean;
begin
  { True als het een openingshaakje is. }
  Result := (Character = '[') or (Character = '(') or (Character = '{');
end;

function TParenthesisCheckerForm.IsClosingParenthesis(Character: Char): Boolean;
begin
  { True als het een sluithaakje is. }
  Result := (Character = ']') or (Character = ')') or (Character = '}');
end;

function TParenthesisCheckerForm.IsMatch(Left: Char; Right: Char): Boolean;
begin
  { True als de twee haakjes een match zijn, dus hetzelfde soort haakje. }
  Result := (Left = '[') and (Right = ']')
         or (Left = '(') and (Right = ')')
         or (Left = '{') and (Right = '}')
end;

end.
