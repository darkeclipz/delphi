unit PermutationGenerator;


interface

uses SysUtils;

type
  TPermutation = Array of Integer;
  TPermutationGenerator = class

  private
    N: Integer;
  public
    constructor Create(N: Integer);
    function HasNextPermutation(Permutation: TPermutation): Boolean;
    function NextPermutation(Permutation: TPermutation): TPermutation;
    function PermutationToStr(Permutation: TPermutation): String;
    function FirstIndexWithBiggerNeighbor(Permutation: TPermutation): Integer;
    function GenerateFirstPermutation: TPermutation;
end;

implementation

constructor TPermutationGenerator.Create(N: Integer);
begin
  Self.N := N;
  GenerateFirstPermutation;
end;

function TPermutationGenerator.GenerateFirstPermutation: TPermutation;
{ Genereren van de eerste permutatie, dit is een lijst met 1,...,N. }
var
  I: Integer;
  Permutation: TPermutation;
begin
  SetLength(Permutation, N);
  for I := 1 to N + 1 do
    Permutation[I-1] := I;
  Result := Permutation;
end;

function TPermutationGenerator.HasNextPermutation(Permutation: TPermutation)
  : Boolean;
{ Geeft True terug als er voor de permutatie nog een volgende permutatie
  beschikbaar is. }
begin
  Result := FirstIndexWithBiggerNeighbor(Permutation) > 0;
end;

function TPermutationGenerator.FirstIndexWithBiggerNeighbor
  (Permutation: TPermutation): Integer;
{ Eerste index bepalen die een grotere rechterbuurman heeft. }
var
  I: Integer;
begin
  I := N - 1;
  while (I > 0) and (Permutation[I-1] >= Permutation[I]) do
    Dec(I);
  Result := I;
end;

function TPermutationGenerator.NextPermutation(Permutation: TPermutation)
  : TPermutation;
{ Volgende permutatie berekenen a.d.h.v. de huidige permutatie. }
var
  I, J, Value: Integer;
begin
  { Index van de grotere rechterbuur zoeken. }
  I := FirstIndexWithBiggerNeighbor(Permutation);
  Value := Permutation[I-1];
  J := N-1;

  { Eerste waarde zoeken die groter is dan de gevonden waarde. }
  while Permutation[J] <= Value do
    Dec(J);

  { Beide gevonden waarden omdraaien. }
  Permutation[I-1] := Permutation[J];
  Permutation[J] := Value;

  { De staart weer goedzetten. }
  J := N-1;
  while I < J do
  begin
    Value := Permutation[I];
    Permutation[I] := Permutation[J];
    Permutation[J] := Value;
    Inc(I);
    Dec(J);
  end;

  Result := Permutation;
end;

function TPermutationGenerator.PermutationToStr(Permutation: TPermutation)
  : String;
{ Permutatie omzetten naar een string zodat deze kan worden weergegeven. }
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Length(Permutation) - 1 do
    Result := Result + IntToStr(Permutation[I]) + '-';
  Result := Result + IntToStr(Permutation[0]);
end;


end.
