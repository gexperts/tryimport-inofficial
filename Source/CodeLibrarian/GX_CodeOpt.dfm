object fmCodeOptions: TfmCodeOptions
  Left = 442
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Code Librarian Options'
  ClientHeight = 231
  ClientWidth = 284
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
  object btnOK: TButton
    Left = 124
    Top = 200
    Width = 75
    Height = 26
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 206
    Top = 200
    Width = 75
    Height = 26
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object pgeCodeOpt: TPageControl
    Left = 0
    Top = 0
    Width = 281
    Height = 193
    ActivePage = tabPaths
    TabIndex = 0
    TabOrder = 2
    object tabPaths: TTabSheet
      Caption = 'Paths'
      object lblStoragePath: TLabel
        Left = 8
        Top = 16
        Width = 152
        Height = 13
        Caption = 'Code Librarian Storage Location'
      end
      object sbBrowse: TButton
        Left = 244
        Top = 32
        Width = 21
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = sbBrowseClick
      end
      object edPath: TEdit
        Left = 8
        Top = 32
        Width = 237
        Height = 21
        TabOrder = 0
      end
    end
    object tabLayout: TTabSheet
      Caption = 'Layout'
      object rbSide: TRadioButton
        Left = 13
        Top = 16
        Width = 137
        Height = 17
        Caption = 'Side by side'
        TabOrder = 0
      end
      object pnlSideSide: TPanel
        Left = 13
        Top = 40
        Width = 105
        Height = 89
        BevelOuter = bvLowered
        Color = clWindow
        TabOrder = 1
        object shpLeft: TShape
          Left = 8
          Top = 8
          Width = 41
          Height = 73
        end
        object shpRight: TShape
          Left = 56
          Top = 8
          Width = 41
          Height = 73
        end
      end
      object rbTop: TRadioButton
        Left = 152
        Top = 16
        Width = 113
        Height = 17
        Caption = 'Top to bottom'
        TabOrder = 2
      end
      object pnlTopBottom: TPanel
        Left = 152
        Top = 40
        Width = 105
        Height = 89
        BevelOuter = bvLowered
        Color = clWindow
        TabOrder = 3
        object shpTop: TShape
          Left = 8
          Top = 8
          Width = 89
          Height = 33
        end
        object shpBottom: TShape
          Left = 8
          Top = 48
          Width = 89
          Height = 33
        end
      end
    end
    object tabFonts: TTabSheet
      Caption = 'Fonts'
      object lblTreeView: TLabel
        Left = 8
        Top = 16
        Width = 44
        Height = 13
        Caption = 'Treeview'
      end
      object lblEditor: TLabel
        Left = 8
        Top = 64
        Width = 27
        Height = 13
        Caption = 'Editor'
      end
      object lblSize: TLabel
        Left = 208
        Top = 13
        Width = 41
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = 'Size'
      end
      object fcTreeview: TComboBox
        Left = 8
        Top = 32
        Width = 193
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
      object fcEditor: TComboBox
        Left = 8
        Top = 80
        Width = 193
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
      end
      object udTreeview: TUpDown
        Left = 249
        Top = 32
        Width = 15
        Height = 21
        Associate = eTreeview
        Min = 4
        Max = 24
        Position = 8
        TabOrder = 2
        Wrap = False
      end
      object udEditor: TUpDown
        Left = 249
        Top = 80
        Width = 15
        Height = 21
        Associate = eEditor
        Min = 4
        Max = 24
        Position = 8
        TabOrder = 5
        Wrap = False
      end
      object eTreeview: TEdit
        Left = 208
        Top = 32
        Width = 41
        Height = 21
        TabOrder = 1
        Text = '8'
        OnKeyPress = eNumericKeyPress
      end
      object eEditor: TEdit
        Left = 208
        Top = 80
        Width = 41
        Height = 21
        TabOrder = 4
        Text = '8'
      end
    end
  end
end