object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Sudoku solver'
  ClientHeight = 593
  ClientWidth = 427
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
  object OutputMemo: TMemo
    Left = 9
    Top = 471
    Width = 409
    Height = 112
    Lines.Strings = (
      'OutputMemo')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object SudokuGrid: TStringGrid
    Left = 8
    Top = 56
    Width = 409
    Height = 409
    ColCount = 9
    DefaultColWidth = 44
    DefaultRowHeight = 44
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    GridLineWidth = 2
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 1
  end
  object LoadPuzzleButton: TButton
    Left = 8
    Top = 8
    Width = 89
    Height = 42
    Caption = 'Load'
    TabOrder = 2
    OnClick = LoadPuzzleButtonClick
  end
  object SolveButton: TButton
    Left = 250
    Top = 8
    Width = 81
    Height = 42
    Caption = 'Solve'
    TabOrder = 3
    OnClick = SolveButtonClick
  end
  object Animate: TCheckBox
    Left = 111
    Top = 8
    Width = 66
    Height = 42
    Caption = 'Animate'
    TabOrder = 4
  end
  object StopButton: TButton
    Left = 337
    Top = 8
    Width = 81
    Height = 42
    Caption = 'Stop'
    TabOrder = 5
    OnClick = StopButtonClick
  end
end
