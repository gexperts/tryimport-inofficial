object fmIdeShortCuts: TfmIdeShortCuts
  Left = 296
  Top = 249
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'IDE Menu Shortcuts'
  ClientHeight = 218
  ClientWidth = 674
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControls: TPanel
    Left = 0
    Top = 67
    Width = 674
    Height = 113
    Align = alBottom
    BevelOuter = bvNone
    FullRepaint = False
    TabOrder = 0
    DesignSize = (
      674
      113)
    object lblMenuStruc: TLabel
      Left = 21
      Top = 35
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = 'Menu &structure'
      FocusControl = edtMenuStructure
    end
    object lblMenuItemName: TLabel
      Left = 14
      Top = 6
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'Menu item &name'
      FocusControl = edtMenuItemName
    end
    object lblShortcut: TLabel
      Left = 52
      Top = 87
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sh&ortcut'
    end
    object edtMenuStructure: TEdit
      Left = 100
      Top = 31
      Width = 564
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object edtMenuItemName: TEdit
      Left = 100
      Top = 3
      Width = 564
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
      Text = ' '
    end
    object chkUseShortcut: TCheckBox
      Left = 100
      Top = 62
      Width = 285
      Height = 13
      Caption = '&Apply a custom shortcut to this menu item'
      Enabled = False
      TabOrder = 2
      OnClick = chkUseShortcutClick
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 180
    Width = 674
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object pnlButtonsRight: TPanel
      Left = 388
      Top = 0
      Width = 286
      Height = 38
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btOK: TButton
        Left = 9
        Top = 3
        Width = 82
        Height = 27
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
        OnClick = btOKClick
      end
      object btCancel: TButton
        Left = 102
        Top = 3
        Width = 82
        Height = 27
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
      object btnHelp: TButton
        Left = 194
        Top = 3
        Width = 82
        Height = 27
        Caption = '&Help'
        TabOrder = 2
        OnClick = btnHelpClick
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 8
  end
end
