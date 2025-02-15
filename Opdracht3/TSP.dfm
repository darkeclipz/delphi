object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Handelsreizigersprobleem'
  ClientHeight = 461
  ClientWidth = 971
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 71
    Height = 13
    Caption = 'Aantal steden:'
  end
  object Label2: TLabel
    Left = 298
    Top = 16
    Width = 88
    Height = 13
    Caption = 'Maximale afstand:'
  end
  object Label3: TLabel
    Left = 16
    Top = 87
    Width = 78
    Height = 13
    Caption = 'Afstandentabel:'
  end
  object Label4: TLabel
    Left = 472
    Top = 87
    Width = 164
    Height = 13
    Caption = 'Optimale route en tussenstanden:'
  end
  object Label5: TLabel
    Left = 792
    Top = 87
    Width = 92
    Height = 13
    Caption = 'Rekentijden (sec.):'
  end
  object ButtonTryGenerateDistanceTable: TButton
    Left = 16
    Top = 48
    Width = 433
    Height = 25
    Caption = 'Genereer afstandentabel'
    TabOrder = 0
    OnClick = ButtonTryGenerateDistanceTableClick
  end
  object EditNumberOfCities: TEdit
    Left = 98
    Top = 13
    Width = 52
    Height = 21
    TabOrder = 1
    Text = '6'
  end
  object EditMaxDistance: TEdit
    Left = 392
    Top = 13
    Width = 57
    Height = 21
    TabOrder = 2
    Text = '20'
  end
  object StringGridDistances: TStringGrid
    Left = 16
    Top = 106
    Width = 433
    Height = 337
    DrawingStyle = gdsGradient
    TabOrder = 3
  end
  object CheckboxShowSteps: TCheckBox
    Left = 472
    Top = 15
    Width = 201
    Height = 17
    Caption = 'Tussenstappen weergeven'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object ButtonTrySolve: TButton
    Left = 472
    Top = 48
    Width = 297
    Height = 25
    Caption = 'Zoek kortste route'
    Enabled = False
    TabOrder = 5
    OnClick = ButtonTrySolveClick
  end
  object MemoRoutes: TMemo
    Left = 472
    Top = 106
    Width = 297
    Height = 337
    Lines.Strings = (
      'MemoRoutes')
    ReadOnly = True
    TabOrder = 6
  end
  object MemoRuntimes: TMemo
    Left = 792
    Top = 106
    Width = 162
    Height = 337
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    TabOrder = 7
  end
  object ButtonClearTimes: TButton
    Left = 792
    Top = 48
    Width = 162
    Height = 25
    Caption = 'Leegmaken'
    Enabled = False
    TabOrder = 8
    OnClick = ButtonClearTimesClick
  end
end
