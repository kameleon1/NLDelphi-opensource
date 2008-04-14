[Setup]
AppName=NLDMessenger
AppVerName=NLDMessenger 0.0.3.0
AppVersion=0.0.3.0
AppPublisher=TRIPLE software
AppPublisherURL=http://www.triplesoftware.com/
AppSupportURL=http://www.triplesoftware.com/
AppUpdatesURL=http://www.triplesoftware.com/
DefaultDirName={pf}\NLDMessenger
WizardSmallImageFile=iNSTALLOGO.bmp
DefaultGroupName=NLDMessenger
DontMergeDuplicateFiles=true
DisableStartupPrompt=false
LicenseFile=license.txt
BackColor=$cc9966
Compression=bzip
AppCopyright=TRIPLE software ©2003 and NLDelphi
PrivilegesRequired=poweruser
UninstallDisplayIcon={app}\NLDMessenger.exe
UninstallDisplayName=NLDMessenger

ShowLanguageDialog=false
AppID={8B0D03BE-6620-49C6-9E46-BE7B61715B5F}
[Messages]
BeveledLabel=TRIPLE software ©2004

;[Languages]
;Name: "en"; MessagesFile: "compiler:Default.isl"
;Name: "nl"; MessagesFile: "compiler:Dutch.isl"

[Tasks]
; NOTE: The following entry contains English phrases ("Create a desktop icon" and "Additional icons"). You are free to translate them into another language if required.
Name: desktopicon; Description: Create a &desktop icon; GroupDescription: Additional icons:
; NOTE: The following entry contains English phrases ("Create a Quick Launch icon" and "Additional icons"). You are free to translate them into another language if required.
Name: quicklaunchicon; Description: Create a &Quick Launch icon; GroupDescription: Additional icons:; Flags: unchecked

[Files]
Source: NLDMessenger.exe; DestDir: {app}; Flags: ignoreversion
Source: JabberCOM.tlb; DestDir: {sys}; Flags: uninsneveruninstall
Source: Jabbercom.dll; DestDir: {sys}; Flags: uninsneveruninstall sharedfile regserver comparetimestamp
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: {group}\NLDMessenger; Filename: {app}\NLDMessenger.exe; Comment: NLDMessenger Jabber Messenger; IconIndex: 0
Name: {userdesktop}\NLDMessenger; Filename: {app}\NLDMessenger.exe; Tasks: desktopicon; Comment: NLDMessenger Jabber Messenger; IconIndex: 0
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\NLDMessenger; Filename: {app}\NLDMessenger.exe; Tasks: quicklaunchicon; Comment: NLDMessenger Jabber Messenger; IconIndex: 0
Name: {group}\Uninstall NLDMessenger; Filename: {uninstallexe}; Comment: This will remove NLDMessenger from your pc

[Run]
; NOTE: The following entry contains an English phrase ("Launch"). You are free to translate it into another language if required.
Filename: {app}\NLDMessenger.exe; Description: Launch NLDMessenger; Flags: nowait postinstall skipifsilent
[_ISTool]
Use7zip=false
