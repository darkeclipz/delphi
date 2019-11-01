program Handelsreiziger;

uses
  Vcl.Forms,
  TSP in 'TSP.pas' {Form1},
  PermutationGenerator in 'PermutationGenerator.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
