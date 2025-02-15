unit TSP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, PermutationGenerator;

type
  TGraph = Array of Array of Integer;
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ButtonTryGenerateDistanceTable: TButton;
    EditNumberOfCities: TEdit;
    EditMaxDistance: TEdit;
    StringGridDistances: TStringGrid;
    CheckboxShowSteps: TCheckBox;
    ButtonTrySolve: TButton;
    MemoRoutes: TMemo;
    MemoRuntimes: TMemo;
    ButtonClearTimes: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure ButtonTryGenerateDistanceTableClick(Sender: TObject);
    procedure ButtonClearTimesClick(Sender: TObject);
    procedure ButtonTrySolveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);


  private
    DistanceGraph: TGraph;
    { Private declarations }
    procedure ClearForm;
    procedure DisplayDistanceGraph(Graph: TGraph);
    function GenerateDistanceGraph(N: Integer; Max: Integer): TGraph;
    function GetNumberOfCities: Integer;
    function GetMaximumDistance: Integer;
    function Solve(Graph: TGraph; ShowSteps: Boolean): TPermutation;
    function CalculateDistanceForPermutation(Graph: TGraph;
      Permutation: TPermutation): Integer;
  public

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

procedure TForm1.ClearForm;
begin
  { Alle velden in het formulier leegmaken. }
  MemoRuntimes.Clear;
  MemoRoutes.Clear;
end;

function TForm1.GetNumberOfCities: Integer;
begin
  { Aantal steden ophalen uit het veld. }
  Result := StrToInt(EditNumberOfCities.Text);
end;

function TForm1.GetMaximumDistance: Integer;
begin
  { Maximale afstand ophalen uit het veld. }
  Result := StrToInt(EditMaxDistance.Text);
end;

function TForm1.GenerateDistanceGraph(N: Integer; Max: Integer): TGraph;
{ Genereren van een afstandstabel met afstanden [1, MaxDistance] in
  een 2D array. }
var
  I, J: Integer;
  Distance: Integer;
  DistanceGraph: TGraph;
begin
  Randomize;
  { Array initialiseren}
  SetLength(DistanceGraph, N);
  for I := 0 to N - 1 do
    SetLength(DistanceGraph[I], N);
  { Array vullen met random afstanden. }
  for I := 0 to N - 1 do
    { Array is symmetrisch dus de helft kan worden overgeslagen. }
    for J := 0 to I do
    begin
      Distance := Random(Max) + 1;
      if I = J then
        Distance := 0;
      { Afstand in de tabel zetten, ook voor het symmetrische element. }
      DistanceGraph[I, J] := Distance;
      DistanceGraph[J, I] := Distance;
    end;
  Result := DistanceGraph;
end;

procedure TForm1.ButtonClearTimesClick(Sender: TObject);
begin
  { Het veld met de tijden leegmaken. }
  MemoRuntimes.Clear;
end;

procedure TForm1.ButtonTryGenerateDistanceTableClick(Sender: TObject);
{ Afstandtabel genereren en weergeven in het formulier. }
var
  N: Integer;
  MaxDistance: Integer;
  DistanceGraph: TGraph;
begin
  try
    ClearForm; { Leegmaken van het formulier. }
    N := GetNumberOfCities; { Aantal steden N ophalen. }
    MaxDistance := GetMaximumDistance; { Maximale afstand ophalen. }

    { Genereren van de afstandtabel. }
    DistanceGraph := GenerateDistanceGraph(N, MaxDistance);
    Self.DistanceGraph := DistanceGraph;

    { Weergeven van de afstandstabel.}
    DisplayDistanceGraph(DistanceGraph);

    ButtonTrySolve.Enabled := True;
    ButtonClearTimes.Enabled := True;

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TForm1.ButtonTrySolveClick(Sender: TObject);
{ Oplossen van het handelsreizigersprobleem. }
var
  ShowSteps: Boolean;
  Path: TPermutation;
  Freq, StartTime, EndTime: Int64;
  TotalTimeInSeconds: Real;
begin
  try
    { Kijken of de tussenstappen moeten worden weergegeven. }
    ShowSteps := CheckboxShowSteps.Checked;

    { Huidige uitvoer van routes leegmaken. }
    MemoRoutes.Clear;

    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(StartTime);

    { Oplossen van probleem. }
    Path := Solve(Self.DistanceGraph, ShowSteps);

    { Totale runtime berekenen en weergeven. }
    QueryPerformanceCounter(EndTime);
    TotalTimeInSeconds := (EndTime - StartTime) / Freq;
    MemoRuntimes.Lines.Add(FloatToStr(TotalTimeInSeconds));

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TForm1.DisplayDistanceGraph(Graph: TGraph);
{ Afstandstabel weergeven in StringGrid. }
var
  I, J, N: Integer;
begin
  N := Length(Graph);
  StringGridDistances.RowCount := N + 1;
  StringGridDistances.ColCount := N + 1;
  { Eerst de kolomtitels en rijtitels initialiseren. }
  for I := 0 to N do
  begin
      StringGridDistances.Cells[I, 0] := IntToStr(I);
      StringGridDistances.Cells[0, I] := IntToStr(I);
      StringGridDistances.Cells[I, I] := '-';
      StringGridDistances.ColWidths[I] := 48;
  end;
  StringGridDistances.Cells[0, 0] := '';
  { Alle gegevens vanuit de afstandstabel kopieren naar het StringGrid,
    ook hier hoeft maar de helft te worden gekopieerd en kan met symmetrie
    de andere afstand worden gevuld. }
  for I := 0 to N - 1 do
  begin
    for J := 0 to I - 1 do
    begin
      StringGridDistances.Cells[I+1, J+1] := IntToStr(Graph[I, J]);
      StringGridDistances.Cells[J+1, I+1] := IntToStr(Graph[J, I]);
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
{ Bij het opstarten het formulier leegmaken. }
begin
  ClearForm;
end;

function TForm1.Solve(Graph: TGraph; ShowSteps: Boolean): TPermutation;
{ Berekenen van de oplossing van het handelsreizigersprobleem. }
var
  Generator: TPermutationGenerator;
  Permutation, MinPermutation: TPermutation;
  Distance, MinDistance: Integer;
begin
  { Beginpermutatie genereren. }
  Generator := TPermutationGenerator.Create(Length(Graph));
  Permutation := Generator.GenerateFirstPermutation;
  { Minimale afstand en bijbehorende permutatie opslaan. }
  MinDistance := CalculateDistanceForPermutation(Graph, Permutation);
  MinPermutation := Permutation;
  { Zolang er nog volgende permutaties zijn ... }
  while Generator.HasNextPermutation(Permutation) do
  begin
    { Genereer de volgende permutatie en de afstand. }
    Permutation := Generator.NextPermutation(Permutation);
    Distance := CalculateDistanceForPermutation(Graph, Permutation);
    if Distance < MinDistance then
    begin
      { Nieuwe kortste rondrit gevonden, dus opslaan. }
      MinDistance := Distance;
      MinPermutation := Copy(Permutation);
      { Als de tussenstappen moeten worden weergegeven, dan weergeven. }
      if ShowSteps then
        MemoRoutes.Lines.Add(
          Generator.PermutationToStr(Permutation) + ' : ' + IntToStr(Distance));
    end;

  end;

  { Resultaat weergeven met de kortste route. }
  MemoRoutes.Lines.Add(#13#10 + 'Optimale route:');
  MemoRoutes.Lines.Add(Generator.PermutationToStr(MinPermutation)
    + ' : ' + IntToStr(MinDistance));

  Result := MinPermutation;
end;

function TForm1.CalculateDistanceForPermutation(Graph: TGraph;
                                           Permutation: TPermutation): Integer;
{ Afstand berekenen voor een permutatie. }
var
  I, TotalDistance: Integer;
begin
  TotalDistance := 0;
  { Alle permutaties van 0 tot n - 2 (de laatste niet) bijlangsgaan ... }
  for I := 0 to Length(Permutation) - 2 do
  begin
    { Afstand berekenen van huidige punt naar het volgende punt. }
    TotalDistance := TotalDistance
      + Graph[Permutation[I] - 1, Permutation[I+1] - 1];
  end;
  { Afstand berekenen van het laatste punt weer naar het beginpunt. }
  Result := TotalDistance
    + Graph[Permutation[0] - 1, Permutation[Length(Permutation) - 1] - 1];
end;

{$R *.dfm}

end.
