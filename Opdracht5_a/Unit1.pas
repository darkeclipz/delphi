{ Lars Rotgers 550035, lars.rotgers@student.nhlstenden.com, 10-12-2019 }

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TForm1 = class(TForm)
    LabelTotalSolutions: TLabel;
    ButtonNext: TButton;
    ButtonExitApplication: TButton;
    DrawGrid: TDrawGrid;
    procedure DrawGridDrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure ButtonExitApplicationClick(Sender: TObject);
    public
    procedure Oplossing;
    procedure ProbeerZet (Vanaf: Integer);
    procedure init;
    procedure NeemWeg (Stuk, Stand, Vanaf: Integer);
    procedure Plaats (Stuk, Stand, Vanaf: Integer);
    function Past(Stuk, Stand, Vanaf: integer): boolean;
end;

var
  Form1: TForm1;

implementation
{$R *.dfm}

const
  { Totaal aantal puzzelstukken. }
  AantalStukken = 8;

  { Aantal mogelijke standen per puzzelstuk. }
  Standen: array[1..8] of Integer = (4, 2, 4, 4, 4, 4, 1, 8);

  { Posities voor elk stuk vanaf het ankerpunt. Voor stuk G wordt er maar
    1 positie gebruikt om geroteerde/gespiegelde oplossing weg te halen. }
  Bezetting: array[1..217] of Integer =
   (1,9,10,19,20,28,29,  1,7,8,9,10,16,17,     1,9,10,17,18,26,27,   1,9,10,11,12,20,21,   { Stuk A }
    1,2,3,9,10,11,12,    1,9,10,18,19,27,28,                                               { Stuk B }
    3,9,12,18,19,20,21,  1,2,9,18,27,28,29,    1,2,3,9,12,18,21,     1,2,11,20,27,28,29,   { Stuk C }
    1,2,9,10,11,18,19,   1,9,10,11,18,19,20,   1,2,9,10,11,19,20,    1,8,9,10,17,18,19,    { Stuk D }
    1,9,10,17,18,19,20,  1,2,3,10,11,19,20,    9,10,11,18,19,20,27,  7,8,9,16,17,18,27,    { Stuk E }
    1,2,9,10,11,19,28,   9,17,18,19,26,27,28,  1,9,10,11,12,18,19,   1,7,8,9,10,18,19,     { Stuk F }
    1,9,10,18,19,27,36,                                                                    { Stuk G; 1 orientatie }
    1,9,10,16,17,18,19,  1,2,3,11,12,20,21,    1,2,3,9,10,18,19,     1,9,10,18,19,20,21,   { Stuk H }
    9,18,19,20,27,28,29, 9,16,17,18,25,26,27,  1,2,9,10,11,18,27,    1,2,9,10,11,20,29);
var
  { Of een stuk nog vrij is. }
  Vrij:  array[1..8] of Boolean;
  Kleur: array[1..8] of TColor = (clRed, clFuchsia, clLime, clGreen,
                                  clYellow, clAqua, clBlue, clGray);

  { Of een vakje nog vrij is. }
  Vakje: array[1..82] of Integer;

  { Per stuk, per stand, alle posities opslaan vanaf het ankerpunt. }
  Zevental: array[1..8, 1..8, 1..7] of Integer;
  AantalOplossingen: Integer;

  { Hiermee kan het algoritme op pauze worden gezet, en weer verder worden
    gezocht naar een volgende oplossing. }
  Volgende: Boolean;

{ Weergeven van de puzzel. }
procedure TForm1.DrawGridDrawCell(Sender: TObject; Col, Row: Integer;
    Rect: TRect; State: TGridDrawState);
var
  k: integer;
begin
  k := Vakje[Row*9 + Col + 1];
  if k > 0 then
    DrawGrid.Canvas.Brush.Color := Kleur[k];
  DrawGrid.Canvas.FillRect(Rect);
end;

{ Hiermee wordt er gekeken of een stuk met een bepaald stand, en positie
  ook daadwerkelijk past. }
function TForm1.Past(Stuk, Stand, Vanaf: integer): boolean;
var
  k: Integer;
begin
  Result := True;
  k := 0;
  while Result and (k < 7) do
  begin
    Inc(k);
    Result := (Vakje[Vanaf + Zevental[Stuk, Stand, k]] = 0); { Is vakje leeg? }
 end;
end;

{ Een stuk op het bord plaatsen. Hiervoor wordt aangenomen dat het stuk
  past. }
procedure TForm1.Plaats (Stuk, Stand, Vanaf: Integer);
var
  k: Integer;
begin
  Vakje[Vanaf] := Stuk;
  for k := 1 to 7 do
    Vakje[Vanaf + Zevental[Stuk, Stand, k]] := Stuk;  { Plaats in vakje. }
  Vrij[Stuk]:=False;
end;
{ Hiermee wordt een stuk weer weggehaald door deze vakjes op 0 te
  zetten. }
procedure TForm1.NeemWeg (Stuk, Stand, Vanaf: Integer);
var k: Integer;
begin
  for k := 1 to 7 do
    Vakje[Vanaf + Zevental[Stuk, Stand, k]] := 0;   { Zet vakje op 0. }
  Vakje[Vanaf] := 0;
  Vrij[Stuk]:=True;
end;
{ Hiermee wordt de oplossing getoont als er een is gevonden, en wordt er op
  de gebruiker gewacht totdat er op volgende wordt geklikt. }
procedure TForm1.Oplossing;
begin
  DrawGrid.Refresh;
  Inc(AantalOplossingen);
  LabelTotalSolutions.Caption := 'Oplossing ' + IntToStr(AantalOplossingen);
  Volgende := False;
  ButtonNext.Enabled := True;
  repeat
    Application.ProcessMessages; { Wachten tot de gebruiker verder gaat. }
  until Volgende or Application.Terminated;
end;
{ Dit is het backtracking algoritme. Voor elk stuk wordt er gekeken of een
  vrij vakje is, en dan wordt deze daarin geplaatst. Vervolgens wordt de
  functie recursief aangeroepen en wordt er naar het volgende stuk gekeken.

  Zodra een zet geen oplossing geeft, en ProbeerZet terugkeert, dan wordt het
  geplaatste stuk weer weggehaald. Dit is het backtracking principe. }
procedure TForm1.ProbeerZet (Vanaf: Integer);
var Stuk, Stand, VV: Integer;
begin
  Application.ProcessMessages;
  if Application.Terminated then Exit;
  { Voor elke stuk, en elke orientatie, kijken of het past... }
  for Stuk := 1 to AantalStukken do
    begin
      if Vrij[Stuk] then
        for Stand := 1 to Standen[Stuk] do
          if Past(Stuk, Stand, Vanaf) then
          begin
            Plaats(Stuk, Stand, Vanaf);
            VV := Vanaf;
            while Vakje[VV] <> 0 do Inc(VV);
              if VV <> 82 then              { Nog niet het einde van het bord? }
                ProbeerZet(VV)                   { Ga naar het volgende vakje. }
              else
                Oplossing;
              NeemWeg(Stuk, Stand, Vanaf);   { Backtrack stap. }
          end;
    end;
end;

{ Alle waarden initialiseren. Voornamelijk de zevental array waarin alle
  posities worden opgeslagen voor elk mogelijk stuk en orientatie. }
procedure TForm1.Init;
var h, i, j, k: Integer;
begin
  AantalOplossingen := 0;
  h := 1;
  for i := 1 to 8 do
    for j := 1 to Standen[i] do
      for k := 1 to 7 do
      begin
        Zevental[i, j, k]:= Bezetting[h];
        Inc(h);
      end;
  for i := 1 to 9 do Vakje[9*i] := -1;
  for i := 73 to 80 do Vakje[i] := -1;
  for i := 1 to 8 do Vrij[i] := True;
  Vakje[82] := 0;
end;

{ Zodra de applicatie opstart, dan direct beginnen met zoeken naar
  de eeerste oplossing. }
procedure TForm1.FormActivate(Sender: TObject);
begin
  Init;
  Volgende := False;
  ButtonNext.Enabled := False;
  ProbeerZet(1);
end;

{ Zoeken naar de volgende oplossing. }
procedure TForm1.ButtonNextClick(Sender: TObject);
begin
  ButtonNext.Enabled := False;
  Volgende := True;
end;

{ Afsluiten van de applicatie. }
procedure TForm1.ButtonExitApplicationClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
