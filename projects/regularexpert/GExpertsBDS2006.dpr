library GExpertsBDS2006;

{$R '..\..\gximages\GXIcons.res' '..\..\gximages\GXIcons.rc'}
{$R *.res}
{$E dll}

uses
  GX_About in '..\..\gxsource\Framework\GX_About.pas' {fmAbout},
  GX_ActionBroker in '..\..\gxsource\Framework\GX_ActionBroker.pas',
  GX_Actions in '..\..\gxsource\Framework\GX_Actions.pas',
  GX_AsciiChart in '..\..\gxsource\Experts\GX_AsciiChart.pas' {fmAsciiChart},
  GX_Backup in '..\..\gxsource\BackupProject\GX_Backup.pas' {fmBackup},
  GX_BackupConfig in '..\..\gxsource\BackupProject\GX_BackupConfig.pas' {fmBackupConfig},
  GX_BackupOptions in '..\..\gxsource\BackupProject\GX_BackupOptions.pas' {fmBackupOptions},
  GX_ClassBrowser in '..\..\gxsource\ClassBrowser\GX_ClassBrowser.pas' {fmClassBrowser},
  GX_ClassHacks in '..\..\gxsource\Framework\GX_ClassHacks.pas',
  GX_ClassIdentify in '..\..\gxsource\ClassBrowser\GX_ClassIdentify.pas' {fmClassIdentify},
  GX_ClassMgr in '..\..\gxsource\Framework\GX_ClassMgr.pas',
  GX_ClassOptions in '..\..\gxsource\ClassBrowser\GX_ClassOptions.pas' {fmClassOptions},
  GX_ClassParsing in '..\..\gxsource\ClassBrowser\GX_ClassParsing.pas' {fmClassParsing},
  GX_ClassProp in '..\..\gxsource\ClassBrowser\GX_ClassProp.pas' {fmClassProp},
  GX_ClassReport in '..\..\gxsource\ClassBrowser\GX_ClassReport.pas' {fmClassReport},
  GX_CleanDirectories in '..\..\gxsource\Experts\GX_CleanDirectories.pas' {fmCleanDirectories},
  GX_ClipboardHistory in '..\..\gxsource\ClipboardHistory\GX_ClipboardHistory.pas' {fmClipboardHistory},
  GX_ClipboardOptions in '..\..\gxsource\ClipboardHistory\GX_ClipboardOptions.pas' {fmClipboardOptions},
  GX_CodeLib in '..\..\gxsource\CodeLibrarian\GX_CodeLib.pas' {fmCodeLib},
  GX_CodeOpt in '..\..\gxsource\CodeLibrarian\GX_CodeOpt.pas' {fmCodeOptions},
  GX_CodeSrch in '..\..\gxsource\CodeLibrarian\GX_CodeSrch.pas' {fmCodeSearch},
  GX_ComponentGrid in '..\..\gxsource\Experts\GX_ComponentGrid.pas' {fmComponentGrid},
  GX_CompRename in '..\..\gxsource\RenameComponents\GX_CompRename.pas' {fmCompRename},
  GX_CompRenameAdvanced in '..\..\gxsource\RenameComponents\GX_CompRenameAdvanced.pas' {fmCompRenameAdvanced},
  GX_CompRenameConfig in '..\..\gxsource\RenameComponents\GX_CompRenameConfig.pas' {fmCompRenameConfig},
  GX_CompsToCode in '..\..\gxsource\Experts\GX_CompsToCode.pas' {fmCompsToCode},
  GX_ConfigurationInfo in '..\..\gxsource\Framework\GX_ConfigurationInfo.pas',
  GX_Configure in '..\..\gxsource\Framework\GX_Configure.pas' {fmConfiguration},
  GX_Consts in '..\..\gxsource\Framework\GX_Consts.pas',
  GX_CopyComponentNames in '..\..\gxsource\Experts\GX_CopyComponentNames.pas',
  GX_DbugIntf in '..\..\gxsource\Framework\GX_DbugIntf.pas',
  GX_DesignerMenu in '..\..\gxsource\Framework\GX_DesignerMenu.pas',
  GX_eAlign in '..\..\gxsource\Editor\GX_eAlign.pas' {fmAlign},
  GX_eAlignOptions in '..\..\gxsource\Editor\GX_eAlignOptions.pas' {fmAlignOptions},
  GX_eChangeCase in '..\..\gxsource\Editor\GX_eChangeCase.pas' {fmChangeCase},
  GX_eComment in '..\..\gxsource\Editor\GX_eComment.pas' {fmCommentConfig},
  GX_eDate in '..\..\gxsource\Editor\GX_eDate.pas' {fmDateFormat},
  GX_EditorChangeServices in '..\..\gxsource\Framework\GX_EditorChangeServices.pas',
  GX_EditorEnhancements in '..\..\gxsource\Framework\GX_EditorEnhancements.pas',
  GX_EditorExpert in '..\..\gxsource\Editor\GX_EditorExpert.pas',
  GX_EditorExpertManager in '..\..\gxsource\Editor\GX_EditorExpertManager.pas',
  GX_EditorFormServices in '..\..\gxsource\Framework\GX_EditorFormServices.pas',
  GX_EditorShortcut in '..\..\gxsource\Framework\GX_EditorShortcut.pas' {fmEditorShortcut},
  GX_EditReader in '..\..\gxsource\Framework\GX_EditReader.pas',
  GX_eFindDelimiter in '..\..\gxsource\Editor\GX_eFindDelimiter.pas',
  GX_ePrevNextIdentifier in '..\..\gxsource\Editor\GX_ePrevNextIdentifier.pas',
  GX_eReverseStatement in '..\..\gxsource\Editor\GX_eReverseStatement.pas',
  GX_eSelectIdentifier in '..\..\gxsource\Editor\GX_eSelectIdentifier.pas',
  GX_eSelectionEditorExpert in '..\..\gxsource\Editor\GX_eSelectionEditorExpert.pas',
  GX_eUsesManager in '..\..\gxsource\Editor\GX_eUsesManager.pas' {fmUsesManager},
  GX_ExpertManager in '..\..\gxsource\Experts\GX_ExpertManager.pas' {fmExpertManager},
  GX_Experts in '..\..\gxsource\Framework\GX_Experts.pas',
  GX_FavFileProp in '..\..\gxsource\FavoriteFiles\GX_FavFileProp.pas' {fmFavFileProp},
  GX_FavFiles in '..\..\gxsource\FavoriteFiles\GX_FavFiles.pas' {fmFavFiles},
  GX_FavFolderProp in '..\..\gxsource\FavoriteFiles\GX_FavFolderProp.pas',
  GX_FavNewFolder in '..\..\gxsource\FavoriteFiles\GX_FavNewFolder.pas' {fmFavNewFolder},
  GX_FavOptions in '..\..\gxsource\FavoriteFiles\GX_FavOptions.pas' {fmFavOptions},
  GX_FavUtil in '..\..\gxsource\FavoriteFiles\GX_FavUtil.pas',
  GX_FeedbackWizard in '..\..\gxsource\Framework\GX_FeedbackWizard.pas' {fmFeedbackWizard},
  GX_FileScanner in '..\..\gxsource\Framework\GX_FileScanner.pas',
  GX_FindComponentRef in '..\..\gxsource\Experts\GX_FindComponentRef.pas',
  GX_GenericClasses in '..\..\gxsource\Utils\GX_GenericClasses.pas',
  GX_GenericUtils in '..\..\gxsource\Utils\GX_GenericUtils.pas',
  GX_GetIdeVersion in '..\..\gxsource\Framework\GX_GetIdeVersion.pas',
  GX_GExperts in '..\..\gxsource\Framework\GX_GExperts.pas',
  GX_GrepBackend in '..\..\gxsource\Grep\GX_GrepBackend.pas',
  GX_GrepExpert in '..\..\gxsource\Grep\GX_GrepExpert.pas',
  GX_GrepOptions in '..\..\gxsource\Grep\GX_GrepOptions.pas' {fmGrepOptions},
  GX_GrepPrinting in '..\..\gxsource\Grep\GX_GrepPrinting.pas',
  GX_GrepReplace in '..\..\gxsource\Grep\GX_GrepReplace.pas' {fmGrepReplace},
  GX_GrepResults in '..\..\gxsource\Grep\GX_GrepResults.pas' {fmGrepResults},
  GX_GrepResultsOptions in '..\..\gxsource\Grep\GX_GrepResultsOptions.pas' {fmGrepResultsOptions},
  GX_GrepSearch in '..\..\gxsource\Grep\GX_GrepSearch.pas' {fmGrepSearch},
  GX_GxUtils in '..\..\gxsource\Utils\GX_GxUtils.pas',
  GX_IconMessageBox in '..\..\gxsource\Framework\GX_IconMessageBox.pas',
  GX_IdeDock in '..\..\gxsource\IDEDocking\GX_IdeDock.pas' {fmIdeDockForm},
  GX_IdeEnhance in '..\..\gxsource\IDE\GX_IdeEnhance.pas',
  GX_IdeFormEnhancer in '..\..\gxsource\IDE\GX_IdeFormEnhancer.pas',
  GX_IdeShortCuts in '..\..\gxsource\Experts\GX_IdeShortCuts.pas' {fmIdeShortCuts},
  GX_IdeUtils in '..\..\gxsource\Utils\GX_IdeUtils.pas',
  GX_KbdShortCutBroker in '..\..\gxsource\Framework\GX_KbdShortCutBroker.pas',
  GX_KibitzComp in '..\..\gxsource\Framework\GX_KibitzComp.pas',
  GX_LibrarySource in '..\..\gxsource\Framework\GX_LibrarySource.pas',
  GX_MacroExpandNotifier in '..\..\gxsource\MacroTemplates\GX_MacroExpandNotifier.pas',
  GX_MacroFile in '..\..\gxsource\MacroTemplates\GX_MacroFile.pas',
  GX_MacroLibrary in '..\..\gxsource\Experts\GX_MacroLibrary.pas' {fmMacroLibrary},
  GX_MacroParser in '..\..\gxsource\Framework\GX_MacroParser.pas',
  GX_MacroSelect in '..\..\gxsource\MacroTemplates\GX_MacroSelect.pas' {fmMacroSelect},
  GX_MacroTemplateEdit in '..\..\gxsource\MacroTemplates\GX_MacroTemplateEdit.pas' {fmMacroTemplateEdit},
  GX_MacroTemplates in '..\..\gxsource\MacroTemplates\GX_MacroTemplates.pas' {fmMacroTemplates},
  GX_MacroTemplatesExpert in '..\..\gxsource\MacroTemplates\GX_MacroTemplatesExpert.pas',
  GX_MenuActions in '..\..\gxsource\Framework\GX_MenuActions.pas',
  GX_MenusForEditorExpert in '..\..\gxsource\Editor\GX_MenusForEditorExpert.pas',
  GX_MessageBox in '..\..\gxsource\Framework\GX_MessageBox.pas' {fmGxMessageBox},
  GX_MessageDialog in '..\..\gxsource\MessageDialog\GX_MessageDialog.pas' {fmMessageDialog},
  GX_MessageOptions in '..\..\gxsource\MessageDialog\GX_MessageOptions.pas' {fmMessageOptions},
  GX_MultilineHost in '..\..\gxsource\IDE\GX_MultilineHost.pas',
  GX_MultiLinePalette in '..\..\gxsource\IDE\GX_MultiLinePalette.pas',
  GX_OpenFile in '..\..\gxsource\OpenFile\GX_OpenFile.pas' {fmOpenFile},
  GX_OpenFileConfig in '..\..\gxsource\OpenFile\GX_OpenFileConfig.pas' {fmOpenFileConfig},
  GX_OtaUtils in '..\..\gxsource\Utils\GX_OtaUtils.pas',
  GX_PeInfo in '..\..\gxsource\Experts\GX_PeInfo.pas',
  GX_PeInformation in '..\..\gxsource\Experts\GX_PeInformation.pas' {fmPeInformation},
  GX_PerfectLayout in '..\..\gxsource\Experts\GX_PerfectLayout.pas' {fmPerfectLayout},
  GX_ProcedureList in '..\..\gxsource\ProcedureList\GX_ProcedureList.pas' {fmProcedureList},
  GX_ProcedureListOptions in '..\..\gxsource\ProcedureList\GX_ProcedureListOptions.pas' {fmProcedureListOptions},
  GX_Progress in '..\..\gxsource\Framework\GX_Progress.pas' {fmProgress},
  GX_ProjDepend in '..\..\gxsource\ProjectDependencies\GX_ProjDepend.pas' {fmProjDepend},
  GX_ProjDependFilter in '..\..\gxsource\ProjectDependencies\GX_ProjDependFilter.pas' {fmProjDependFilter},
  GX_ProjDependProp in '..\..\gxsource\ProjectDependencies\GX_ProjDependProp.pas' {fmProjDependProp},
  GX_ProjOptionSets in '..\..\gxsource\ProjectOptionSets\GX_ProjOptionSets.pas' {fmProjOptionSets},
  GX_ProjOptMap in '..\..\gxsource\ProjectOptionSets\GX_ProjOptMap.pas',
  GX_ProofreaderAutoCorrectEntry in '..\..\gxsource\CodeProofreader\GX_ProofreaderAutoCorrectEntry.pas' {fmProofreaderAutoCorrectEntry},
  GX_ProofreaderConfig in '..\..\gxsource\CodeProofreader\GX_ProofreaderConfig.pas' {fmProofreaderConfig},
  GX_ProofreaderCorrection in '..\..\gxsource\CodeProofreader\GX_ProofreaderCorrection.pas',
  GX_ProofreaderData in '..\..\gxsource\CodeProofreader\GX_ProofreaderData.pas',
  GX_ProofreaderDefaults in '..\..\gxsource\CodeProofreader\GX_ProofreaderDefaults.pas',
  GX_ProofreaderExpert in '..\..\gxsource\CodeProofreader\GX_ProofreaderExpert.pas',
  GX_ProofreaderKeyboard in '..\..\gxsource\CodeProofreader\GX_ProofreaderKeyboard.pas',
  GX_ProofreaderUtils in '..\..\gxsource\CodeProofreader\GX_ProofreaderUtils.pas',
  GX_Replace in '..\..\gxsource\Grep\GX_Replace.pas',
  GX_ReplaceComp in '..\..\gxsource\ReplaceComponents\GX_ReplaceComp.pas' {fmReplaceComp},
  GX_ReplaceCompData in '..\..\gxsource\ReplaceComponents\GX_ReplaceCompData.pas',
  GX_ReplaceCompLog in '..\..\gxsource\ReplaceComponents\GX_ReplaceCompLog.pas' {fmReplaceCompLog},
  GX_ReplaceCompMapDets in '..\..\gxsource\ReplaceComponents\GX_ReplaceCompMapDets.pas' {fmReplaceCompMapDets},
  GX_ReplaceCompMapGrpList in '..\..\gxsource\ReplaceComponents\GX_ReplaceCompMapGrpList.pas' {fmReplaceCompMapGrpList},
  GX_ReplaceCompMapList in '..\..\gxsource\ReplaceComponents\GX_ReplaceCompMapList.pas' {fmReplaceCompMapList},
  GX_ReplaceCompUtils in '..\..\gxsource\ReplaceComponents\GX_ReplaceCompUtils.pas',
  GX_Search in '..\..\gxsource\Grep\GX_Search.pas',
  GX_SetComponentProps in '..\..\gxsource\SetComponentProperties\GX_SetComponentProps.pas',
  GX_SetComponentPropsConfig in '..\..\gxsource\SetComponentProperties\GX_SetComponentPropsConfig.pas' {fmSetComponentPropsConfig},
  GX_SetComponentPropsStatus in '..\..\gxsource\SetComponentProperties\GX_SetComponentPropsStatus.pas' {fmSetComponentPropsStatus},
  GX_SharedImages in '..\..\gxsource\Framework\GX_SharedImages.pas' {dmSharedImages: TDataModule},
  GX_SourceExport in '..\..\gxsource\SourceExport\GX_SourceExport.pas' {fmSourceExport},
  GX_SourceExportOptions in '..\..\gxsource\SourceExport\GX_SourceExportOptions.pas' {fmSourceExportOptions},
  GX_SynMemoUtils in '..\..\gxsource\Framework\GX_SynMemoUtils.pas',
  GX_TabOrder in '..\..\gxsource\Experts\GX_TabOrder.pas' {fmTabOrder},
  GX_ToDo in '..\..\gxsource\ToDoList\GX_ToDo.pas' {fmToDo},
  GX_ToDoOptions in '..\..\gxsource\ToDoList\GX_ToDoOptions.pas' {fmToDoOptions},
  GX_Toolbar in '..\..\gxsource\EditorToolbar\GX_Toolbar.pas',
  GX_ToolbarConfig in '..\..\gxsource\EditorToolbar\GX_ToolbarConfig.pas' {fmToolbarConfig},
  GX_ToolBarDropDown in '..\..\gxsource\EditorToolbar\GX_ToolBarDropDown.pas',
  GX_UnitPositions in '..\..\gxsource\Framework\GX_UnitPositions.pas',
  GX_UsesManager in '..\..\gxsource\Framework\GX_UsesManager.pas',
  GX_VerDepConst in '..\..\gxsource\Framework\GX_VerDepConst.pas',
  GX_XmlUtils in '..\..\gxsource\Utils\GX_XmlUtils.pas',
  GX_Zipper in '..\..\gxsource\BackupProject\GX_Zipper.pas',
  GX_Formatter in '..\..\source\GX_Formatter.pas',
  GX_CodeFormatterBookmarks in '..\..\source\GX_CodeFormatterBookmarks.pas',
  GX_CodeFormatterBreakpoints in '..\..\source\GX_CodeFormatterBreakpoints.pas',
  GX_CodeFormatterConfig in '..\..\source\GX_CodeFormatterConfig.pas' {fmCodeFormatterConfig},
  GX_CodeFormatterConfigHandler in '..\..\source\GX_CodeFormatterConfigHandler.pas',
  GX_CodeFormatterDefaultSettings in '..\..\source\GX_CodeFormatterDefaultSettings.pas',
  GX_CodeFormatterDone in '..\..\source\GX_CodeFormatterDone.pas' {fmCodeFormatterDone},
  GX_CodeFormatterEditCapitalization in '..\..\source\GX_CodeFormatterEditCapitalization.pas' {fmCodeFormatterEditCapitalization},
  GX_CodeFormatterExpert in '..\..\source\GX_CodeFormatterExpert.pas',
  GX_CodeFormatterGXConfigWrapper in '..\..\source\GX_CodeFormatterGXConfigWrapper.pas',
  GX_CollectionLikeLists in '..\..\source\common\GX_CollectionLikeLists.pas',
  GX_CodeFormatterTypes in '..\..\source\common\GX_CodeFormatterTypes.pas',
  GX_CodeFormatterTokens in '..\..\source\engine\GX_CodeFormatterTokens.pas',
  GX_CodeFormatterEngine in '..\..\source\engine\GX_CodeFormatterEngine.pas',
  GX_CodeFormatterFormatter in '..\..\source\engine\GX_CodeFormatterFormatter.pas',
  GX_CodeFormatterParser in '..\..\source\engine\GX_CodeFormatterParser.pas',
  GX_CodeFormatterSettings in '..\..\source\engine\GX_CodeFormatterSettings.pas',
  GX_CodeFormatterStack in '..\..\source\engine\GX_CodeFormatterStack.pas',
  GX_AboutExperimental in '..\..\source\GX_AboutExperimental.pas' {fmAboutExperimental};

begin
end.

