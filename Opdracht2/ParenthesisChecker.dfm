object ParenthesisCheckerForm: TParenthesisCheckerForm
  Left = 0
  Top = 0
  Caption = 'Haakjescontrole'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 85
    Height = 13
    Caption = 'Voer een tekst in:'
  end
  object EditInput: TEdit
    Left = 8
    Top = 27
    Width = 489
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '[{()}]'
  end
  object ButtonTryCheck: TButton
    Left = 400
    Top = 54
    Width = 97
    Height = 25
    Caption = 'Controleren'
    TabOrder = 2
    OnClick = ButtonTryCheckClick
  end
  object ButtonEmpyNotifications: TButton
    Left = 8
    Top = 54
    Width = 156
    Height = 25
    Caption = 'Meldingen leegmaken'
    TabOrder = 1
    TabStop = False
    OnClick = ButtonEmpyNotificationsClick
  end
  object ButtonEmptyForm: TButton
    Left = 170
    Top = 54
    Width = 156
    Height = 25
    Caption = 'Alles leegmaken'
    TabOrder = 3
    TabStop = False
    OnClick = ButtonEmptyFormClick
  end
  object MemoOutput: TMemo
    Left = 8
    Top = 85
    Width = 489
    Height = 138
    TabStop = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
end
