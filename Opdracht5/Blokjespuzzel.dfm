object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Blokjespuzzel'
  ClientHeight = 500
  ClientWidth = 693
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
    Left = 504
    Top = 13
    Width = 102
    Height = 13
    Caption = 'Aantal oplossing(en):'
  end
  object ButtonNextSolution: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Volgende'
    TabOrder = 0
    OnClick = ButtonNextSolutionClick
  end
  object ButtonStop: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
  end
  object EditSolutions: TEdit
    Left = 612
    Top = 8
    Width = 73
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object DrawGrid: TDrawGrid
    Left = 89
    Top = 39
    Width = 440
    Height = 442
    ColCount = 10
    DefaultColWidth = 40
    DefaultRowHeight = 40
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    TabOrder = 3
    OnDrawCell = DrawGridDrawCell
  end
end
