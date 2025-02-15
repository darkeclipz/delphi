unit Blokjespuzzel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls;

type
  TPiece = Array[0..4] of Array[0..4] of Boolean;
  TGrid = Array[0..9] of Array[0..9] of Integer;
  TForm1 = class(TForm)
    ButtonNextSolution: TButton;
    ButtonStop: TButton;
    EditSolutions: TEdit;
    Label1: TLabel;
    DrawGrid: TDrawGrid;
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure ButtonNextSolutionClick(Sender: TObject);
  private
    { Private declarations }
    Grid: TGrid;
    CurrentPiece: Integer;
    procedure Init;
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  Pieces: Array[0..7] of TPiece = (
    { Z }
    (
      (True , True, False, False, False),
      (True , True, False, False, False),
      (False, True, True , False, False),
      (False, True, True , False, False),
      (False, False, False, False, False)
    ),
    { I }
    (
      (True , True , True , True , False),
      (True , True , True , True , False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False)
    ),
    { L }
    (
      (False, False, True , True , False),
      (False, False, True , True , False),
      (True , True , True , True , False),
      (False, False, False, False, False),
      (False, False, False, False, False)
    ),
    { U }
    (
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False)
    ),
    { Y }
    (
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False)
    ),
    { B }
    (
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False)
    ),
    { T }
    (
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False)
    ),
    { P }
    (
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False),
      (False, False, False, False, False)
    )
  );
  Colors: Array[0..8] of TColor =
    (clWhite, clRed, clBlue, clRed, clBlue, clRed, clBlue, clRed, clBlue);

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.Init;
end;

procedure TForm1.Init;
var
  i, j: Integer;
begin
  CurrentPiece := 0;
  for i := 0 to 9 do
    for j := 0 to 9 do
      if (i = 0) or (i = 9) or (j = 0) or (j = 9) then
        Self.Grid[i, j] := -1
      else
        Self.Grid[i, j] := 0;
  DrawGrid.Refresh;
end;

procedure TForm1.ButtonNextSolutionClick(Sender: TObject);
var
  i, j: Integer;
begin

  for i := 0 to 4 do
    for j := 0 to 4 do
      if Pieces[CurrentPiece][i, j] then
        Grid[i + 1, j + 1] := CurrentPiece
      else
        Grid[i + 1, j + 1] := 0;

  Self.CurrentPiece := (Self.CurrentPiece + 1) mod 8;
  DrawGrid.Refresh;
end;

procedure TForm1.DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  Beep;

  if Grid[ARow, ACol] >= 0 then
    DrawGrid.Canvas.Brush.Color := Colors[Grid[ARow, ACol]]
  else
    DrawGRid.Canvas.Brush.Color := clGray;

  DrawGrid.Canvas.FillRect(Rect);
end;

end.
