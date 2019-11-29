program Opdracht4;

uses
  Vcl.Forms,
  SortingMethods in 'SortingMethods.pas' {Sorteren};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSorteren, Sorteren);
  Application.Run;
end.
