object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Pentomino'
  ClientHeight = 357
  ClientWidth = 279
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
  object Label1: TLabel
    Left = 8
    Top = 313
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object ButtonNext: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Volgende'
    TabOrder = 0
    OnClick = ButtonNextClick
  end
  object ButtonStop: TButton
    Left = 196
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 332
    Width = 263
    Height = 17
    TabOrder = 2
  end
  object DrawGrid: TDrawGrid
    Left = 8
    Top = 39
    Width = 263
    Height = 263
    ColCount = 8
    DefaultColWidth = 32
    DefaultRowHeight = 32
    FixedCols = 0
    RowCount = 8
    FixedRows = 0
    TabOrder = 3
    OnDrawCell = DrawGridDrawCell
  end
  object CheckBox1: TCheckBox
    Left = 174
    Top = 308
    Width = 97
    Height = 17
    Caption = 'Toon voortgang'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
end
