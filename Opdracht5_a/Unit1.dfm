object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Puzzel'
  ClientHeight = 321
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelTotalSolutions: TLabel
    Left = 113
    Top = 8
    Width = 60
    Height = 13
    Alignment = taCenter
    Caption = '<oplossing>'
  end
  object ButtonNext: TButton
    Left = 8
    Top = 9
    Width = 75
    Height = 25
    Caption = 'Volgende'
    TabOrder = 0
    OnClick = ButtonNextClick
  end
  object ButtonExitApplication: TButton
    Left = 206
    Top = 9
    Width = 75
    Height = 25
    Caption = 'Einde'
    TabOrder = 1
    OnClick = ButtonExitApplicationClick
  end
  object DrawGrid: TDrawGrid
    Left = 8
    Top = 40
    Width = 273
    Height = 273
    Color = clBtnFace
    ColCount = 8
    DefaultColWidth = 32
    DefaultRowHeight = 32
    FixedCols = 0
    RowCount = 8
    FixedRows = 0
    ScrollBars = ssNone
    TabOrder = 2
    OnDrawCell = DrawGridDrawCell
  end
end
