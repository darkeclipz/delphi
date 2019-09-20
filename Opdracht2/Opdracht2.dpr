program Opdracht2;

uses
  Vcl.Forms,
  ParenthesisChecker in 'ParenthesisChecker.pas' {ParenthesisCheckerForm},
  Stack in 'Stack.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TParenthesisCheckerForm, ParenthesisCheckerForm);
  Application.Run;
end.
