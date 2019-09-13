program Project1;

uses
  Vcl.Forms,
  Exchange in 'Exchange.pas' {Wisselgeld};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TWisselgeld, Wisselgeld);
  Application.Run;
end.
