; Libertica installer
; This script creates the installer and uninstaller for Libertica.

#define MyAppName "Libertica Installer"
#define MyAppVersion "0.5.0"
#define MyAppPublisher "totalwarANGEL"
#define MyAppURL "www.siedelwood-neu.de"
#define MyAppExeName "setup-" + MyAppVersion

[Setup]
AppId={{F9C01BB5-7CA0-3E0C-76C1-107A635BCA0D}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName="C:\SteamLibrary\steamapps\common\The Settlers - Rise of an Empire - History Edition"
DefaultGroupName=S6UnofficialPatch
OutputDir=E:\Repositories\libertica\bin
OutputBaseFilename={#MyAppExeName}
SetupIconFile=E:\Repositories\libertica\bin\icon.ico
Compression=lzma
SolidCompression=yes
DisableProgramGroupPage=yes
; keine Spuren in der Registry hinterlassen
CreateUninstallRegKey=no

[Languages]
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Files]
Source: "..\release\doc\*"; DestDir: "{app}\doc"; Flags: ignoreversion recursesubdirs
Source: "..\release\jre\*"; DestDir: "{app}\jre"; Flags: ignoreversion recursesubdirs
Source: "..\release\libertica\*"; DestDir: "{app}\libertica"; Flags: ignoreversion recursesubdirs
Source: "..\release\libertica_api\*"; DestDir: "{app}\libertica_api\"; Flags: ignoreversion recursesubdirs
Source: "..\release\single\*"; DestDir: "{app}\single"; Flags: ignoreversion recursesubdirs
Source: "..\release\tools*"; DestDir: "{app}\tools"; Flags: ignoreversion recursesubdirs
Source: "..\release\changelog.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\release\instructions_de.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\release\instructions_en.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\release\licence.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\release\readme.md"; DestDir: "{app}"; Flags: ignoreversion
