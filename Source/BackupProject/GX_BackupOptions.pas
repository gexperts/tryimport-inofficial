unit GX_BackupOptions;

{$I GX_CondDefine.inc}

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls;

type
  TfmBackupOptions = class(TForm)
    gbBackupOptions: TGroupBox;
    btnOK: TButton;
    btnCancel: TButton;
    cbPassword: TCheckBox;
    lPassword: TLabel;
    edPassword: TEdit;
    rgScope: TRadioGroup;
    cbSearchLibraryPath: TCheckBox;
    procedure cbPasswordClick(Sender: TObject);
  end;

implementation

uses Graphics;

{$R *.dfm}

procedure TfmBackupOptions.cbPasswordClick(Sender: TObject);
begin
  edPassword.Enabled := cbPassword.Checked;
  if edPassword.Enabled then
  begin
    edPassword.Color := clWindow;
    try
      if edPassword.CanFocus and Visible then
        edPassword.SetFocus;
    except
      // Ignore all exceptions.
    end;
  end
  else
    edPassword.Color := clBtnface;
  edPassword.Refresh;
end;

end.
