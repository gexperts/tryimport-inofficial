object fmEditorShortcut: TfmEditorShortcut
  Left = 304
  Top = 219
  BorderStyle = bsDialog
  Caption = 'Define Shortcut'
  ClientHeight = 126
  ClientWidth = 221
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbxShortcut: TGroupBox
    Left = 6
    Top = 8
    Width = 209
    Height = 81
    Caption = 'Editor Expert Name'
    TabOrder = 0
    object lblShortCut: TLabel
      Left = 8
      Top = 24
      Width = 41
      Height = 13
      Caption = '&Shortcut'
    end
  end
  object btnCancel: TButton
    Left = 140
    Top = 96
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnOK: TButton
    Left = 60
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end