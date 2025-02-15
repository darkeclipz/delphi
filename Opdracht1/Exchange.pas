unit Exchange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TChange = array[0..12] of Integer;
  TWisselgeld = class(TForm)
    Image1: TImage;
    Image2: TImage;
    EditTotal: TEdit;
    Label1: TLabel;
    CalculateChange: TButton;
    EditPaid: TEdit;
    Label2: TLabel;
    ResetForm: TButton;
    Label3: TLabel;
    EditChange: TEdit;
    EditChange0: TEdit;
    EditChange1: TEdit;
    EditChange2: TEdit;
    EditChange3: TEdit;
    EditChange4: TEdit;
    EditChange5: TEdit;
    EditChange6: TEdit;
    EditChange12: TEdit;
    EditChange11: TEdit;
    EditChange10: TEdit;
    EditChange9: TEdit;
    EditChange8: TEdit;
    EditChange7: TEdit;
    procedure CalculateChangeClick(Sender: TObject);
    procedure ResetFormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ClearForm();
    procedure ValidateDecimal(Value: Real);
    function CalculateChangeAndRound(Total, Paid: Real): Real;
    procedure ValidateAmountPaid(Total, Paid: Real);
    function CalculateSpareChange(Value: Real): TChange;
    procedure UpdateSpareChange(Changes: TChange);
  public
    { Public declarations }
  end;

var
  Wisselgeld: TWisselgeld;

implementation

{$R *.dfm}

procedure TWisselgeld.ClearForm();
begin
  EditTotal.Clear;
  EditPaid.Clear;
  EditChange.Clear;
  EditChange0.Clear;
  EditChange1.Clear;
  EditChange2.Clear;
  EditChange3.Clear;
  EditChange4.Clear;
  EditChange5.Clear;
  EditChange6.Clear;
  EditChange7.Clear;
  EditChange8.Clear;
  EditChange9.Clear;
  EditChange10.Clear;
  EditChange11.Clear;
  EditChange12.Clear;

  { Test amounts }
  EditTotal.Text := '8.87';
  EditPaid.Text := '10';
end;

procedure TWisselgeld.FormCreate(Sender: TObject);
begin
  ClearForm;
end;

procedure TWisselgeld.CalculateChangeClick(Sender: TObject);
var
  TotalInEuros, PaidInEuros, ChangeInEuros: Real;
  SpareChanges: TChange;
begin

  try
    TotalInEuros := StrToFloat(EditTotal.Text);
    PaidInEuros := StrToFloat(EditPaid.Text);
    ValidateDecimal(TotalInEuros);
    ValidateDecimal(PaidInEuros);
    ValidateAmountPaid(TotalInEuros, PaidInEuros);
    ChangeInEuros := CalculateChangeAndRound(TotalInEuros, PaidInEuros);
    SpareChanges := CalculateSpareChange(ChangeInEuros);
    EditChange.Text := FloatToStr(ChangeInEuros);
    UpdateSpareChange(SpareChanges);
  except
    on EConvertError do
      ShowMessage('Vul een decimaal getal in met puntnotatie.');
    on E : Exception do
      ShowMessage(E.Message);
  end;

end;

procedure TWisselgeld.ResetFormClick(Sender: TObject);
begin
  ClearForm;
end;

procedure TWisselgeld.ValidateDecimal(Value: Real);
begin
  if Value < 0 then
    raise Exception.Create('Getal moet positief zijn.');

  if Value > 1000 then
    raise Exception.Create('Getal moet onder de 1000 zijn.');
end;

procedure TWisselgeld.ValidateAmountPaid(Total, Paid: Real);
begin
  if Paid < Total then
     raise Exception.Create('Betaalde bedrag moet groter of gelijk zijn aan '
        + 'het totale bedrag.');
end;

function TWisselgeld.CalculateChangeAndRound(Total: Real; Paid: Real): Real;
var Change, Remainder, Rounder: Integer;
begin

  { Aanpassen naar een x div 0.05 }

  Change := Trunc(100 * (Paid - Total));
  Remainder := Change mod 5;
  Rounder := 5 - Remainder;

  if Remainder >= 3 then
  begin
    Change := Change + Rounder;
  end
  else
  begin
    Change := Change - Remainder;
  end;

  Result := Change / 100;
end;

function TWisselgeld.CalculateSpareChange(Value: Real): TChange;
type
  TSpareChange = array[0..12] of Real;
const
  SpareChangeTypes: TSpareChange = (500, 200, 100, 50, 20, 10, 5,
                          2, 1, 0.50, 0.20, 0.10, 0.05);
  Epsilon: Real = 0.000001; { floating-point error marge }
var
  RemainingSpareChange: Real;
  SpareChanges: TChange;
  Index: Integer;
begin
  FillChar(SpareChanges, SizeOf(SpareChanges), 0);
  Index := 0;
  RemainingSpareChange := Value;
  while RemainingSpareChange > Epsilon do
  begin
    if RemainingSpareChange >= SpareChangeTypes[Index] - Epsilon then
    begin
      SpareChanges[Index] := SpareChanges[Index] + 1;
      RemainingSpareChange := RemainingSpareChange - SpareChangeTypes[Index];
    end
    else
    begin
      Index := Index + 1;
    end;
  end;
  Result := SpareChanges;
end;

procedure TWisselgeld.UpdateSpareChange(Changes: TChange);
begin
  EditChange0.Text := IntToStr(Changes[0]);
  EditChange1.Text := IntToStr(Changes[1]);
  EditChange2.Text := IntToStr(Changes[2]);
  EditChange3.Text := IntToStr(Changes[3]);
  EditChange4.Text := IntToStr(Changes[4]);
  EditChange5.Text := IntToStr(Changes[5]);
  EditChange6.Text := IntToStr(Changes[6]);
  EditChange7.Text := IntToStr(Changes[7]);
  EditChange8.Text := IntToStr(Changes[8]);
  EditChange9.Text := IntToStr(Changes[9]);
  EditChange10.Text := IntToStr(Changes[10]);
  EditChange11.Text := IntToStr(Changes[11]);
  EditChange12.Text := IntToStr(Changes[12]);
end;

end.
