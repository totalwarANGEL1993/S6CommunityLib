; Libertica installer
; This script creates the installer and uninstaller for Libertica.

#define MyAppName "Libertica"
#define MyAppVersion "0.5.0"
#define MyAppPublisher "totalwarANGEL"
#define MyAppURL "www.siedelwood-neu.de"
#define MyAppExeName "setup-" + MyAppVersion

[Setup]
AppId={{F9C01BB5-7CA0-3E0C-76C1-107A771BCA0D}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName="C:\Program Files (x86)\Siedelwood\Libertica"
DefaultGroupName=Siedelwood
OutputDir=E:\Repositories\libertica\bin
OutputBaseFilename={#MyAppExeName}
SetupIconFile=E:\Repositories\libertica\bin\icon.ico
Compression=lzma
SolidCompression=yes
DisableProgramGroupPage=yes
DisableDirPage=no

[Languages]
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Files]
Source: "..\release\doc\*"; DestDir: "{app}\doc"; Flags: ignoreversion recursesubdirs
Source: "..\release\jre\*"; DestDir: "{app}\jre"; Flags: ignoreversion recursesubdirs
Source: "..\release\libertica\*"; DestDir: "{app}\libertica"; Flags: ignoreversion recursesubdirs
Source: "..\release\libertica_api\*"; DestDir: "{app}\libertica_api"; Flags: ignoreversion recursesubdirs
Source: "..\release\single\*"; DestDir: "{app}\single"; Flags: ignoreversion recursesubdirs
Source: "..\release\tools\*"; DestDir: "{app}\tools"; Flags: ignoreversion recursesubdirs
Source: "..\release\changelog.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\release\instructions_de.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\release\instructions_en.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\release\license.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\release\readme.md"; DestDir: "{app}"; Flags: ignoreversion

[Tasks]
Name: "desktopicon"; Description: "Desktop-Verknüpfung erstellen"; GroupDescription: "Zusätzliche Aufgaben:"

[Icons]
Name: "{group}\Libertica"; Filename: "{app}\tools\builder\Libertica.exe"; IconFilename: "{app}\tools\builder\Libertica.exe"; IconIndex: 0
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{group}\{#MyAppName}"; Filename: "{uninstallexe}"; WorkingDir: "{app}"
Name: "{commondesktop}\Libertica"; Filename: "{app}\tools\builder\Libertica.exe"; WorkingDir: "{app}\tools\builder"; Tasks: desktopicon