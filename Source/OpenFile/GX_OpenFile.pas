unit GX_OpenFile;

{$I GX_CondDefine.inc}

interface

uses
  Classes, Controls, Forms, ActnList, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls, GX_GenericUtils, ToolWin, GX_OpenFileConfig,
  Messages;

const
  UM_REFRESHLIST = WM_USER + 746;

type
  TOpenType = (otOpenMenu, otViewUnit, otViewForm, otOpenProject);

  TAvailableFiles = class(TObject)
  private
    FProjectFiles: TStringList;
    FCommonDCUFiles: TStringList;
    FCommonFiles: TStringList;
    FSearchPathFiles: TStringList;
    FOnFindComplete: TThreadMethod;
    FSearchPathThread: TFileFindThread;
    FCommonThread: TFileFindThread;
    FFileMasks: TStringList;
    FCommonFileMask: string;
    FFileExtensions: string;
    FSearchPaths: TStrings;
    FRecursiveDirSearch: Boolean;
    FCommonSearchDone: Boolean;
    FSearchPathDone: Boolean;
    procedure PathSearchComplete;
    procedure CommonSearchComplete;
    procedure GetCommonDCUFiles;
    procedure AddCurrentProjectFiles(PathUnits: TStringList);
  protected
    procedure GetSearchPath(Paths: TStrings); virtual;
  public
    procedure Execute;
    constructor Create;
    destructor Destroy; override;
    property ProjectFiles: TStringList read FProjectFiles write FProjectFiles;
    procedure Terminate;
    property CommonFiles: TStringList read FCommonFiles write FCommonFiles;
    property CommonDCUFiles: TStringList read FCommonDCUFiles write FCommonDCUFiles;
    property SearchPathFiles: TStringList read FSearchPathFiles write FSearchPathFiles;
    property OnFindComplete: TThreadMethod read FOnFindComplete write FOnFindComplete;
    property FileExtension: string read FFileExtensions write FFileExtensions;
    property SearchPaths: TStrings read FSearchPaths write FSearchPaths;
    property RecursiveDirSearch: Boolean read FRecursiveDirSearch write FRecursiveDirSearch;
    procedure HaltThreads;
  end;

  TfmOpenFile = class(TForm)
    pnlUnits: TPanel;
    pcUnits: TPageControl;
    tabSearchPath: TTabSheet;
    pnlSearchPathFooter: TPanel;
    pnlSearchPath: TPanel;
    tabProject: TTabSheet;
    pnlProject: TPanel;
    pnlProjFooter: TPanel;
    tabCommon: TTabSheet;
    pnlCommon: TPanel;
    pnlCommonFooter: TPanel;
    tabFavorite: TTabSheet;
    pnlFavorite: TPanel;
    pnlFavFooter: TPanel;
    btnFavoriteDeleteFromFavorites: TButton;
    pnlAvailableHeader: TPanel;
    lblFilter: TLabel;
    edtFilter: TEdit;
    pnlOKCancel: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    btnCommonAddToFavorites: TButton;
    btnProjectAddToFavorites: TButton;
    btnSearchAddToFavorites: TButton;
    ToolBar: TToolBar;
    tbnMatchFromStart: TToolButton;
    tbnMatchAnywhere: TToolButton;
    tbnSep1: TToolButton;
    tbnHelp: TToolButton;
    lvSearchPath: TListView;
    lvFavorite: TListView;
    lvCommon: TListView;
    lvProjects: TListView;
    lblExtension: TLabel;
    cbxType: TComboBox;
    tabRecent: TTabSheet;
    tbnConfig: TToolButton;
    tbnSep3: TToolButton;
    pnlRecentFooter: TPanel;
    btnClearRecent: TButton;
    chkDefault: TCheckBox;
    tbnOpenFile: TToolButton;
    tbnSep2: TToolButton;
    pnlRecent: TPanel;
    lvRecent: TListView;
    btnFavoriteAddToFavorites: TButton;
    OpenDialog: TOpenDialog;
    btnRecentAddToFavorites: TButton;
    ActionList: TActionList;
    actAddToFavorites: TAction;
    actMatchPrefix: TAction;
    actMatchAnywhere: TAction;
    actConfig: TAction;
    actHelp: TAction;
    actOpenFile: TAction;
    actFavAddToFavorites: TAction;
    actFavDeleteFromFavorites: TAction;
    actClearRecentList: TAction;
    tmrFilter: TTimer;
    procedure tmrFilterTimer(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtFilterChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure actMatchAnywhereExecute(Sender: TObject);
    procedure actMatchPrefixExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FileListDoubleClick(Sender: TObject);
    procedure pcUnitsChange(Sender: TObject);
    procedure cbxTypeChange(Sender: TObject);
    procedure actConfigExecute(Sender: TObject);
    procedure tabSearchPathShow(Sender: TObject);
    procedure tabProjectShow(Sender: TObject);
    procedure tabCommonShow(Sender: TObject);
    procedure tabFavoriteShow(Sender: TObject);
    procedure tabRecentShow(Sender: TObject);
    procedure actOpenFileExecute(Sender: TObject);
    procedure actAddToFavoritesExecute(Sender: TObject);
    procedure actFavAddToFavoritesExecute(Sender: TObject);
    procedure actFavDeleteFromFavoritesExecute(Sender: TObject);
    procedure actClearRecentListExecute(Sender: TObject);
    procedure pcUnitsResize(Sender: TObject);
  private
    FAvailableFiles: TAvailableFiles;
    FInitialFileType: string;
    FCurrentListView: TListView;
    FCurrentFilePaths: TStringList;
    procedure SearchPathReady;
    procedure FilterVisibleUnits;
    procedure SelectMatchingItemInList;
    procedure DeleteFromFavorites(Item: TListItem);
    function GetActivePageIndex: Integer;
    procedure SetActivePageIndex(Value: Integer);
    procedure DoOpenFile(FileName: string);
    function CurrentFileType: TFileType;
    procedure UMRefreshList(var Msg: TMessage); message UM_REFRESHLIST;
    procedure AddFavoriteFile(FileName: string);
    function MakeFileName(Item: TListItem): string;
    function GetMatchAnywhere: Boolean;
    procedure SetMatchAnywhere(Value: Boolean);
    function Settings: TOpenFileSettings;
    function FileTypes: TFileTypes;
    function FileType(Index: Integer): TFileType;
    procedure InitializeFromSettings;
    procedure InitializeFileTypes(const SelectType: string);
    procedure LoadSettings;
    procedure SaveSettings;
    function ConfigurationKey: string;
    procedure CopyColumns(Source: TListView);
    procedure ResizeListViewColumns;
  public
    property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;
    property AvailableFiles: TAvailableFiles read FAvailableFiles write FAvailableFiles;
    property InitialFileType: string read FInitialFileType write FInitialFileType;
    property MatchAnywhere: Boolean read GetMatchAnywhere write SetMatchAnywhere;
  end;

implementation

{$R *.dfm}

uses
  SysUtils, Menus, Graphics, Windows, ToolsAPI,
  GX_IdeUtils, GX_SharedImages, GX_Experts, GX_ConfigurationInfo, GX_OtaUtils,
  GX_GxUtils;

resourcestring
  SOpenUnitMenuName = 'OpenFile';

const
  ViewUnitAction = 'ViewUnitCommand';
  ViewFormAction = 'ViewFormCommand';
  OpenProjectAction = 'FileOpenProjectCommand';

type
  TOpenFileNotifier = class(TBaseIdeNotifier)
  public
    procedure FileNotification(NotifyCode: TOTAFileNotification;
      const FileName: string; var Cancel: Boolean); override;
  end;

  TOpenFileExpert = class(TGX_Expert)
  private
    FOpenFileIDEOnClick: TNotifyEvent;
    FOpenFormIDEOnClick: TNotifyEvent;
    FOpenProjectIDEOnClick: TNotifyEvent;
    FNotifier: TOpenFileNotifier;
    procedure OpenExpert(const OpenFileType: TOpenType);
    procedure OpenFile(Sender: TObject);
    procedure OpenForm(Sender: TObject);
    procedure OpenProject(Sender: TObject);
    procedure HijackIDEActions;
    procedure HijackIDEAction(const ActionName: string; var OriginalIDEAction: TNotifyEvent; NewIDEAction: TNotifyEvent);
    procedure ResetIDEAction(const ActionName: string; IDEHandler: TNotifyEvent);
  public
    Settings: TOpenFileSettings;
    constructor Create; override;
    destructor Destroy; override;
    function HasConfigOptions: Boolean; override;
    function HasMenuItem: Boolean; override;
    procedure InternalLoadSettings(Settings: TGExpertsSettings); override;
    procedure InternalSaveSettings(Settings: TGExpertsSettings); override;
    procedure Click(Sender: TObject); override;
    function GetActionCaption: string; override;
    class function GetName: string; override;
    procedure Configure; override;
    procedure AfterIDEInitialized; override;
  end;

var
  OpenFileExpert: TOpenFileExpert;

{ TOpenFileExpert }

procedure TOpenFileExpert.OpenExpert(const OpenFileType: TOpenType);
var
  Form: TfmOpenFile;
begin
  Form := TfmOpenFile.Create(nil);
  try
    Form.ActivePageIndex := Settings.LastTabIndex;
    Form.Caption := StripHotkey(GetActionCaption);
    Form.LoadSettings;

    case OpenFileType of
      otOpenMenu: Form.InitialFileType := Settings.DefaultFileType;
      otOpenProject: Form.InitialFileType := Settings.IDEOverride.OpenProjectDefaultType;
      otViewUnit: Form.InitialFileType := Settings.IDEOverride.OpenUnitDefaultType;
      otViewForm: Form.InitialFileType := Settings.IDEOverride.OpenFormDefaultType;
    end;
    SetFormIcon(Form);
    if (Form.ShowModal = mrOk) or (Form.chkDefault.Checked) then begin
      SaveSettings;
      Form.SaveSettings;
    end;
  finally
    FreeAndNil(Form);
  end;
end;

constructor TOpenFileExpert.Create;
begin
  inherited;
  Settings := TOpenFileSettings.Create;
  Settings.ConfigurationKey := ConfigurationKey;
  OpenFileExpert := Self;
  FNotifier := TOpenFileNotifier.Create;
  FNotifier.AddNotifierToIDE;
end;

destructor TOpenFileExpert.Destroy;
begin
  ResetIDEAction(ViewUnitAction, FOpenFileIDEOnClick);
  ResetIDEAction(ViewFormAction, FOpenFormIDEOnClick);
  ResetIDEAction(OpenProjectAction, FOpenProjectIDEOnClick);
  FNotifier.RemoveNotifierFromIDE;
  FNotifier := nil; // Free is done by the IDE for us
  FreeAndNil(Settings);
  OpenFileExpert := nil;
  inherited;
end;

function TOpenFileExpert.HasConfigOptions: Boolean;
begin
  Result := True;
end;

function TOpenFileExpert.HasMenuItem: Boolean;
begin
  Result := True;
end;

procedure TOpenFileExpert.InternalLoadSettings(Settings: TGExpertsSettings);
begin
  inherited;
  Self.Settings.LoadFromRegistry(Settings);
end;

procedure TOpenFileExpert.InternalSaveSettings(Settings: TGExpertsSettings);
begin
  inherited;
  Self.Settings.SaveToRegistry(Settings);
  HijackIDEActions;
end;

procedure TOpenFileExpert.HijackIDEAction(const ActionName: string; var OriginalIDEAction: TNotifyEvent; NewIDEAction: TNotifyEvent);
var
  Action: TContainedAction;
begin
  Action := GxOtaGetIdeActionByName(ActionName);
  if (Action <> nil) and (Action is TCustomAction) then
  begin
    OriginalIDEAction := (Action as TCustomAction).OnExecute;
    (Action as TCustomAction).OnExecute := NewIDEAction;
  end;
end;

procedure TOpenFileExpert.Click(Sender: TObject);
begin
  OpenExpert(otOpenMenu);
end;

procedure TOpenFileExpert.OpenFile(Sender: TObject);
begin
  OpenExpert(otViewUnit);
end;

procedure TOpenFileExpert.OpenForm(Sender: TObject);
begin
  OpenExpert(otViewForm);
end;

function TOpenFileExpert.GetActionCaption: string;
resourcestring
  SViewUnitMenuCaption = 'Open File';
begin
  Result := SViewUnitMenuCaption;
end;

class function TOpenFileExpert.GetName: string;
begin
  Result := SOpenUnitMenuName;
end;

procedure TOpenFileExpert.OpenProject(Sender: TObject);
begin
  OpenExpert(otOpenProject);
end;

procedure TOpenFileExpert.Configure;
begin
  TfmOpenFileConfig.ExecuteWithSettings(Settings);
end;

procedure TOpenFileExpert.HijackIDEActions;
begin
  if Self.Settings.IDEOverride.OverrideOpenUnit then
  begin
    if not Assigned(FOpenFileIDEOnClick) then
      HijackIDEAction(ViewUnitAction, FOpenFileIDEOnClick, OpenFile);
  end
  else if Assigned(FOpenFileIDEOnClick) then
    ResetIDEAction(ViewUnitAction, FOpenFileIDEOnClick);

  if Self.Settings.IDEOverride.OverrideOpenForm then
  begin
    if not Assigned(FOpenFormIDEOnClick) then
      HijackIDEAction(ViewFormAction, FOpenFormIDEOnClick, OpenForm);
  end
  else if Assigned(FOpenFormIDEOnClick) then
    ResetIDEAction(ViewFormAction, FOpenFormIDEOnClick);

  if Self.Settings.IDEOverride.OverrideOpenProject then
  begin
    if not Assigned(FOpenProjectIDEOnClick) then
      HijackIDEAction(OpenProjectAction, FOpenProjectIDEOnClick, OpenProject);
  end
  else if Assigned(FOpenProjectIDEOnClick) then
    ResetIDEAction(ViewFormAction, FOpenProjectIDEOnClick);
end;

procedure TOpenFileExpert.AfterIDEInitialized;
begin
  inherited;
  HijackIDEActions;
end;

procedure TOpenFileExpert.ResetIDEAction(const ActionName: string; IDEHandler: TNotifyEvent);
var
  Action: TContainedAction;
begin
  if not Assigned(IDEHandler) then
    Exit;
  Action := GxOtaGetIdeActionByName(ActionName);
  if Assigned(Action) then
    Action.OnExecute := IDEHandler;
end;

{ TAvailableFiles }

constructor TAvailableFiles.Create;
begin
  inherited;
  FFileMasks := TStringList.Create;
  FCommonFiles := TStringList.Create;
  FCommonDCUFiles := TStringList.Create;
  FProjectFiles := TStringList.Create;
  FSearchPathFiles := TStringList.Create;
end;

destructor TAvailableFiles.Destroy;
begin
  OnFindComplete := nil;
  HaltThreads;
  FreeAndNil(FFileMasks);
  FreeAndNil(FCommonFiles);
  FreeAndNil(FCommonDCUFiles);
  FreeAndNil(FProjectFiles);
  FreeAndNil(FSearchPathFiles);
  FreeAndNil(FSearchPathThread);
  FreeAndNil(FCommonThread);
  inherited;
end;

procedure TAvailableFiles.Execute;
var
  PathsToUse: TStringList;
begin
  FCommonFiles.Clear;
  FCommonDCUFiles.Clear;
  FProjectFiles.Clear;
  FSearchPathFiles.Clear;
  FSearchPathDone := False;
  FCommonSearchDone := False;

  FreeAndNil(FSearchPathThread);
  FSearchPathThread := TFileFindThread.Create;

  // This will allow semi-colon separated lists at the user GUI level
  // D5 has no way to separate ; using TStrings.
  FSearchPathThread.FileMasks.CommaText := StringReplace(FFileExtensions, ';', ',', [rfReplaceAll]);

  if FRecursiveDirSearch then
    PathsToUse := FSearchPathThread.RecursiveSearchDirs
  else
    PathsToUse := FSearchPathThread.SearchDirs;

  GetSearchPath(PathsToUse);
  AppendStrings(PathsToUse, FSearchPaths);
  FSearchPathThread.OnFindComplete := PathSearchComplete;
  FSearchPathThread.StartFind;

  FreeAndNil(FCommonThread);
  FCommonThread := TFileFindThread.Create;
  FCOmmonThread.RecursiveSearchDirs.Add(ExtractFilePath(GetIdeRootDirectory) + AddSlash('Source'));
  FCommonThread.FileMasks.CommaText := '*.pas,*.cpp,*.cs,*.inc,*.dfm';
  FCommonThread.OnFindComplete := CommonSearchComplete;
  FCommonThread.StartFind;

  FCommonFileMask := FFileExtensions;
  if False then // Not needed yet (only needed for uses clause manager?)
    GetCommonDCUFiles;
  AddCurrentProjectFiles(FProjectFiles);
end;

procedure TAvailableFiles.PathSearchComplete;
var
  PathFiles: TStringList;
  PathUnits: TStringList;
  i: Integer;
begin
  PathUnits := nil;
  PathFiles := TStringList.Create;
  try
    FSearchPathThread.LockResults;
    try
      PathFiles.Assign(FSearchPathThread.Results);
    finally
      FSearchPathThread.ReleaseResults;
    end;
    PathUnits := TStringList.Create;
    PathUnits.Sorted := True;
    PathUnits.Duplicates := dupIgnore;
    for i := 0 to PathFiles.Count - 1 do
      PathUnits.Add(ExpandFileName(PathFiles[i]));

    AddCurrentProjectFiles(PathUnits);
    FSearchPathFiles.Assign(PathUnits);
    FSearchPathDone := True;
  finally
    FreeAndNil(PathFiles);
    FreeAndNil(PathUnits);
  end;
  if FCommonSearchDone and Assigned(FOnFindComplete) then
    FOnFindComplete;
end;

procedure TAvailableFiles.CommonSearchComplete;
begin
  FCommonThread.LockResults;
  try
    CommonFiles.Assign(FCommonThread.Results);
    FCommonSearchDone := True;
  finally
    FCommonThread.ReleaseResults;
  end;
  if FSearchPathDone and Assigned(FOnFindComplete) then
    FOnFindComplete;
end;

procedure TAvailableFiles.GetCommonDCUFiles;
var
  Found: Integer;
  SearchRec: TSearchRec;
  FileSpec: string;
begin
  //TODO 3 -cFeature -oAnyone: Make this threaded before using it
  FileSpec := GetIdeRootDirectory + AddSlash('lib') + '*.dcu';
  Found := SysUtils.FindFirst(FileSpec, faAnyFile, SearchRec);
  try
    while Found = 0 do
    begin
      if not ((SearchRec.Attr and faDirectory) = faDirectory) then
        FCommonDCUFiles.Add(ExtractPureFileName(SearchRec.Name));
      Found := SysUtils.FindNext(SearchRec);
    end;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

procedure TAvailableFiles.AddCurrentProjectFiles(PathUnits: TStringList);
var
  ExtensionIndex: Integer;
  Project: IOTAProject;
  i: Integer;
  CurrentProjectFiles, FileExtensions: TStringList;
  FileName: string;
begin
  Project := GxOtaGetCurrentProject;
  if Assigned(Project) then
  begin
    FileExtensions := nil;
    CurrentProjectFiles := TStringList.Create;
    try
      FileExtensions := TStringList.Create;
      // This will allow semi-colon separated lists at the user GUI level
      // D5 has no way to separate ; into TStrings.
      FileExtensions.CommaText := StringReplace(FFileExtensions, ';', ',', [rfReplaceAll]);
      GxOtaGetProjectFileNames(Project, CurrentProjectFiles);
      for i := 0 to CurrentProjectFiles.Count - 1 do
        for ExtensionIndex := 0 to FileExtensions.Count - 1 do
        begin
          FileName := ChangeFileExt(CurrentProjectFiles[i], ExtractFileExt(FileExtensions[ExtensionIndex]));
          if FileExists(FileName) then
            PathUnits.Add(ExpandFileName(FileName));
        end;
    finally
      FreeAndNil(CurrentProjectFiles);
      FreeAndNil(FileExtensions);
    end;
  end;
end;

procedure TAvailableFiles.GetSearchPath(Paths: TStrings);
begin
  GxOtaGetEffectiveLibraryPath(Paths);
end;

procedure TAvailableFiles.HaltThreads;

  procedure StopThread(Thread: TFileFindThread);
  begin
    if Assigned(Thread) then
    begin
      Thread.OnFindComplete := nil;
      Thread.Terminate;
      Thread.WaitFor;
    end;
  end;

var
  Cursor: IInterface;
begin
  Cursor := TempHourGlassCursor;
  StopThread(FSearchPathThread);
  StopThread(FCommonThread);
end;

{ TOpenFileNotifier }

procedure TOpenFileNotifier.FileNotification(NotifyCode: TOTAFileNotification;
  const FileName: string; var Cancel: Boolean);
var
  i: Integer;
  FType: TFileType;
  FileExt: string;
  FilePath: string;
begin
  case NotifyCode of
    ofnFileOpened:
      begin
        try
          FileExt := LowerCase(ExtractFileExt(FileName));
          FilePath := ExtractFilePath(FileName);
          if StrBeginsWith('.', FileExt) then
            FileExt := Copy(FileExt, 2, Length(FileExt));
          if FileExt = '' then // Unknown files
            Exit;
          if FilePath = '' then // Temporary unsaved files, SQL in the editor, etc.
            Exit;
          for i := 0 to OpenFileExpert.Settings.FileTypes.Count - 1 do
          begin
            FType := TFileType(OpenFileExpert.Settings.FileTypes.Items[i]);
            if StrContains('*.' + FileExt, FType.Extensions, False) then
              FType.RecentFiles.Add(FileName);
          end;
        except
          on E: Exception do // Nothing should keep the file from opening
            MessageDlg('Error storing value in GExperts Open File MRU list.' + sLineBreak + E.Message, mtError, [mbOK], 0);
        end;
      end;
  end;
end;

{ TfmOpenFile }

procedure TfmOpenFile.FormCreate(Sender: TObject);
begin
  SetToolbarGradient(ToolBar);
  SetDefaultFont(Self);
  lvSearchPath.Color := clBtnFace;
  lvSearchPath.Enabled := False;
  lvCommon.Color := clBtnFace;
  lvCommon.Enabled := False;
  FAvailableFiles := TAvailableFiles.Create;
  AvailableFiles.OnFindComplete := SearchPathReady;
  lvSearchPath.DoubleBuffered := True;
  lvFavorite.DoubleBuffered := True;
  lvCommon.DoubleBuffered := True;
  lvProjects.DoubleBuffered := True;
  lvRecent.DoubleBuffered := True;
  CopyColumns(lvSearchPath);
end;

procedure TfmOpenFile.SearchPathReady;
begin
  FilterVisibleUnits;
  lvSearchPath.Color := clWindow;
  lvSearchPath.Enabled := True;
  lvCommon.Color := clWindow;
  lvCommon.Enabled := True;
end;

procedure TfmOpenFile.FilterVisibleUnits;

  procedure AddListItem(FileListView: TListView; UnitFileName: string);
  var
    ListItem: TListItem;
  begin
    ListItem := FileListView.Items.Add;
    ListItem.Caption := ExtractPureFileName(UnitFileName);
    ListItem.SubItems.Add(RemoveSlash(ExtractFilePath(UnitFileName)));
    ListItem.SubItems.Add(LowerCase(ExtractFileExt(UnitFileName)));
  end;

var
  SearchValue: string;
  i: Integer;
begin
  pcUnits.ActivePage.OnShow(pcUnits.ActivePage);
  FCurrentListView.Items.BeginUpdate;
  try
    FCurrentListView.Items.Clear;
    FCurrentListView.SortType := stNone;
    for i := 0 to FCurrentFilePaths.Count - 1 do
    begin
      SearchValue := ExtractPureFileName(FCurrentFilePaths[i]);

      if Length(edtFilter.Text) = 0 then
        AddListItem(FCurrentListView, FCurrentFilePaths[i])
      else
        if tbnMatchAnywhere.Down then
        begin
          if StrContains(edtFilter.Text, SearchValue, False) then
            AddListItem(FCurrentListView, FCurrentFilePaths[i]);
        end
        else
          if StrBeginsWith(edtFilter.Text, SearchValue, False) then
            AddListItem(FCurrentListView, FCurrentFilePaths[i]);
    end;
    FCurrentListView.SortType := stText;
    SelectMatchingItemInList;
  finally
    FCurrentListView.Items.EndUpdate;
  end;
  ResizeListViewColumns;
end;

procedure TfmOpenFile.SelectMatchingItemInList;
var
  CurrentListView: TListView;
  i, SelIndex: Integer;
  FilterText: string;
  ListItem: TListItem;
begin
  CurrentListView := FCurrentListView;
  if CurrentListView.Items.Count > 0 then
  begin
    SelIndex := 0;
    FilterText := edtFilter.Text;
    for i := 0 to CurrentListView.Items.Count - 1 do
    begin
      ListItem := CurrentListView.Items[i];
      if StrBeginsWith(FilterText, ListItem.Caption, False) then
      begin
        SelIndex := i;
        Break;
      end;
    end;
    ListItem := CurrentListView.Items[SelIndex];
    ListItem.Selected := True;
    CurrentListView.ItemFocused := ListItem;
    ListItem.MakeVisible(False);
  end;
end;

procedure TfmOpenFile.edtFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ListBox: TListView;
begin
  if (Key in [VK_DOWN, VK_UP, VK_NEXT, VK_PRIOR]) then
  begin
    ListBox := FCurrentListView;
    if ListBox.Items.Count > 1 then
      ListBox.Perform(WM_KEYDOWN, Key, 0)
    else
      if ListBox.Items.Count = 1 then
        ListBox.Items[0].Selected := True;
    Key := 0;
  end;
end;

procedure TfmOpenFile.edtFilterChange(Sender: TObject);
begin
  tmrFilter.Enabled := False;
  tmrFilter.Enabled := True;
end;

procedure TfmOpenFile.tmrFilterTimer(Sender: TObject);
begin
  FilterVisibleUnits;
  tmrFilter.Enabled := False;
end; 

procedure TfmOpenFile.btnOKClick(Sender: TObject);
var
  i: Integer;
  Src: TListView;
  FileName: string;
begin
  FAvailableFiles.Terminate;
  Src := FCurrentListView;
  if Src.SelCount > 0 then
    for i := 0 to Src.Items.Count - 1 do
      if Src.Items[i].Selected then
      begin
        FileName := MakeFileName(Src.Items[i]);
        DoOpenFile(FileName);
        // TODO: Add support for focusing the editor to the last file
        //if i = Src.Items.Count - 1 then
        // Focus last editor/form
      end;
end;

procedure TfmOpenFile.DeleteFromFavorites(Item: TListItem);
begin
  DeleteStringFromList(CurrentFileType.Favorites, MakeFileName(Item));
  Item.Delete;
end;

procedure TfmOpenFile.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FAvailableFiles);
end;

procedure TfmOpenFile.actMatchAnywhereExecute(Sender: TObject);
begin
  FilterVisibleUnits;
end;

procedure TAvailableFiles.Terminate;
begin
  FSearchPathThread.Terminate;
  FCommonThread.Terminate;
end;

procedure TfmOpenFile.actMatchPrefixExecute(Sender: TObject);
begin
  FilterVisibleUnits;
end;

function TfmOpenFile.GetMatchAnywhere: Boolean;
begin
  Result := tbnMatchAnywhere.Down;
end;

procedure TfmOpenFile.SetMatchAnywhere(Value: Boolean);
begin
  tbnMatchAnywhere.Down := Value;
  tbnMatchFromStart.Down := not Value;
end;

function TfmOpenFile.GetActivePageIndex: Integer;
begin
  Result := pcUnits.ActivePageIndex;
end;

procedure TfmOpenFile.SetActivePageIndex(Value: Integer);
begin
  if (Value >= 0) and (Value < pcUnits.PageCount) then
    pcUnits.ActivePageIndex := Value;
end;

procedure TfmOpenFile.FormShow(Sender: TObject);
begin
  ResizeListViewColumns;
  tabSearchPathShow(tabSearchPath);
  InitializeFileTypes(FInitialFileType);
  PostMessage(Handle, UM_REFRESHLIST, 0, 0);
end;

procedure TfmOpenFile.FileListDoubleClick(Sender: TObject);
begin
  btnOK.Click;
end;

procedure TfmOpenFile.pcUnitsChange(Sender: TObject);
begin
  Settings.LastTabIndex := pcUnits.ActivePageIndex;
  FilterVisibleUnits;
  PostMessage(Handle, UM_REFRESHLIST, 0, 0);
end;

procedure TfmOpenFile.pcUnitsResize(Sender: TObject);
begin
  ResizeListViewColumns;
end;

procedure TfmOpenFile.ResizeListViewColumns;
begin
  Exit; // This is done using Column.AutoSize for now
  if Assigned(FCurrentListView) then
    ListViewResizeColumn(FCurrentListView, 1);
end;

procedure TfmOpenFile.cbxTypeChange(Sender: TObject);
begin
  AvailableFiles.FileExtension := CurrentFileType.Extensions;
  AvailableFiles.SearchPaths := CurrentFileType.Paths;
  if not CurrentFileType.CustomDirectories then
    AvailableFiles.SearchPaths.Clear;
  AvailableFiles.RecursiveDirSearch := CurrentFileType.Recursive;
  AvailableFiles.Execute;
  FilterVisibleUnits;
end;

procedure TfmOpenFile.actConfigExecute(Sender: TObject);
begin
  if TfmOpenFileConfig.ExecuteWithSettings(Settings) then
    InitializeFromSettings;
end;

procedure TfmOpenFile.tabSearchPathShow(Sender: TObject);
begin
  FCurrentListView := lvSearchPath;
  FCurrentFilePaths := AvailableFiles.SearchPathFiles;
end;

procedure TfmOpenFile.tabProjectShow(Sender: TObject);
begin
  FCurrentListView := lvProjects;
  FCurrentFilePaths := AvailableFiles.ProjectFiles;
end;

procedure TfmOpenFile.tabCommonShow(Sender: TObject);
begin
  FCurrentListView := lvCommon;
  FCurrentFilePaths := AvailableFiles.CommonFiles;
end;

procedure TfmOpenFile.tabFavoriteShow(Sender: TObject);
begin
  FCurrentListView := lvFavorite;
  if cbxType.ItemIndex = -1 then
    FCurrentFilePaths := nil
  else
    FCurrentFilePaths := CurrentFileType.Favorites;
end;

procedure TfmOpenFile.tabRecentShow(Sender: TObject);
begin
  FCurrentListView := lvRecent;
  if cbxType.ItemIndex = -1 then
    FCurrentFilePaths := nil
  else
    FCurrentFilePaths := CurrentFileType.RecentFiles;
end;

procedure TfmOpenFile.actOpenFileExecute(Sender: TObject);
var
  i: Integer;
  Dlg: TOpenDialog;
  FType: TFileType;
begin
  Dlg := TOpenDialog.Create(nil);
  try
    for i := 0 to cbxType.Items.Count - 1 do
    begin
      FType := FileType(i);
      Dlg.Filter := Dlg.Filter + FType.FileTypeName + ' (' + FType.Extensions + ')|' + FType.Extensions + '|';
    end;
    Dlg.Filter := Dlg.Filter + 'All Files(*.*)|*.*';
    Dlg.FilterIndex := cbxType.ItemIndex + 1;
    if Dlg.Execute then
      DoOpenFile(Dlg.FileName);
  finally
    FreeAndNil(Dlg);
  end;
end;

procedure TfmOpenFile.DoOpenFile(FileName: string);
begin
  Self.Hide;
  GxOtaOpenFileOrForm(FileName);
  ModalResult := mrOK;
end;

function TfmOpenFile.ConfigurationKey: string;
begin
  Result := 'OpenFile';
end;

procedure TfmOpenFile.CopyColumns(Source: TListView);
begin
  Assert(Assigned(Source));
  if Source <> lvSearchPath then
    lvSearchPath.Columns.Assign(Source.Columns);
  if Source <> lvFavorite then
    lvFavorite.Columns.Assign(Source.Columns);
  if Source <> lvCommon then
    lvCommon.Columns.Assign(Source.Columns);
  if Source <> lvProjects then
    lvProjects.Columns.Assign(Source.Columns);
  if Source <> lvRecent then
    lvRecent.Columns.Assign(Source.Columns);
end;

function TfmOpenFile.CurrentFileType: TFileType;
begin
  Result := nil;
  if cbxType.ItemIndex >= 0 then
    Result := FileType(cbxType.ItemIndex);
end;

// This is a hack to force the column 0 headers on hidden tabs to repaint
procedure TfmOpenFile.UMRefreshList(var Msg: TMessage);
begin
  if Assigned(FCurrentListView) then
    FCurrentListView.Width := FCurrentListView.Width - 1;
end;

procedure TfmOpenFile.AddFavoriteFile(FileName: string);
begin
  if Trim(FileName) <> '' then
    EnsureStringInList(CurrentFileType.Favorites, FileName);
end;

procedure TfmOpenFile.actHelpExecute(Sender: TObject);
begin
  GxContextHelp(Self, 46);
end;

function TfmOpenFile.MakeFileName(Item: TListItem): string;
begin
  Assert(Assigned(Item));
  Result := AddSlash(Item.SubItems[0]) + Item.Caption + Item.SubItems[1];
end;

procedure TfmOpenFile.actAddToFavoritesExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to FCurrentListView.Items.Count - 1 do
    if FCurrentListView.Items[i].Selected then
      AddFavoriteFile(MakeFileName(FCurrentListView.Items[i]));
end;

procedure TfmOpenFile.actFavAddToFavoritesExecute(Sender: TObject);
var
  i: Integer;
begin
  if OpenDialog.Execute then
  begin
    for i := 0 to OpenDialog.Files.Count - 1 do
      AddFavoriteFile(OpenDialog.Files[i]);
  end;
  FilterVisibleUnits;
end;

procedure TfmOpenFile.actFavDeleteFromFavoritesExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := lvFavorite.Items.Count - 1 downto 0 do
    if lvFavorite.Items[i].Selected then
      DeleteFromFavorites(lvFavorite.Items[i]);
end;

procedure TfmOpenFile.actClearRecentListExecute(Sender: TObject);
begin
  CurrentFileType.RecentFiles.Clear;
  lvRecent.Items.Clear;
end;

function TfmOpenFile.Settings: TOpenFileSettings;
begin
  Assert(Assigned(OpenFileExpert));
  Assert(Assigned(OpenFileExpert.Settings));
  Result := OpenFileExpert.Settings;
end;

procedure TfmOpenFile.InitializeFromSettings;
var
  SelectedFileType: string;
begin
  SelectedFileType := '';
  if cbxType.ItemIndex > -1 then
    SelectedFileType := cbxType.Items[cbxType.ItemIndex];
  InitializeFileTypes(SelectedFileType);
  MatchAnywhere := Settings.MatchAnywhere;
end;

procedure TfmOpenFile.LoadSettings;
var
  Settings: TGExpertsSettings;
begin
  Settings := TGExpertsSettings.Create;
  try
    Settings.LoadForm(Self, ConfigurationKey + '\OpenFileForm');
  finally
    FreeAndNil(Settings);
  end;
  EnsureFormVisible(Self);
end;

procedure TfmOpenFile.SaveSettings;
var
  Settings: TGExpertsSettings;
begin
  Settings := TGExpertsSettings.Create;
  try
    Settings.SaveForm(Self, ConfigurationKey + '\OpenFileForm');
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TfmOpenFile.InitializeFileTypes(const SelectType: string);
var
  TypeIndex: Integer;
  i: Integer;
begin
  cbxType.Items.Clear;
  for i := 0 to Settings.FileTypes.Count - 1 do
    cbxType.Items.Add(TFileType(Settings.FileTypes.Items[i]).FileTypeName);

  TypeIndex := cbxType.Items.IndexOf(SelectType);
  if TypeIndex > -1 then
    cbxType.ItemIndex := TypeIndex
  else if cbxType.Items.Count > 0 then
    cbxType.ItemIndex := 0;
  cbxType.OnChange(cbxType);
end;

function TfmOpenFile.FileTypes: TFileTypes;
begin
  Assert(Assigned(Settings.FileTypes));
  Result := Settings.FileTypes;
end;

function TfmOpenFile.FileType(Index: Integer): TFileType;
begin
  Result := FileTypes.Items[Index];
end;

initialization
  RegisterGX_Expert(TOpenFileExpert);

end.

