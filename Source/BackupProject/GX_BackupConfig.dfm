object fmBackupConfig: TfmBackupConfig
  Left = 482
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Backup Project Configuration'
  ClientHeight = 362
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object gbxOptions: TGroupBox
    Left = 8
    Top = 8
    Width = 361
    Height = 313
    Caption = 'Configuration'
    TabOrder = 0
    object lblDirectives: TLabel
      Left = 31
      Top = 38
      Width = 295
      Height = 14
      Caption = '{$I,  {$R, {#BACKUP, and #pragma backup directives'
    end
    object cbBackupInc: TCheckBox
      Left = 12
      Top = 20
      Width = 342
      Height = 17
      Caption = '&Scan pas/dpr/cpp files for files included by the'
      TabOrder = 0
      OnClick = cbBackupIncClick
    end
    object cbIncludeDir: TCheckBox
      Left = 12
      Top = 85
      Width = 342
      Height = 17
      Caption = '&Include directory names in backup'
      TabOrder = 2
    end
    object rgDefaultScope: TRadioGroup
      Left = 12
      Top = 237
      Width = 338
      Height = 65
      Caption = 'Default Backup Sc&ope'
      Items.Strings = (
        'Acti&ve project'
        'Project &group')
      TabOrder = 4
    end
    object gbBackupTarget: TGroupBox
      Left = 12
      Top = 116
      Width = 338
      Height = 113
      Caption = 'Backup &File Name'
      TabOrder = 3
      object lblBackupDir: TLabel
        Left = 25
        Top = 65
        Width = 152
        Height = 14
        Caption = '&Directory and file to save to'
        FocusControl = edBackupDir
      end
      object btnBackupDir: TButton
        Left = 308
        Top = 83
        Width = 21
        Height = 21
        Caption = '...'
        TabOrder = 3
        OnClick = btnBackupDirClick
      end
      object rbBackupAskForFile: TRadioButton
        Left = 8
        Top = 22
        Width = 313
        Height = 17
        Caption = '&Prompt for file name'
        TabOrder = 0
        OnClick = rbGenericBackupTargetClick
      end
      object rbBackupToDirectory: TRadioButton
        Tag = 1
        Left = 8
        Top = 44
        Width = 313
        Height = 17
        Caption = '&Auto-save to directory'
        TabOrder = 1
        OnClick = rbGenericBackupTargetClick
      end
      object edBackupDir: TEdit
        Left = 25
        Top = 83
        Width = 280
        Height = 22
        TabOrder = 2
      end
    end
    object cbSearchOnLibraryPath: TCheckBox
      Left = 28
      Top = 57
      Width = 326
      Height = 17
      Caption = 'Search &library path for included files'
      TabOrder = 1
    end
  end
  object btnOK: TButton
    Left = 126
    Top = 330
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 210
    Top = 330
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btHelp: TButton
    Left = 294
    Top = 330
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Help'
    TabOrder = 3
    OnClick = btHelpClick
  end
end
