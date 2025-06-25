; S6CommunityLib installer
; This script creates the installer and uninstaller for the S6CommunityLib.

#define MyAppName "S6CommunityLib"
#define MyAppVersion "0.5.0"
#define MyAppPublisher "totalwarANGEL"
#define MyAppURL "www.siedelwood-neu.de"
#define MyAppExeName "setup"

[Setup]
AppId={{F9C01BB5-7CA0-3E0C-76C1-107A771BCA0D}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName="C:\Program Files (x86)\Siedelwood\S6CommunityLib"
DefaultGroupName=Siedelwood
OutputDir=E:\Repositories\S6CommunityLib\var\release
OutputBaseFilename={#MyAppExeName}
SetupIconFile=E:\Repositories\S6CommunityLib\exe\icon.ico
Compression=lzma
SolidCompression=yes
DisableProgramGroupPage=yes
DisableDirPage=no

[Languages]
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Files]
Source: "..\var\release\s6communitylib\api\*"; DestDir: "{app}\api"; Flags: ignoreversion recursesubdirs
Source: "..\var\release\s6communitylib\doc\*"; DestDir: "{app}\doc"; Flags: ignoreversion recursesubdirs
Source: "..\var\release\s6communitylib\java\builder\S6CommunityLib.exe"; DestDir: "{app}\java\builder"; Flags: ignoreversion
Source: "..\var\release\s6communitylib\java\builder\S6CommunityLib.jar"; DestDir: "{app}\java\builder"; Flags: ignoreversion
Source: "..\var\release\s6communitylib\java\builder\config\*"; DestDir: "{app}\java\builder\config"; Flags: ignoreversion recursesubdirs
Source: "..\var\release\s6communitylib\java\jre\*"; DestDir: "{app}\java\jre"; Flags: ignoreversion recursesubdirs
Source: "..\var\release\s6communitylib\lua\*"; DestDir: "{app}\lua"; Flags: ignoreversion recursesubdirs
Source: "..\var\release\s6communitylib\prebuild\*"; DestDir: "{app}\prebuild"; Flags: ignoreversion recursesubdirs
Source: "..\var\release\s6communitylib\changelog.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\var\release\s6communitylib\instructions_de.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\var\release\s6communitylib\instructions_en.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\var\release\s6communitylib\license.md"; DestDir: "{app}"; Flags: ignoreversion

[Tasks]
Name: "desktopicon"; Description: "Desktop-Verknüpfung erstellen"; GroupDescription: "Zusätzliche Aufgaben:"

[Icons]
Name: "{group}\S6CommunityLib"; Filename: "{app}\S6CommunityLib.exe"; IconFilename: "{app}S6CommunityLib.exe"; IconIndex: 0
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{group}\{#MyAppName}"; Filename: "{uninstallexe}"; WorkingDir: "{app}"
Name: "{commondesktop}\S6CommunityLib"; Filename: "{app}S6CommunityLib.exe"; WorkingDir: "{app}"; Tasks: desktopicon