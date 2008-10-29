object fmAsciiChart: TfmAsciiChart
  Left = 422
  Top = 177
  AutoScroll = False
  Caption = 'ASCII Chart'
  ClientHeight = 322
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnClose = FormClose
  OnConstrainedResize = FormConstrainedResize
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 432
    Height = 22
    AutoSize = True
    ButtonWidth = 26
    EdgeBorders = []
    Flat = True
    Images = ilActions
    TabOrder = 0
    Wrapable = False
    OnResize = ToolBarResize
    object tbnCharLow: TToolButton
      Left = 0
      Top = 0
      Action = actCharLow
      Grouped = True
    end
    object tbnCharHigh: TToolButton
      Left = 26
      Top = 0
      Action = actCharHigh
      Grouped = True
    end
    object tbnSep1: TToolButton
      Left = 52
      Top = 0
      Width = 8
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbnCharDec: TToolButton
      Left = 60
      Top = 0
      Action = actCharDec
      Grouped = True
    end
    object tbnCharHex: TToolButton
      Left = 86
      Top = 0
      Action = actCharHex
      Grouped = True
    end
    object tbnSep2: TToolButton
      Left = 112
      Top = 0
      Width = 8
      ImageIndex = 2
      Style = tbsSeparator
    end
    object cbxFontName: TComboBox
      Left = 120
      Top = 0
      Width = 116
      Height = 21
      Hint = 'Character Font'
      Style = csDropDownList
      DropDownCount = 15
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = cbxFontNameChange
      OnEnter = cbxFontNameEnter
    end
    object edFontSize: TEdit
      Left = 236
      Top = 0
      Width = 25
      Height = 22
      MaxLength = 2
      TabOrder = 1
      Text = '6'
      OnChange = edFontSizeChange
    end
    object updFontSize: TUpDown
      Left = 261
      Top = 0
      Width = 15
      Height = 22
      Associate = edFontSize
      Min = 6
      Max = 20
      Position = 6
      TabOrder = 2
      Wrap = False
      OnClick = updFontSizeClick
    end
    object eChars: TEdit
      Left = 276
      Top = 0
      Width = 121
      Height = 22
      TabOrder = 3
    end
  end
  object pmContext: TPopupMenu
    AutoPopup = False
    Left = 72
    Top = 88
    object mitShowLowCharacters: TMenuItem
      Action = actCharLow
      GroupIndex = 1
      RadioItem = True
    end
    object mitShowHighCharacters: TMenuItem
      Action = actCharHigh
      GroupIndex = 1
      RadioItem = True
    end
    object mitSep1: TMenuItem
      Caption = '-'
      GroupIndex = 1
    end
    object mitCharAsDec: TMenuItem
      Action = actCharDec
      GroupIndex = 2
      RadioItem = True
    end
    object mitCharAsHex: TMenuItem
      Action = actCharHex
      GroupIndex = 2
      RadioItem = True
    end
    object mitSep2: TMenuItem
      Caption = '-'
      GroupIndex = 2
    end
    object mitFontSize8: TMenuItem
      Tag = 8
      Action = actFontSize8
      GroupIndex = 3
      RadioItem = True
    end
    object mitFontSize10: TMenuItem
      Tag = 10
      Action = actFontSize10
      GroupIndex = 3
      RadioItem = True
    end
    object mitFontSize12: TMenuItem
      Tag = 12
      Action = actFontSize12
      GroupIndex = 3
      RadioItem = True
    end
    object mitSep3: TMenuItem
      Caption = '-'
      GroupIndex = 3
    end
    object mitShowHints: TMenuItem
      Action = actShowHints
      GroupIndex = 3
    end
    object mitSep4: TMenuItem
      Caption = '-'
      GroupIndex = 3
    end
    object mitHelp: TMenuItem
      Action = actHelpHelp
      GroupIndex = 3
    end
    object mitAbout: TMenuItem
      Action = actHelpAbout
      GroupIndex = 3
    end
  end
  object HintTimer: TTimer
    Interval = 3000
    OnTimer = HintTimerTimer
    Left = 16
    Top = 88
  end
  object ilActions: TImageList
    Left = 128
    Top = 72
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001001000000000000018
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001002
      0000000010420000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF03
      1002000010420000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF03
      FF03100200000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      1042104210420000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF03
      1002000010420000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF03
      1002100200001042000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF03100210021042104200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001042
      0000FF0310020000104210420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000010020000
      1042104200001002000010420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF031002
      0000104210421002000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001002
      1002000000001002100200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF03
      100210021002FF03000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFF000000000000FFFF000000000000
      FC3F000000000000FC3F000000000000FC7F000000000000FE3F000000000000
      FC3F000000000000FC1F000000000000FE0F000000000000FD07000000000000
      F847000000000000F80F000000000000FC0F000000000000FC1F000000000000
      FFFF000000000000FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF7FFFFFFFFFFF787E3BFEFB7C1C7F77BD5BFEFB7DFBBF77BD5BFEFB7DFBB
      F77BF5BFEFB7DFBBF73BF1BFEFB7DFBBF747C783E037DFBBF77FD7BFEFB7DFC7
      D77FD7BFEFBFDFFFE77BD5BFEFBFDFFFF787E381EFB7DFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object Actions: TActionList
    Images = ilActions
    Left = 128
    Top = 120
    object actCharLow: TAction
      Category = 'HighLow'
      Caption = 'Show Characters &0-127'
      ImageIndex = 3
      OnExecute = actCharLowExecute
      OnUpdate = actCharLowUpdate
    end
    object actCharHigh: TAction
      Category = 'HighLow'
      Caption = 'Show Characters &128-255'
      ImageIndex = 2
      OnExecute = actCharHighExecute
      OnUpdate = actCharHighUpdate
    end
    object actCharDec: TAction
      Category = 'HexDec'
      Caption = 'Character Values as &Decimal'
      ImageIndex = 0
      OnExecute = actCharDecExecute
      OnUpdate = actCharDecUpdate
    end
    object actCharHex: TAction
      Category = 'HexDec'
      Caption = 'Character Values as &Hexadecimal'
      ImageIndex = 1
      OnExecute = actCharHexExecute
      OnUpdate = actCharHexUpdate
    end
    object actFontSize8: TAction
      Category = 'FontSize'
      Caption = 'Font Size := 8'
      OnExecute = actFontSize8Execute
      OnUpdate = actGenericFontSizeUpdate
    end
    object actFontSize10: TAction
      Category = 'FontSize'
      Caption = 'Font Size := 10'
      OnExecute = actFontSize10Execute
      OnUpdate = actGenericFontSizeUpdate
    end
    object actFontSize12: TAction
      Category = 'FontSize'
      Caption = 'Font Size := 12'
      OnExecute = actFontSize12Execute
      OnUpdate = actGenericFontSizeUpdate
    end
    object actShowHints: TAction
      Category = 'Options'
      Caption = 'Show Hi&nts'
      OnExecute = actShowHintsExecute
      OnUpdate = actShowHintsUpdate
    end
    object actHelpHelp: TAction
      Category = 'Help'
      Caption = '&Help'
      ImageIndex = 4
      ShortCut = 112
      OnExecute = actHelpHelpExecute
    end
    object actHelpAbout: TAction
      Category = 'Help'
      Caption = '&About...'
      OnExecute = actHelpAboutExecute
    end
  end
end
