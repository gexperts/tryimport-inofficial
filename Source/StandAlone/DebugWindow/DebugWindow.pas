unit DebugWindow;

{$I GX_CondDefine.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ImgList, Menus, ComCtrls, TrayIcon, ActnList, ToolWin;

type
  TfmDebug = class(TForm)
    pmuTaskBar: TPopupMenu;
    mitTrayShutdown: TMenuItem;
    mitTrayShow: TMenuItem;
    MainMenu: TMainMenu;
    mitFile: TMenuItem;
    mitClearWindow: TMenuItem;
    mitFileSep1: TMenuItem;
    mitFileShutdown: TMenuItem;
    mitFileExit: TMenuItem;
    mitFileOptions: TMenuItem;
    ilDebug: TImageList;
    lvMessages: TListView;
    mitEdit: TMenuItem;
    mitCopySelectedLines: TMenuItem;
    imgMessage: TImage;
    mitTrayClear: TMenuItem;
    mitSaveToFile: TMenuItem;
    dlgSaveLog: TSaveDialog;
    tbnClear: TToolButton;
    tbnCopy: TToolButton;
    tbnSave: TToolButton;
    tbnSep1: TToolButton;
    Actions: TActionList;
    actFileOptions: TAction;
    actFileShutdown: TAction;
    actFileHideWindow: TAction;
    actEditCopySelectedLines: TAction;
    actEditClearWindow: TAction;
    actEditSaveToFile: TAction;
    actViewShow: TAction;
    actShowItemInDialog: TAction;
    ToolBar: TToolBar;
    tbnSep2: TToolButton;
    tbnOptions: TToolButton;
    tbnPause: TToolButton;
    actFilePause: TAction;
    mitFilePause: TMenuItem;
    pmuListbox: TPopupMenu;
    mitListClearWindow: TMenuItem;
    mitListShowItem: TMenuItem;
    mitView: TMenuItem;
    actViewStayOnTop: TAction;
    actViewToolBar: TAction;
    mitViewShowToolBar: TMenuItem;
    mitViewStayOnTop: TMenuItem;
    actEditSelectAll: TAction;
    mitEditSelectAll: TMenuItem;
    mitListSelectAll: TMenuItem;
    ilImages: TImageList;
    ilDisabled: TImageList;
    procedure TrayIconDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lvMessagesDblClick(Sender: TObject);
    procedure actEditCopySelectedLinesExecute(Sender: TObject);
    procedure actEditClearWindowExecute(Sender: TObject);
    procedure actEditSaveToFileExecute(Sender: TObject);
    procedure actFileOptionsExecute(Sender: TObject);
    procedure actFileShutdownExecute(Sender: TObject);
    procedure actFileHideWindowExecute(Sender: TObject);
    procedure actViewShowExecute(Sender: TObject);
    procedure actShowItemInDialogExecute(Sender: TObject);
    procedure actShowItemInDialogUpdate(Sender: TObject);
    procedure actFilePauseExecute(Sender: TObject);
    procedure ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actViewToolBarExecute(Sender: TObject);
    procedure actViewStayOnTopExecute(Sender: TObject);
    procedure actEditSelectAllExecute(Sender: TObject);
  private
    FAllowClose: Boolean;
    FStayOnTop: Boolean;
    FTaskIcon: TTrayIcon;
    procedure SetStayOnTop(OnTop: Boolean);
    procedure SaveSettings;
    procedure LoadSettings;
    procedure ApplicationMsgHandler(var Msg: TMsg; var Handled: Boolean);
    procedure WMEndSession(var Message: TMessage); message WM_ENDSESSION;
    procedure WMCopyData(var Message: TWMCopyData); message WM_COPYDATA;
    procedure WMQueryEndSession(var Message: TMessage); message WM_QUERYENDSESSION;
    property StayOnTop: Boolean read FStayOnTop write SetStayOnTop;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  fmDebug: TfmDebug;

implementation

{$R *.dfm}

uses
  Clipbrd, Registry,
  DebugOptions, GX_GenericUtils;

type
  TDebugType = (dtMessage, dtSQL);

  TDebugMessage = record
    DebugType: TDebugType;
    MessageType: TMsgDlgType;
    Msg: string;
  end;

const
  TopMenu = 100;

{ TfmDebug }

procedure TfmDebug.WMCopyData(var Message: TWMCopyData);
var
  NewMsg: TDebugMessage;
  ListItem: TListItem;

  procedure AddMessage(MessageType: TMsgDlgType; const MessageText: string);
  begin
    if ConfigInfo.Bottom or (lvMessages.Items.Count = 0) then
    begin
      ListItem := lvMessages.Items.Add;
      ListItem.MakeVisible(True);
    end
    else
      ListItem := lvMessages.Items.Insert(0);
    ListItem.Caption := MessageText;
    ListItem.ImageIndex := Ord(MessageType);
    ListItem.SubItems.Add(TimeToStr(Time));
  end;

  procedure GetMessage;
  const
    chrClearCommand = #3;
    chrDebugTypeSQL = #2;
  var
    CData: TCopyDataStruct;
    MessageContent: PChar;
    i: Integer;
  begin
    CData := Message.CopyDataStruct^;
    MessageContent := CData.lpData;
    if MessageContent[0] = chrClearCommand then
    begin
      actEditClearWindow.Execute;
      Exit;
    end;

    if MessageContent[0] = chrDebugTypeSQL then
      NewMsg.DebugType := dtSQL
    else
      NewMsg.DebugType := dtMessage;

    NewMsg.MessageType := TMsgDlgType(Integer(MessageContent[1]) - 1);
    i := 2;
    while MessageContent[i] <> #0 do
    begin
      NewMsg.Msg := NewMsg.Msg + MessageContent[i];
      Inc(i);
    end;
  end;

var
  OldClientWidth: Integer;
begin
  GetMessage;
  if actFilePause.Checked then
    Exit;
  OldClientWidth := lvMessages.ClientWidth;
  if NewMsg.DebugType = dtMessage then
    AddMessage(NewMsg.MessageType, NewMsg.Msg);
  // Resize the header when the scrollbar is added
  if not (lvMessages.ClientWidth = OldClientWidth) then
    FormResize(Self);
  if not Visible then
    FTaskIcon.Icon := imgMessage.Picture.Icon;
  if ConfigInfo.OnMessage then
    Show;
end;

procedure TfmDebug.TrayIconDblClick(Sender: TObject);
begin
  actViewShow.Execute;
end;

procedure TfmDebug.FormResize(Sender: TObject);
begin
  if lvMessages.ClientWidth > 100 then
    lvMessages.Column[0].Width := lvMessages.ClientWidth - lvMessages.Column[1].Width;
end;

procedure TfmDebug.FormShow(Sender: TObject);
begin
  FTaskIcon.Icon := Icon;
  FormResize(Self);
  MainMenu.Images := ilImages;
end;

procedure TfmDebug.SetStayOnTop(OnTop: Boolean);
begin
  FStayOnTop := OnTop;
  if OnTop then
    SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE)
  else
    SetWindowPos(Self.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
end;

procedure TfmDebug.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := FAllowClose;
  if not CanClose then
    Hide;
end;

procedure TfmDebug.SaveSettings;
var
  Settings: TRegIniFile;
begin
  Settings := TRegIniFile.Create('Software\GExperts');
  try
    Settings.WriteInteger('Debug', 'Left', Left);
    Settings.WriteInteger('Debug', 'Top', Top);
    Settings.WriteInteger('Debug', 'Width', Width);
    Settings.WriteInteger('Debug', 'Height', Height);
    Settings.WriteString('Debug', 'SavePath', dlgSaveLog.InitialDir);
    Settings.WriteBool('Debug', 'ViewToolBar', ToolBar.Visible);
    Settings.WriteBool('Debug', 'StayOnTop', FStayOnTop);
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TfmDebug.LoadSettings;
var
  Settings: TRegIniFile;
begin
  Left := (Screen.Width - Width) div 2;
  Top := (Screen.Height - Height) div 2;

  Settings := TRegIniFile.Create('Software\GExperts');
  try
    Left := Settings.ReadInteger('Debug', 'Left', Left);
    Top := Settings.ReadInteger('Debug', 'Top', Top);
    Width := Settings.ReadInteger('Debug', 'Width', Width);
    Height := Settings.ReadInteger('Debug', 'Height', Height);
    ToolBar.Visible := Settings.ReadBool('Debug', 'ViewToolBar', True);
    StayOnTop := Settings.ReadBool('Debug', 'StayOnTop', False);
    dlgSaveLog.InitialDir := Settings.ReadString('Debug', 'SavePath', '');
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TfmDebug.ApplicationMsgHandler(var Msg: TMsg; var Handled: Boolean);
begin
  if (Msg.Message = WM_SYSCOMMAND) and (Msg.wParam = SC_RESTORE) then
    Show;
end;

procedure TfmDebug.WMEndSession(var Message: TMessage);
begin
  FAllowClose := True;
  Close;
  
  inherited;
end;

procedure TfmDebug.WMQueryEndSession(var Message: TMessage);
begin
  FTaskIcon.Active := False;
  FAllowClose := True;
  Close;
  
  inherited;
end;

procedure TfmDebug.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmDebug.lvMessagesDblClick(Sender: TObject);
begin
  actShowItemInDialog.Execute;
end;

procedure TfmDebug.actEditCopySelectedLinesExecute(Sender: TObject);
var
  CopyStrings: TStrings;
  CopyText: PChar;
  i: Integer;
  ListItem: TListItem;
  NewLine: string;
begin
  CopyStrings := TStringList.Create;
  try
    for i := 0 to lvMessages.Items.Count - 1 do
      if lvMessages.Items[i].Selected then
      begin
        ListItem := lvMessages.Items[i];
        NewLine := Format('%d'#9'%s'#9'%s', [ListItem.ImageIndex, ListItem.Caption,
                                             ListItem.SubItems[0]]);
        CopyStrings.Add(NewLine);
      end;

    CopyText := CopyStrings.GetText;
    try
      Clipboard.SetTextBuf(CopyText);
    finally
      StrDispose(CopyText);
    end;
  finally
    FreeAndNil(CopyStrings);
  end;
end;

procedure TfmDebug.actEditClearWindowExecute(Sender: TObject);
begin
  lvMessages.Items.BeginUpdate;
  try
    lvMessages.Items.Clear;
  finally
    lvMessages.Items.EndUpdate;
  end;
  FTaskIcon.Icon := Icon;
  FormResize(Self);
end;

procedure TfmDebug.actEditSaveToFileExecute(Sender: TObject);
resourcestring
  SSaveError = 'Error saving messages: %s';
var
  i: Integer;
  Messages: TStrings;
begin
  if lvMessages.Items.Count > 0 then
  begin
    // Note: this is not part of the IDE, hence we
    // do not do any "current folder" protection.
    if dlgSaveLog.Execute then
    try
      Messages := TStringList.Create;
      try
        for i := 0 to lvMessages.Items.Count - 1 do
        begin
          Messages.Add(
             IntToStr(lvMessages.Items[i].ImageIndex) + #9 +
             lvMessages.Items[i].Caption + #9 +
             lvMessages.Items[i].SubItems[0]);
        end;
        Messages.SaveToFile(dlgSaveLog.FileName);
        dlgSaveLog.InitialDir := ExtractFilePath(dlgSaveLog.FileName);
      finally
        FreeAndNil(Messages);
      end;
    except
      on E: Exception do
        MessageDlg(Format(SSaveError, [E.Message]), mtError, [mbOK], 0);
    end;
  end;
end;

procedure TfmDebug.actFileOptionsExecute(Sender: TObject);
begin
  with TfmDebugOptions.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfmDebug.actFileShutdownExecute(Sender: TObject);
begin
  FAllowClose := True;
  Close;
end;

procedure TfmDebug.actFileHideWindowExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmDebug.actViewShowExecute(Sender: TObject);
begin
  Show;
  BringToFront;
  Application.BringToFront;
end;

constructor TfmDebug.Create(AOwner: TComponent);
resourcestring
  SAlwaysFStayOnTop = '&Always On Top';
begin
  inherited Create(AOwner);
  SetToolbarGradient(Toolbar);
  Application.OnMessage := ApplicationMsgHandler;
  FStayOnTop := False;
  Application.ShowHint := True;

  FTaskIcon := TTrayIcon.Create(Self);
  FTaskIcon.Icon := Icon;
  FTaskIcon.Active := True;
  FTaskIcon.PopupMenu := pmuTaskBar;
  FTaskIcon.ToolTip := Application.Title;
  FTaskIcon.OnDblClick := TrayIconDblClick;

  FAllowClose := False;

  LoadSettings;
end;

destructor TfmDebug.Destroy;
begin
  SaveSettings;

  inherited Destroy;
end;

procedure TfmDebug.actShowItemInDialogExecute(Sender: TObject);
begin
  if lvMessages.Selected <> nil then
    MessageDlg(lvMessages.Selected.Caption, mtInformation, [mbOK], 0);
end;

procedure TfmDebug.actShowItemInDialogUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := (lvMessages.Selected <> nil);
end;

procedure TfmDebug.actFilePauseExecute(Sender: TObject);
begin
  actFilePause.Checked := not actFilePause.Checked;
end;

procedure TfmDebug.ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  actViewStayOnTop.Checked := StayOnTop;
  actViewToolBar.Checked := ToolBar.Visible;
end;

procedure TfmDebug.actViewToolBarExecute(Sender: TObject);
begin
  ToolBar.Visible := not ToolBar.Visible;
end;

procedure TfmDebug.actViewStayOnTopExecute(Sender: TObject);
begin
  StayOnTop := not StayOnTop;
end;

procedure TfmDebug.actEditSelectAllExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to lvMessages.Items.Count - 1 do
    lvMessages.Items[i].Selected := True;
end;

end.
