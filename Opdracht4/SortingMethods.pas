{ Lars Rotgers; lars.rotgers@student.nhlstenden.com; 550035 }
unit SortingMethods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TIntegerArray = Array of Integer;
  TSorteren = class(TForm)
    Label1: TLabel;
    ButtonTrySort: TButton;
    ButtonClear: TButton;
    GroupBox1: TGroupBox;
    EditQuantity: TEdit;
    RadioSortSelection: TRadioButton;
    RadioSortQuick: TRadioButton;
    MemoQuantity: TMemo;
    MemoMethod: TMemo;
    MemoSortTime: TMemo;
    MemoPreSort: TMemo;
    MemoPostSort: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CheckBoxShowNumbers: TCheckBox;
    procedure ButtonClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonTrySortClick(Sender: TObject);
  private
    { Private declarations }
    procedure QuickSort(var a: Array of Integer; Low, High: Integer);
    procedure SelectionSort(var a: Array of Integer; n: Integer);
    procedure Swap(var a, b: Integer);
    procedure ClearMemos;
    procedure Sort;
    function CreateRandomArray(n: Integer): TIntegerArray;
    procedure PrintArray(a: TIntegerArray; memo: TMemo);
  public
    { Public declarations }
  end;

var
  Sorteren: TSorteren;

implementation

{$R *.dfm}

{ Hiermee wordt a en b omgewisseld. }
procedure TSorteren.Swap (var a, b: Integer);
var h: Integer;
begin
  h:=a; a:=b; b:=h
end;

{ Algoritme voor de selection sort. }
procedure TSorteren.SelectionSort (var a: array of integer; n: integer);
var i, j, k: integer;
begin
  for i := 0 to n-2 do
  begin
    k := i;
    for j := i+1 to n-1 do
      if a[j] < a[k] then
        k := j;
    Swap(a[i], a[k]);
  end;
end;

{ Algoritme voor de quick sort. }
procedure TSorteren.QuickSort(var a: Array of Integer; Low, High: Integer);
var h, i, j, m: Integer;
begin
  m := a[(Low + High) div 2];
  i := Low;
  j := High;
  while i <= j do
  begin
    while a[i] < m do i := i+1;
    while a[j] > m do j := j-1;
    if i <= j then
    begin
      h := a[i];
      a[i] := a[j];
      a[j] := h;
      i := i+1;
      j := j-1;
    end;

  end;
  if Low < j then QuickSort (a, Low, j);
  if i < High then QuickSort (a, i, High);
end;

{ Leegmaken van alle memo velden. }
procedure TSorteren.ButtonClearClick(Sender: TObject);
begin
  Self.ClearMemos;
end;

{ Sorteren en een foutmelding weergeven als deze voorkomt. }
procedure TSorteren.ButtonTrySortClick(Sender: TObject);
begin
  try
    Sort;
  except on E: Exception do
    ShowMessage(E.Message);
  end;
end;

{ Sorteren en de tijd bijhouden. }
procedure TSorteren.Sort();
var
  n: Integer;
  a: TIntegerArray;
  freq, start, stop: Int64;
  time: Real;
begin
  { Aantal getallen ophalen. }
  n := StrToInt(EditQuantity.Text);
  MemoQuantity.Lines.Add(IntToStr(n));

  { Random array maken met lengte N. }
  a := CreateRandomArray(n);

  { Getallen weergeven indien aangevinkt. }
  if CheckBoxShowNumbers.Checked then
    PrintArray(a, MemoPreSort);

  { Sorteermethode in memoveld zetten. }
  if RadioSortSelection.Checked then
    MemoMethod.Lines.Add('Selection')
  else
    MemoMethod.Lines.Add('Quick');

  { Tijd tellen. }
  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(start);

  { Sorteerfunctie aanroepen. }
  if RadioSortSelection.Checked then
    SelectionSort(a, Length(a));

  if RadioSortQuick.Checked then
    QuickSort(a, 0, Length(a) - 1);

  { Tijd stoppen. }
  QueryPerformanceCounter(stop);

  { Gesorteerde getallen weergeven indien aangevinkt. }
  if CheckBoxShowNumbers.Checked then
    PrintArray(a, MemoPostSort);

  { Totale uitvoertijd berekenen en weergeven. }
  time := (stop - start) / freq;
  MemoSortTime.Lines.Add(FormatFloat('0.0000000', time));
end;

{ Alle memo velden leegmaken. }
procedure TSorteren.ClearMemos;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TMemo then
      (Self.Components[i] as TMemo).Clear;
end;

{ Bij het opstarten de memo velden leegmaken. }
procedure TSorteren.FormCreate(Sender: TObject);
begin
  Self.ClearMemos;
end;

{ Een random array maken met lengte N, en random getallen. }
function TSorteren.CreateRandomArray(n: Integer): TIntegerArray;
var
  a: TIntegerArray;
  i: Integer;
begin
  Randomize;
  SetLength(a, n);
  for i := 0 to n - 1 do
    a[i] := Random(100);
  Result := a;
end;

{ Een array weergeven in een memo veld. }
procedure TSorteren.PrintArray(a: TIntegerArray; memo: TMemo);
var
  i: Integer;
begin
  memo.Clear;
  for i := 0 to Length(a) - 1 do
    memo.Lines.Add(IntToStr(i) + '  ' + IntToStr(a[i]));
end;

end.
