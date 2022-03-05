﻿; ---------------------------------------
;      By EnergyCube#7471 2020-2022
;      Empire Earth Community Setup      
;     GNU General Public License v3.0
; ---------------------------------------
;   Reborn : discord.com/invite/BjUXbFB
; --------------------------------------- 
; Don't change the UTF-8 BOM encoding!
; UTF-8 doesn't preserve all characters
; ---------------------------------------
;                 Credit
; ---------------------------------------
; Translations :
;  German   : xXxJannik#0001
;  French   : EnergyCube#7471
;  Polish   : Dr.MonaLisa#9523
;  Italian  : Âgræl#9008
;  Spanish  : IvaN#9233, Kurt Z#8222
;  Russian  : FC_Fan#8831
;  Others   : DeepL / DuckDuckGo Translator
; ---------------------------------------
; External Dep. 
;   InnoSetup Downloader Plugin (download files + support mirrors), BASS (audio module)
; Additinal Content
;   Omega (Patch & Neo Content Patch), yukon aka. drex (dreXmod.dll)
;   Dege (DX Wrapper: dgVoodoo), GOG (DX Wrapper), zocker_160 & EnergyCube (Reborn.dll)
; Other Help
;   CyrentiX#1219 (Compatibility), xq_happy#7140 (Compatibility & Chinese files)
;   giord#4697 (Content), IvaN#9233 (Spanish files), FC_Fan#8831 (Russian files)
;   Every members of EE:Reborn team and and all others I may have forgotten :>
; ---------------------------------------
;  Notes  | Empire Earth is very sensitive to version change (which leads to multiplayer incompatibility),
;   for   | some modders might be interested in using this setup to deliver their mods. Please do not do
; Modders | this unless you have created a really popular and functional modpack. We must avoid creating
;         | multiple versions of the game to avoid fracturing the community.
; --------------------------------------- 
;  Notes  | Since the script is licensed under the GNU GPL v3 you have every right to modify the setup script
;   for   | to generate your own versions, but you must also publish the source code of the script.
;   Dev   | So I invite you to fork this project if you want and I pray you don't forget that we have to do
;         | everything to unite the community around the world, if you have ideas of modifications to do don't
;         | hesitate to make suggestions, I also invite you to make pull requests if you think you have done
;         | something that deserves to be in this script. The version of the script I'm distributing should
;         | become the standard to facilitate future installations. I hope you understand the objective and
;         | how necessary and helpful it is for everyone.
;         | If you think something is wrong, don't hesitate to tell me!
; ---------------------------------------
;              Release Note
; ---------------------------------------
; 1.0.0.0 | Initial Version
;         |------------------------------
;         | EE & AoC (in 11 languages)    
;         | Support NeoEE, dreXmod, Omega content 
;         | Support NeoEE CDKey generation (Admin)
;         | Download localized content online (support mirror)
;         | Online update checker (support mirror)
;         | DirectX Wrapper (DX9 with GOG dll and DX12 with dgVoodoo dll)
;         | Better compatibility with additonal flags
;         | HD Content with FortuKing textures 
;         | Registered in Firewall (Admin)  
;         | DirectX 9 Install (when using DirectX Wrapper for DirectX 9) 
;         | Removable Movies
;         | Digitally signed
;         |------------------------------
;         | DX11 (API 10 & 11) has been disabled. It is obviously impossible to fix the bug related to the
;         | full screen of the lobby (which puts the main window in window).
;         | Reborn.dll is currently disabled because of a bug that makes it unusable with dgVoodoo (or makes
;         | the window bug occur even with DirectX 12).
;         | Since after analysis the binaries of GOG and the one of the 2002 Empire Earth crack are identical
;         | the installation mode of the GOG binary has been removed since it is useless (its equivalent is to
;         | simply use the DirectX Wrapper of DirectX 9)
; ---------------------------------------
; 1.0.0.1 | NeoEE version fix
;         |------------------------------
;         | Fixed invalid regedit path for NeoEE (Installed From Directory was reversed)
;         | Deleted old NeoEE integrated updater
; ---------------------------------------
; 1.0.1.0 | NeoEE CDKeys user support, fixed Regedit and added new tool
;         |------------------------------
;         | Patched authtools.exe to install CDKeys in HKCU (now there is 2 authtools bin)
;         | Patched EE & AoC to read CDKeys in HKCU (now there is 2 Neo EE/AoC bin)   
;         | Fixed wrong regedit compatibility delete that was deleting the entire (Layers) key  
;         | Reworked compatibility flags, with fewer flags and better admin rights                  
;         | Added Empire Earth Diagnostic, a simple tool giving install informations (.NET 4) 
;         | Better certificate uninstall (check if another game is instaleld)
;         | Allow to install the certificate as user
;         | Redirected chinese traditional setup messages to chinese
; ---------------------------------------
; 1.0.2.0 | NeoEE Map fix, new HD content inc. icons with/witout letters
;         |------------------------------
;         | Fixed invalid maps on NeoEE
;         | Fixed EE:Diagnostic error while EE running
;         | Reworked WON Lobby Dialog images
;         | Added tips for recommanded multiplayer max pop for NeoEE
;         | Updated HD Icons by Fortukin
;         | Added HD Icons with localized letters
;         | Added some HD terrain textures from Yukon mod
;         | Better file clean-up (OOS, UPnP)
;         | Reworked Omega content management in the Setup
; ---------------------------------------

; SETUP SETTINGS

#define MySetupVersion "1.0.2.0"
#define MyAppExeName "Empire Earth.exe"
#define MyAppGroupName "Empire Earth" 

; InstallMode : Regular / Portable
#define InstallMode "Regular"

; InstallType : EE / NeoEE
#define InstallType "EE"

; Sign Setup/Uninstall

; Note: Signing the setup allows you to avoid the warning messages of Windows (saying that it would be
;       a virus...). This certificate is not free because everyone knows that trust can be bought...
;       However, when a user installs a signed version of the setup, by default he installs the joint
;       certificate on his computer (if CertInclude = true + user confirmation). If you want to use
;       the community certificate, contact me on discord, I will sign your setup after a verification.
#define SignSetup false

#if SignSetup 
  ; Install Cert
  #define CertInclude true
  ; Cert File Name (Need to be in ./data)
  #define CertFileName "cert_name.crt" 
  ; Cert Hash SHA1 (very important, needed to uninstall the cert)
  #define CertHashSHA1 ""
#else
  #define CertInclude false
#endif

; Update
#define UpdateUrl ""
#define UpdateUrlMirror ""

; Regedit
#if InstallType == "EE"
  #define BaseRegEE = "Software\SSSI\Empire Earth"
  #define BaseRegAoC = "Software\Mad Doc Software\EE-AOC"
#elif InstallType == "NeoEE"
  #define BaseRegEE = "Software\Neo\Empire Earth"
  #define BaseRegAoC = "Software\Neo\Art of Conquest"
#else
  #error Unsupported Install Type
#endif
#define BaseRegCompatibility = "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

; Audio
#define AudioModule true

; TestID (0 if Release)
# define TestID = 0

; END SETUP SETTINGS

; Reminder
; Update MyAppVersion if the update is a game update
; Update MySetupVersion if the update is a setup update
; Update MySetupVersion if updating MyAppVersion only if the setup is really updated
; When releasing a new MySetupVersion, it should be distribued for both EE & Neo
; MySetupVersion is a good way to know the features of the setup, meaning that EE & Neo should share the same version !

#if InstallType == "EE"
  #define MyAppVersion "2.0.0.0"
  #define MyAppName "Empire Earth" 
  #define MyAppPublisher "Empire Earth Community"
  #define MyAppURL "https://empireearth.eu/"
  #define MyInstallDirName "Empire Earth"
  #define MySetupPassword "ee"
#elif InstallType == "NeoEE"
  #define MyAppVersion "2.0.0.5" 
  #define MyAppName "NeoEE"
  #define MyAppPublisher "Empire Earth Community & NeoEE"
  #define MyAppURL "https://www.neoee.net/"
  #define MyInstallDirName "Neo Empire Earth"
  #define MySetupPassword "neo"
#else
  # error Unsupported Install Type
#endif

[Setup]
; SignTool: We need to use InnoSetup SignTool feature to sign install/uninstall etc...
; AppId: Tools > Generate GUID
; Be very carefull to AppId, it's like the unique id of the setup, be sure to generate it with inno setup
; the first time you distribute your setup and to keep it forever for the setup !
; So since it's a unique setup id, EE & NeoEE must have different AppId !
#if InstallType == "EE"
  AppId={
  SetupIconFile=./data/Empire Earth Base/Empire Earth/game.ico
  WizardSmallImageFile=./WizardSmallImageFileEE.bmp
  #if SignSetup
    SignTool=NameInInnoSetupEE $f
  #endif
#elif InstallType == "NeoEE"
  AppId={
  SetupIconFile=./data/NeoEE Base/Empire Earth/neoee.ico
  WizardSmallImageFile=./WizardSmallImageFileNeo.bmp
  #if SignSetup
    SignTool=NameInInnoSetupNeo $f
  #endif
#endif
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoVersion={#MySetupVersion}
VersionInfoCopyright={#MyAppPublisher}
AppVerName={#MyAppName} v{#MyAppVersion} - Setup v{#MySetupVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultGroupName={#MyAppGroupName}
AllowNoIcons=yes
LicenseFile=./data/Empire Earth Base/Empire Earth/EULA_DSML.txt
#if InstallType == "NeoEE"
  InfoBeforeFile=./data/NeoEE Base/Empire Earth/neoee_rules.rtf
#endif
InfoAfterFile=./data/Empire Earth Base/Empire Earth/help.rtf
OutputDir=./out
; lzma2/max = 32mo of ram (noticed 42mo on W10 & XP)
; Since EE need 64mo (including Windows), lzma2/max is the maximum compression
; I decided to use bzip because it's really faster to open 
Compression=bzip/9
SolidCompression=no
; Windows 10/11 ARM
; EE working on ARM thanks to the Windows x86 to ARM translation
; Since the convertion is transparent we don't need to add arm64 in ArchAllow
ArchitecturesAllowed=x86 x64
; Avoid reg redirections...
; https://jrsoftware.org/ishelp/index.php?topic=registrysection
ArchitecturesInstallIn64BitMode=x64     
WizardImageFile=./SetupBanner.bmp
WindowVisible=True
WindowResizable=False
WindowShowCaption=False
UninstallDisplayIcon={uninstallexe}
DirExistsWarning=no

#ifdef UNICODE
  WizardStyle=modern
#else
  WizardStyle=classic
#endif

; Warning for MinVersion < 6.1sp1
; Starting with Inno Setup 6.1 the [Setup] section directive MinVersion defaults to 6.1sp1,
; so by default Setup will not run on Windows Vista or on versions of Windows 7 and
; Windows Server 2008 R2 which have not been updated. Setting MinVersion to 6.0 to allow
; Setup to run on Windows Vista is supported but not recommended: Windows Vista doesn't
; support some of Setup's security measures against potential DLL preloading attacks so
; these have to be removed by the compiler if MinVersion is below 6.1 making your installer
; less secure on all versions of Windows.
; MinVersion=6.0

; If for any reason, Setup is reported to be a virus uncomment this to crypt files...
; The setup will display the password when asked to the user :)
; Also the setup should work, remember that any ressources used befoare the password
; validation need the 'noencryption' flag in Inno Setup !
; Encryption=yes
; Password={#MySetupPassword}

#if InstallMode == "Regular"
  PrivilegesRequiredOverridesAllowed=commandline dialog
  UsePreviousAppDir=yes
  Uninstallable=yes
  CreateUninstallRegKey=yes
  PrivilegesRequired=admin
  DefaultDirName={autopf32}\{#MyInstallDirName}
  #if InstallType == "EE"
    OutputBaseFilename={#InstallType}_Setup_v{#MySetupVersion}
  #elif InstallType == "NeoEE"
    OutputBaseFilename={#InstallType}_v{#MyAppVersion}_Setup_v{#MySetupVersion}
  #endif
#elif InstallMode == "Portable"
  UsePreviousAppDir=no
  Uninstallable=no
  CreateUninstallRegKey=no
  PrivilegesRequired=lowest 
  DefaultDirName={src}\{#MyInstallDirName} Portable
  #if InstallType == "EE"
    OutputBaseFilename={#InstallType}_Portable_Setup_v{#MySetupVersion}
  #elif InstallType == "NeoEE"
    OutputBaseFilename={#InstallType}_Portable_v{#MyAppVersion}_Setup_v{#MySetupVersion}
  #endif
#else
  #error Unsupported Install Mode
#endif

#include "./idp/idp.iss"
#include <idplang\German.iss>
#include <idplang\French.iss>
#include <idplang\Italian.iss>
#include <idplang\Polish.iss>
#include <idplang\Chinese.iss>
#include <idplang\BrazilianPortuguese.iss>
#include <idplang\Russian.iss>
#include <idplang\Spanish.iss>

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese_brazil"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl" 
Name: "chinese"; MessagesFile: "unofficial_isl\IS6\ChineseSimplified.isl"
Name: "chinese_traditional"; MessagesFile: "unofficial_isl\IS6\ChineseTraditional.isl" 
Name: "korean"; MessagesFile: "unofficial_isl\IS6\Korean.isl"

[Tasks]   
Name: "compatibility"; Description: "Enable compatibility flags"; MinVersion: 0.0,5.1;
Name: "compatibility_windows"; Description: "Enable earlier Windows compatibility mode"; MinVersion: 0.0,5.1;
Name: "firewallexception"; Description: "Add Empire Earth in the FireWall"; MinVersion: 0.0,5.0; Check: IsAdminInstallMode
; GOG Setup install DirectPlay but i don't think it's really important... some kind of default install for old DX game maybe
; Name: "directplay"; Description: "Install DirectPlay to improve compatibility"; MinVersion: 6.2; Check: IsAdminInstallMode
#if InstallType == "NeoEE"
  ; Since 1.0.1.0 NeoEE CDKeys support HKLM & HKCU
  Name: "neoee_cdkeys"; Description: "Register NeoEE CDKeys (Required to use the online lobby)"; MinVersion: 0.0,5.0;
#endif 

#if CertInclude
  Name: "certinclude"; Description: "Install Empire Earth Community Certificate (Uncheck if you don't trust us!)"; MinVersion: 0.0,6.0; Check: IsAdminInstallMode
  Name: "certinclude"; Description: "Install Empire Earth Community Certificate (Check only if you trust us!)"; MinVersion: 0.0,6.0; Flags: unchecked; Check: not IsAdminInstallMode
#endif

Name: "everyoneadminstart"; Description: "Require administrator rights for all users to run the game"; MinVersion: 0.0,5.1; Flags: unchecked; Check: IsAdminInstallMode

#if InstallMode != "Portable"
  Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
  Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0.0,6.1
#endif

[Components]
Name: "game"; Description: "{#MyAppName}"; Types: full compact custom; Flags: fixed
Name: "game\update"; Description: "Download {language} voices and campaigns"; Types: full compact; Flags: disablenouninstallwarning; Languages: french german italian spanish russian 
Name: "game\update"; Description: "**Try** to download {language} voices and campaigns"; Types: full compact; Flags: disablenouninstallwarning;  Languages: chinese chinese_traditional korean polish portuguese_brazil
; ------------------
Name: "gameaoc"; Description: "{#MyAppName} : AoC"; Types: full
Name: "gameaoc\update"; Description: "Download {language} voices and campaigns"; Types: full; Flags: disablenouninstallwarning; Languages: french german italian spanish
Name: "gameaoc\update"; Description: "**Try** to download {language} voices and campaigns"; Flags: disablenouninstallwarning;  Types: full compact; Languages: russian chinese chinese_traditional korean polish portuguese_brazil

; ------------------

Name: "additional"; Description: "Additional Recommended Content"
Name: "additional\movies"; Description: "Game Intro"; Flags: disablenouninstallwarning; Types: full
Name: "additional\hd"; Description: "HD Textures"; Flags: disablenouninstallwarning; Types: full
Name: "additional\hd\terrain"; Description: "HD Terrain v1.0 (by Sleeper & Yukon)"; Types: full

Name: "additional\hd\buildings"; Description: "HD Buildings Icons (by Fortuking)"; 
Name: "additional\hd\buildings\noletters"; Description: "HD with no letters v3.0"; Types: full; Flags: exclusive
Name: "additional\hd\buildings\english_qwerty"; Description: "HD with English (QWERTY) Letters v3.0.2"; Flags: exclusive
Name: "additional\hd\buildings\french_azerty"; Description: "HD with French (AZERTY) Letters v3.0.2"; Flags: exclusive
Name: "additional\hd\buildings\german_qwertz"; Description: "HD with German (QWERTZ) Letters v3.0.2"; Flags: exclusive

Name: "additional\hd\buildings"; Description: "HD Tech Icons (by Fortuking)";
Name: "additional\hd\tech\noletters"; Description: "HD with no letters v3.0.1"; Types: full; Flags: exclusive
Name: "additional\hd\tech\english_qwerty"; Description: "HD with English (QWERTY) Letters v3.0"; Flags: exclusive

Name: "additional\hd\effects"; Description: "HD Effects WIP (by Fortuking)"; Types: full
Name: "additional\drexmod"; Description: "dreXmod.dll v2 for better Camera, HUD and Lobby (by Yukon)"; Flags: disablenouninstallwarning; Types: full compact; MinVersion: 0,5.1
; Name: "additional\reborn"; Description: "Reborn.dll v0.1 for better Camera, Resolution and Solo Max Units"; Flags: disablenouninstallwarning; Types: full compact; MinVersion: 0,5.1
#if InstallType == "EE"
  Name: "additional\omega"; Description: "Omega Content for more Maps"; Types: full custom; 
#endif

Name: "additional\directx_wrapper"; Description: "DirectX Wrapper (+compatibility and sometime +performance)"; Flags: disablenouninstallwarning; MinVersion: 0.0,6.1
Name: "additional\directx_wrapper\dx9"; Description: "DirectX 9 (Windows XP&+) [Generally Recommended]"; Flags: exclusive disablenouninstallwarning; MinVersion: 0.0,6.1
; Name: "additional\directx_wrapper\dx11_lvl10"; Description: "DirectX 11 API lvl.10 v2.71.3 (Windows 7&+)"; Flags: exclusive disablenouninstallwarning; MinVersion: 0.0,6.1
; Name: "additional\directx_wrapper\dx11_lvl11"; Description: "DirectX 11 API lvl.11 v2.71.3 (Windows 7&+)"; Flags: exclusive disablenouninstallwarning; MinVersion: 0.0,6.1
Name: "additional\directx_wrapper\dx12_lvl11"; Description: "DirectX 12 API lvl.11 v2.71.3 (Windows 10&+)"; Flags: exclusive disablenouninstallwarning; MinVersion: 0.0,10;
Name: "additional\directx_wrapper\dx12_lvl12"; Description: "DirectX 12 API lvl.12 v2.71.3 (Windows 10&+)"; Flags: exclusive disablenouninstallwarning; MinVersion: 0.0,10;

Name: "additional\discord"; Description: "Discord Presence"; Flags: disablenouninstallwarning; Types: full compact; MinVersion: 0.0,6.1 
Name: "additional\tools"; Description: "Tools";
Name: "additional\tools\diagnostic"; Description: "Empire Earth Diagnostic"; Flags: disablenouninstallwarning; Types: full compact; MinVersion: 0.0,6.1
Name: "additional\civs"; Description: "Civilizations"
Name: "additional\civs\ec"; Description: "eC Standard Civilizations (25)"; Types: full compact
Name: "additional\civs\ec_full"; Description: "eC Full Civilizations (71)"
Name: "additional\civs\j2"; Description: "J2 Civilizations (19)"; Types: full compact

[Files]   
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
; For future ? signonce/sign
#if CertInclude
  Source: "./data/{#CertFileName}"; DestDir: "{tmp}"; DestName: "{#CertFileName}"; Flags: deleteafterinstall; Tasks: certinclude;
#endif

#if AudioModule
  Source: "./bass/x86/bass.dll"; Flags: dontcopy noencryption nocompression; Check: not Is64BitInstallMode
  Source: "./bass/x64/bass.dll"; Flags: dontcopy noencryption nocompression; Check: Is64BitInstallMode
  Source: "./data/Loop.flac"; Flags: dontcopy noencryption nocompression
#endif

#if InstallType == "EE"
  Source: "./SetupBackground-4-3.bmp"; DestDir: "{tmp}"; DestName: "SetupBackground-4-3.bmp"; Flags: deleteafterinstall dontcopy noencryption
  Source: "./SetupBackground-16-9.bmp"; DestDir: "{tmp}"; DestName: "SetupBackground-16-9.bmp"; Flags: deleteafterinstall dontcopy noencryption
#elif InstallType == "NeoEE"
  Source: "./SetupBackground-4-3-Neo.bmp"; DestDir: "{tmp}"; DestName: "SetupBackground-4-3.bmp"; Flags: deleteafterinstall dontcopy noencryption
  Source: "./SetupBackground-16-9-Neo.bmp"; DestDir: "{tmp}"; DestName: "SetupBackground-16-9.bmp"; Flags: deleteafterinstall dontcopy noencryption
#endif

Source: "./data/Add-on/Runtime/DirectX_9/*"; DestDir: "{tmp}/DirectX_9"; Flags: deleteafterinstall ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx9; Check: IsAdminInstallMode

; ---------------- 

; EE Base
Source: "./data/Empire Earth Base/Empire Earth/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: game;
; EE Movies
Source: "./data/Add-on/Movies/EE/*"; DestDir: "{app}\Empire Earth\Data\Movies"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\movies and game;

#if InstallType == "NeoEE"
  Source: "./data/NeoEE Base/Empire Earth/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: game
  Source: "./data/Add-on/Omega/EE/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: game
  Source: "./data/NeoEE - Admin/Empire Earth/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: game; Check: IsAdminInstallMode
  Source: "./data/NeoEE - User/Empire Earth/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: game; Check: not IsAdminInstallMode
  Source: "./data/NeoEE - CDKeys/authtools_user.exe"; DestDir: "{tmp}";  DestName: "authtools.exe"; Flags: deleteafterinstall ignoreversion recursesubdirs createallsubdirs; Components: game; Check: not IsAdminInstallMode
  Source: "./data/NeoEE - CDKeys/authtools_admin.exe"; DestDir: "{tmp}";  DestName: "authtools.exe"; Flags: deleteafterinstall ignoreversion recursesubdirs createallsubdirs; Components: game; Check: IsAdminInstallMode
  Source: "./data/NeoEE - CDKeys/_wonkver.pub"; DestDir: "{app}\Empire Earth"; Flags: deleteafterinstall ignoreversion recursesubdirs createallsubdirs; Components: game
  ; NeoEE - Wine Fix (GDI)
  Source: "./data/NeoEE - Wine/NeoEE.cfg"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: game; Check: IsWine
#endif

; EE Local Lang Based Content (External Flag because we are using already extracted files)
Source: "{app}\Empire Earth\Data\Languages\{language}\*"; DestDir: "{app}\Empire Earth"; Flags: external ignoreversion recursesubdirs createallsubdirs; Components: game;
; EE Online Lang Based Content
Source: "{tmp}\EE\*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs external skipifsourcedoesntexist; Components: game\update;

; DreXmod
; Soon deprecated by drex 3 that will most probably not included in the setup because it could split community
; Also Reborn Dll will soon replace the main functions of drex 2
; Yukon s'il te plait, rends ton code public et faisons avancer le communauté tous ensemble, sérieusement ça n'a aucun sens nous somme si peu de dev...
Source: "./data/Add-on/DLLs/dreXmod/2/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\drexmod and game;  

#if InstallType == "EE"
  ; Omega
  Source: "./data/Add-on/Omega/EE/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\omega and game
#endif
; dgVoodoo  Bin
Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_bin/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper and game and not additional\directx_wrapper\dx9 
Source: "./data//Add-on/DirectX_Wrapper/GOG/DDraw.dll"; DestDir: "{app}\Empire Earth"; DestName: "DDraw.dll"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx9 and game;
; dgVoodoo Conf
; Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_conf/dgVoodoo_DX11_LVL10.conf"; DestDir: "{app}\Empire Earth"; DestName: "dgVoodoo.conf"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx11_lvl10 and game;
; Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_conf/dgVoodoo_DX11_LVL11.conf"; DestDir: "{app}\Empire Earth"; DestName: "dgVoodoo.conf"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx11_lvl11 and game;
Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_conf/dgVoodoo_DX12_LVL11.conf"; DestDir: "{app}\Empire Earth"; DestName: "dgVoodoo.conf"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx12_lvl11 and game;
Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_conf/dgVoodoo_DX12_LVL12.conf"; DestDir: "{app}\Empire Earth"; DestName: "dgVoodoo.conf"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx12_lvl12 and game; 

; Civs
Source: "./data/Add-on/Civs/eC/*"; DestDir: "{app}\Empire Earth\Users\default\Civilizations"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\civs\ec and game
Source: "./data/Add-on/Civs/eC_full/*"; DestDir: "{app}\Empire Earth\Users\default\Civilizations"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\civs\ec_full and game
Source: "./data/Add-on/Civs/J2/*"; DestDir: "{app}\Empire Earth\Users\default\Civilizations"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\civs\j2 and game

; Discord
Source: "./data/Add-on/DLLs/Discord/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\discord and game

; Reborn.dll
; Source: "./data/Add-on/DLLs/Reborn/*"; DestDir: "{app}\Empire Earth"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\reborn and game

; HD
Source: "./data/Add-on/HD/terrain/*"; DestDir: "{app}\Empire Earth\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\terrain and game

; Tech
Source: "./data/Add-on/HD/tech/Not Localized/*"; DestDir: "{app}\Empire Earth\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\tech\noletters and game
Source: "./data/Add-on/HD/tech/English (QWERTY)/*"; DestDir: "{app}\Empire Earth\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\tech\english_qwerty and game

; Building
Source: "./data/Add-on/HD/buildings/Other Buildings/*"; DestDir: "{app}\Empire Earth\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings and game
Source: "./data/Add-on/HD/buildings/Not Localized/*"; DestDir: "{app}\Empire Earth\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings\noletters and game
Source: "./data/Add-on/HD/buildings/English (QWERTY)/*"; DestDir: "{app}\Empire Earth\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings\english_qwerty and game
Source: "./data/Add-on/HD/buildings/French (AZERTY)/*"; DestDir: "{app}\Empire Earth\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings\french_azerty and game
Source: "./data/Add-on/HD/buildings/German (QWERTZ)/*"; DestDir: "{app}\Empire Earth\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings\german_qwertz and game

Source: "./data/Add-on/HD/effects/*"; DestDir: "{app}\Empire Earth\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\effects and game

; ----------------

; AoC Base
Source: "./data/Empire Earth Base/Empire Earth - The Art of Conquest/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: gameaoc;
; EE Movies
Source: "./data/Add-on/Movies/AoC/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Movies"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\movies and gameaoc;

#if InstallType == "NeoEE"
  Source: "./data/NeoEE Base/Empire Earth - The Art of Conquest/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
    Flags: ignoreversion recursesubdirs createallsubdirs; Components: gameaoc
  Source: "./data/Add-on/Omega/AoC/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
    Flags: ignoreversion recursesubdirs createallsubdirs; Components: gameaoc
  Source: "./data/NeoEE - Admin/Empire Earth - The Art of Conquest/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
    Flags: ignoreversion recursesubdirs createallsubdirs; Components: gameaoc; Check: IsAdminInstallMode
  Source: "./data/NeoEE - User/Empire Earth - The Art of Conquest/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
    Flags: ignoreversion recursesubdirs createallsubdirs; Components: gameaoc; Check: not IsAdminInstallMode
  ; Already done in EE part Source: authtools.exe
  Source: "./data/NeoEE - CDKeys/_wonkver.pub"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
    Flags: deleteafterinstall ignoreversion recursesubdirs createallsubdirs; Components: gameaoc
  ; NeoEE - Wine Fix (GDI)
  Source: "./data/NeoEE - Wine/NeoEE.cfg"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
    Flags: ignoreversion recursesubdirs createallsubdirs; Components: game; Check: IsWine
#endif

; AoC Local Lang Based Content (External Flag because {language} cause error during compilation
Source: "{app}\Empire Earth - The Art of Conquest\Data\Languages\{language}\*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
  Flags: external ignoreversion recursesubdirs createallsubdirs; Components: gameaoc
; AoC Online Lang Based Content
Source: "{tmp}\AoC\*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
  Flags: ignoreversion recursesubdirs createallsubdirs external; Components: gameaoc\update
Source: "{tmp}\EE\Data\Campaigns\EELearningCampaign.ssa"; DestDir: "{app}\Empire Earth\Data\Campaigns"; \
  Flags: ignoreversion recursesubdirs createallsubdirs external skipifsourcedoesntexist; Components: gameaoc\update;

; DreXmod
Source: "./data/Add-on/DLLs/dreXmod/2/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\drexmod and gameaoc

#if InstallType == "EE"  
  ; Omega
  Source: "./data/Add-on/Omega/AoC/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
    Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\omega and gameaoc
#endif

; dgVoodoo  Bin
Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_bin/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper and game and not additional\directx_wrapper\dx9 
Source: "./data//Add-on/DirectX_Wrapper/GOG/DDraw.dll"; DestDir: "{app}\Empire Earth - The Art of Conquest"; DestName: "DDraw.dll"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx9 and game;
; dgVoodoo Conf
; Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_conf/dgVoodoo_DX11_LVL10.conf"; DestDir: "{app}\Empire Earth - The Art of Conquest"; DestName: "dgVoodoo.conf"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx11_lvl10 and game;
; Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_conf/dgVoodoo_DX11_LVL11.conf"; DestDir: "{app}\Empire Earth - The Art of Conquest"; DestName: "dgVoodoo.conf"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx11_lvl11 and game;
Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_conf/dgVoodoo_DX12_LVL11.conf"; DestDir: "{app}\Empire Earth - The Art of Conquest"; DestName: "dgVoodoo.conf"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx12_lvl11 and game;
Source: "./data/Add-on/DirectX_Wrapper/dgVoodoo_conf/dgVoodoo_DX12_LVL12.conf"; DestDir: "{app}\Empire Earth - The Art of Conquest"; DestName: "dgVoodoo.conf"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\directx_wrapper\dx12_lvl12 and game; 

; Civs
Source: "./data/Add-on/Civs/eC/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Users\default\Civilizations"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\civs\ec and gameaoc
Source: "./data/Add-on/Civs/eC_full/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Users\default\Civilizations"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\civs\ec_full and gameaoc
Source: "./data/Add-on/Civs/J2/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Users\default\Civilizations"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\civs\j2 and gameaoc

; Discord
Source: "./data/Add-on/DLLs/Discord/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\discord and gameaoc

; Reborn.dll
; Not supported Source: "./data/Add-on/DLLs/Reborn/*"; DestDir: "{app}\Empire Earth - The Art of Conquest"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\reborn and gameaoc

; HD
Source: "./data/Add-on/HD/terrain/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\terrain and gameaoc

; Tech
Source: "./data/Add-on/HD/tech/Not Localized/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\tech\noletters and gameaoc
Source: "./data/Add-on/HD/tech/English (QWERTY)/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\tech\english_qwerty and gameaoc

; Building
Source: "./data/Add-on/HD/buildings/Other Buildings/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings and gameaoc
Source: "./data/Add-on/HD/buildings/Not Localized/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings\noletters and gameaoc
Source: "./data/Add-on/HD/buildings/English (QWERTY)/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings\english_qwerty and gameaoc
Source: "./data/Add-on/HD/buildings/French (AZERTY)/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings\french_azerty and gameaoc
Source: "./data/Add-on/HD/buildings/German (QWERTZ)/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\buildings\german_qwertz and gameaoc
Source: "./data/Add-on/HD/effects/*"; DestDir: "{app}\Empire Earth - The Art of Conquest\Data\Textures"; \
  Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\hd\effects and gameaoc

; -------------------
;  Allow config edit
; -------------------  
Source: "{app}\Empire Earth\*.cfg"; DestDir: "{app}\Empire Earth"; Permissions: authusers-modify; Flags: ignoreversion recursesubdirs createallsubdirs external; Components: game;
Source: "{app}\Empire Earth\*.config"; DestDir: "{app}\Empire Earth"; Permissions: authusers-modify; Flags: ignoreversion recursesubdirs createallsubdirs external; Components: game;
Source: "{app}\Empire Earth\*.ini"; DestDir: "{app}\Empire Earth"; Permissions: authusers-modify; Flags: ignoreversion recursesubdirs createallsubdirs external; Components: game;
; ----------------
Source: "{app}\Empire Earth - The Art of Conquest\*.cfg"; DestDir: "{app}\Empire Earth - The Art of Conquest"; Permissions: authusers-modify; Flags: ignoreversion recursesubdirs createallsubdirs external; Components: gameaoc;
Source: "{app}\Empire Earth - The Art of Conquest\*.config"; DestDir: "{app}\Empire Earth - The Art of Conquest"; Permissions: authusers-modify; Flags: ignoreversion recursesubdirs createallsubdirs external; Components: gameaoc;
Source: "{app}\Empire Earth - The Art of Conquest\*.ini"; DestDir: "{app}\Empire Earth - The Art of Conquest"; Permissions: authusers-modify; Flags: ignoreversion recursesubdirs createallsubdirs external; Components: gameaoc;

; ---------------------
;         Tools
; ---------------------
Source: "./data/Add-on/Tools/Diagnostic/*"; DestDir: "{app}\Tools\Diagnostic"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: additional\tools\diagnostic;

[Dirs]
; ---------------------
;  Allow Data/Civ edit
; ---------------------
Name: "{app}\Empire Earth\Data"; Permissions: authusers-modify; Components: game;
Name: "{app}\Empire Earth\Users"; Permissions: authusers-modify; Components: game;
; ---------------- 
Name: "{app}\Empire Earth - The Art of Conquest\Data"; Permissions: authusers-modify; Components: gameaoc
Name: "{app}\Empire Earth - The Art of Conquest\Users"; Permissions: authusers-modify; Components: gameaoc

[Registry]
; Compatibility
;   WIN7RTM    DWM8And16BitMitigation    for Windows 8+
;   WINXPSP3   DWM8And16BitMitigation    for Windows 7+
;   WIN98               -                for Windows >2000
; Help
;   HeapClearAllocation: Clear memory on program crash
;   DWM8And16BitMitigation: (From Windows 8, DirectX) Convert 8bits to 16bits
;   HIGHDPIAWARE: [Need investigation] Will try to make the game coherent with the screen DPI 
; Maybe for later ?
;   IgnoreAltTab DisableWindowsDefender DisableDWM Disable8And16BitModes Disable8And16BitD3D
;   DISABLETHEMES DISABLEDWM IgnoreFontQuality ForceLoadMirrorDrvMitigation DXGICompat         
;   FontMigration: [Need investigation] Replaces a font with a better font, to avoid text truncation.            
;   ForceInvalidateOnClose: Force program to close window in some cases 
;   DISABLEDXMAXIMIZEDWINDOWEDMODE: (DirectX) Disable fullscreen optimization (maj is important...) (make game crash but sometime work)

; Admin + Windows compatibility    
; Windows >=8                                                                                                                                                                           
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags} WIN7RTM"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,10; Tasks: compatibility_windows; Components: game
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags} WIN7RTM"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,10; Tasks: compatibility_windows; Components: gameaoc
; Windows >=Vista & <= 7
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags} WINXPSP3"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,6.0; OnlyBelowVersion: 0.6.2; Tasks: compatibility_windows; Components: game 
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags} WINXPSP3"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,6.0; OnlyBelowVersion: 0.0,6.2; Tasks: compatibility_windows; Components: gameaoc
; Windows >=2000 & <=XP                                                                                                                                        
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags} WIN98"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,5.0; OnlyBelowVersion: 0.0,6.0; Tasks: compatibility_windows; Components: game 
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags} WIN98"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,5.0; OnlyBelowVersion: 0.0,6.0; Tasks: compatibility_windows; Components: gameaoc

; Admin - Windows compatibility    
; Windows >=8                                                                                                                                                                           
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,10; Tasks: not compatibility_windows and compatibility; Components: game
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,10; Tasks: not compatibility_windows and compatibility; Components: gameaoc
; Windows >=Vista & <= 7
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,6.0; OnlyBelowVersion: 0.6.2; Tasks: not compatibility_windows and compatibility; Components: game 
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,6.0; OnlyBelowVersion: 0.0,6.2; Tasks: not compatibility_windows and compatibility; Components: gameaoc
; Windows >=2000 & <=XP                                                                                                                                        
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,5.0; OnlyBelowVersion: 0.0,6.0; Tasks: not compatibility_windows and compatibility; Components: game 
Root: "HKLM"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,5.0; OnlyBelowVersion: 0.0,6.0; Tasks: not compatibility_windows and compatibility; Components: gameaoc

; Admin (Add admin flag for CU if LM don't have it)
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "~ RUNASADMIN"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,5.0; Tasks: not everyoneadminstart and compatibility; Components: game  
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "~ RUNASADMIN"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: IsAdminInstallMode; MinVersion: 0.0,5.0; Tasks: not everyoneadminstart and compatibility; Components: gameaoc

; ---------

; User + Windows compatibility    
; Windows >=8                                                                                                                                                                           
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags} WIN7RTM"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,10; Tasks: compatibility_windows and compatibility; Components: game 
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags} WIN7RTM"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,10; Tasks: compatibility_windows and compatibility; Components: gameaoc
; Windows >=Vista & <= 7
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags} WINXPSP3"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,6.0; OnlyBelowVersion: 0.6.2; Tasks: compatibility_windows and compatibility; Components: game  
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags} WINXPSP3"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,6.0; OnlyBelowVersion: 0.0,6.2; Tasks: compatibility_windows and compatibility; Components: gameaoc
; Windows >=2000 & <=XP                                                                                                                                        
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags} WIN98"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,5.0; OnlyBelowVersion: 0.0,6.0; Tasks: compatibility_windows and compatibility; Components: game  
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags} WIN98"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,5.0; OnlyBelowVersion: 0.0,6.0; Tasks: compatibility_windows and compatibility; Components: gameaoc

; User - Windows compatibility    
; Windows >=8                                                                                                                                                                           
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,10; Tasks: not compatibility_windows and compatibility; Components: game
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,10; Tasks: not compatibility_windows and compatibility; Components: gameaoc
; Windows >=Vista & <= 7
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,6.0; OnlyBelowVersion: 0.6.2; Tasks: not compatibility_windows and compatibility; Components: game 
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,6.0; OnlyBelowVersion: 0.0,6.2; Tasks: not compatibility_windows and compatibility; Components: gameaoc
; Windows >=2000 & <=XP                                                                                                                                        
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth\Empire Earth.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,5.0; OnlyBelowVersion: 0.0,6.0; Tasks: not compatibility_windows and compatibility; Components: game 
Root: "HKCU"; Subkey: "{#BaseRegCompatibility}"; ValueType: String; ValueName: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; ValueData: "{code:GetCompatibilityFlags}"; \
  Flags: createvalueifdoesntexist uninsdeletevalue; Check: not IsAdminInstallMode; MinVersion: 0.0,5.0; OnlyBelowVersion: 0.0,6.0; Tasks: not compatibility_windows and compatibility; Components: gameaoc

; Game Settings
Root: "HKCU"; Subkey: "{#BaseRegEE}"; Flags: uninsdeletekey; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: String; ValueName: "Rasterizer Name"; ValueData: "Direct3D Hardware TnL"; Components: game and not additional\directx_wrapper; Check: not IsWine
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: String; ValueName: "Rasterizer Name"; ValueData: "Direct3D"; Components: game and additional\directx_wrapper; Check: not IsWine
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: String; ValueName: "Rasterizer Name"; ValueData: "Direct3D"; Check: IsWine 
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: Dword; ValueName: "AutoSave In Milliseconds"; ValueData: "$124F80"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: String; ValueName: "Map Type"; ValueData: "Continental"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Map Size"; ValueData: "$2"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Starting Resources"; ValueData: "$3"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Starting Epoch"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Ending Epoch"; ValueData: "$D"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Game Unit Limit"; ValueData: "$4B0"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Wonders For Victory"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Game Variant"; ValueData: "$2"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Difficulty Level"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Game Speed"; ValueData: "$3"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Reveal Map"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Allow Custom Civs"; ValueData: "$1"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Lock Teams"; ValueData: "$1"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Lock Speed"; ValueData: "$1"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}\Game Options"; ValueType: Dword; ValueName: "Cheat Codes"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: Dword; ValueName: "Music Volume"; ValueData: "$19"; Flags: createvalueifdoesntexist; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: Dword; ValueName: "Sound Volume"; ValueData: "$3C"; Flags: createvalueifdoesntexist; Components: game
; Set Default 1920x1080 32 bits
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: Dword; ValueName: "Game Window Height"; ValueData: "$438"; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: Dword; ValueName: "Game Window Width"; ValueData: "$780"; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: Dword; ValueName: "Game Bit Depth"; ValueData: "$20"; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: Dword; ValueName: "Texture Bit Depth"; ValueData: "$20"; Components: game
; Adding Installed From to allow AoC to be started without having to start EE first.
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: string; ValueName: "Installed From Volume"; ValueData: "{code:GetInstallDriveLetter}"; Components: game
Root: "HKCU"; Subkey: "{#BaseRegEE}"; ValueType: string; ValueName: "Installed From Directory"; ValueData: "{code:GetInstallWithoutDriveLetterBase}\Empire Earth\"; Components: game

; ----------------

Root: "HKCU"; Subkey: "{#BaseRegAoC}"; Flags: uninsdeletekey; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: String; ValueName: "Rasterizer Name"; ValueData: "Direct3D Hardware TnL"; Components: gameaoc and not additional\directx_wrapper
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: String; ValueName: "Rasterizer Name"; ValueData: "Direct3D"; Components: gameaoc and additional\directx_wrapper 
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: String; ValueName: "Rasterizer Name"; ValueData: "Direct3D"; Check: IsWine
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: Dword; ValueName: "AutoSave In Milliseconds"; ValueData: "$124F80"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: String; ValueName: "Map Type"; ValueData: "Continental"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Map Size"; ValueData: "$2"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Starting Resources"; ValueData: "$3"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Starting Epoch"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Ending Epoch"; ValueData: "$E"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Game Unit Limit"; ValueData: "$4B0"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Wonders For Victory"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Game Variant"; ValueData: "$2"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Difficulty Level"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Game Speed"; ValueData: "$3"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Reveal Map"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Allow Custom Civs"; ValueData: "$1"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Lock Teams"; ValueData: "$1"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Lock Speed"; ValueData: "$1"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}\Game Options"; ValueType: Dword; ValueName: "Cheat Codes"; ValueData: "$0"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: Dword; ValueName: "Music Volume"; ValueData: "$19"; Flags: createvalueifdoesntexist; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: Dword; ValueName: "Sound Volume"; ValueData: "$3C"; Flags: createvalueifdoesntexist; Components: gameaoc 
; Set Default 1920x1080 32 bits (Note : if Texture Bit Depth != Game Bit Depth, the main menu is just white and unreadable)
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: Dword; ValueName: "Game Window Height"; ValueData: "$438"; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: Dword; ValueName: "Game Window Width"; ValueData: "$780"; Components: gameaoc 
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: Dword; ValueName: "Game Bit Depth"; ValueData: "$20"; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: Dword; ValueName: "Texture Bit Depth"; ValueData: "$20"; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: string; ValueName: "Installed From Volume"; ValueData: "{code:GetInstallDriveLetter}"; Components: gameaoc
Root: "HKCU"; Subkey: "{#BaseRegAoC}"; ValueType: string; ValueName: "Installed From Directory"; ValueData: "{code:GetInstallWithoutDriveLetterBase}\Empire Earth - The Art of Conquest\"; Components: gameaoc

[Icons]
#if InstallMode != "Portable"
  Name: "{group}\{#MyAppName}"; Filename: "{app}\Empire Earth\Empire Earth.exe"; Components: game;
  Name: "{group}\{#MyAppName} - AoC"; Filename: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; Components: gameaoc;
  Name: "{group}\{#MyAppName} Diagnostic"; Filename: "{app}\Tools\Diagnostic\EE-Diagnostic.exe"; Parameters: "{#SetupSetting("AppId")}_is1"; MinVersion: 0.0,5.0; Components: additional\tools\diagnostic;
  ; Uncomment to add the Uninstall shortcut in the Start Menu
  ; Name: "{group}\{cm:UninstallProgram,Empire Earth}"; Filename: "{uninstallexe}"; 
  Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\Empire Earth\Empire Earth.exe"; Components: game; Tasks: desktopicon; 
  Name: "{autodesktop}\{#MyAppName} - AoC"; Filename: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; Components: gameaoc; Tasks: desktopicon; 
  Name: "{autoappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\Empire Earth\Empire Earth.exe"; Components: game; Tasks: quicklaunchicon; 
  Name: "{autoappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName} - AoC"; Filename: "{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"; Components: gameaoc; Tasks: quicklaunchicon;
  Name: "{autoappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName} Diagnostic"; Filename: "{app}\Tools\Diagnostic\EE-Diagnostic.exe"; Parameters: "{#SetupSetting("AppId")}_is1"; MinVersion: 0.0,5.0; Components: additional\tools\diagnostic; Tasks: quicklaunchicon;  
#endif

[InstallDelete]
; Supported Component modification : old GOG or Retail | dgVoodoo | dreXmod | Discord | Movies | Reborn
; Other component are too hard to delete without maybe deleting user files (modding)
Type: files; Name: "{app}\Empire Earth\Empire Earth.exe"
Type: files; Name: "{app}\Empire Earth\D3D8.dll"
Type: files; Name: "{app}\Empire Earth\D3D9.dll"
Type: files; Name: "{app}\Empire Earth\D3DImm.dll"
Type: files; Name: "{app}\Empire Earth\DDraw.dll"
Type: files; Name: "{app}\Empire Earth\dgVoodooCpl.exe"
Type: files; Name: "{app}\Empire Earth\dgVoodoo.conf"
Type: files; Name: "{app}\Empire Earth\dreXmod.config"
Type: files; Name: "{app}\Empire Earth\dreXmod.dll"
Type: files; Name: "{app}\Empire Earth\Reborn.ini"
Type: files; Name: "{app}\Empire Earth\Reborn.dll"
Type: files; Name: "{app}\Empire Earth\discord_game_sdk.dll"
Type: files; Name: "{app}\Empire Earth\EEDiscordRichPresence.dll"
Type: files; Name: "{app}\Empire Earth\Data\Scenarios\ScenDefault.scn"


Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\New Plains.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\No Resources.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\Tortured Rivers.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\Tunisia Oasis.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\Tweek My CA Micro.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\Twisted For Grens.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\Uniquely Random.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\Vicious Isthmi.rmv" 
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\X.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\Z.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\zBG_Death Gulch.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\zContinents-DrOrange.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\zRandom Islands.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\zRandom Land.rmv"
Type: files; Name: "{app}\Empire Earth\Data\Random Map Scripts\zTropic Island.rmv"

Type: files; Name: "{app}\Empire Earth\OOS *"
Type: filesandordirs; Name: "{app}\Empire Earth\Data\Movies\";
Type: filesandordirs; Name: "{app}\Empire Earth\Data\_Movies\" 
; ----------------
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\EE-AOC"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\D3D8.dll"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\D3D9.dll"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\D3DImm.dll"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\DDraw.dll"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\dgVoodooCpl.exe"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\dgVoodoo.conf"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\dreXmod.config"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\dreXmod.dll" 
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Reborn.ini" 
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Reborn.dll"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\discord_game_sdk.dll"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\EEDiscordRichPresence.dll"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Scenarios\ScenDefault.scn" 

Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\New Plains.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\No Resources.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\Tortured Rivers.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\Tunisia Oasis.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\Tweek My CA Micro.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\Twisted For Grens.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\Uniquely Random.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\Vicious Isthmi.rmv" 
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\X.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\Z.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\zBG_Death Gulch.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\zContinents-DrOrange.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\zRandom Islands.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\zRandom Land.rmv"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Data\Random Map Scripts\zTropic Island.rmv"

Type: files; Name: "{app}\Empire Earth - The Art of Conquest\OOS *"  
Type: filesandordirs; Name: "{app}\Empire Earth - The Art of Conquest\Data\Movies\"
Type: filesandordirs; Name: "{app}\Empire Earth - The Art of Conquest\Data\_Movies\"

[UninstallDelete]
; A little extra cleaning to the installed files
; Convention : Never delete the entire program folder !     
Type: files; Name: "{app}\Empire Earth\0_Error.log"
Type: files; Name: "{app}\Empire Earth\neoee.log"
Type: files; Name: "{app}\Empire Earth\upnp_info.txt"
Type: files; Name: "{app}\Empire Earth\Reborn.ini"
Type: files; Name: "{app}\Empire Earth\_won*"
Type: files; Name: "{app}\Empire Earth\_wonHTTPCache\*" 
Type: files; Name: "{app}\Empire Earth\upnp_info.txt"
Type: filesandordirs; Name: "{app}\Empire Earth\_wonHTTPCache"
; portuguese_brazil create that dir for some reasons (not used)
Type: filesandordirs; Name: "{app}\Empire Earth\Users\default\Civilizações"
; ----------------
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\0_Error.log" 
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\neoee.log" 
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\upnp_info.txt"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\Reborn.ini"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\_won*"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\_wonHTTPCache\*"
Type: files; Name: "{app}\Empire Earth - The Art of Conquest\upnp_info.txt"
Type: filesandordirs; Name: "{app}\Empire Earth - The Art of Conquest\_wonHTTPCache" 
; portuguese_brazil create that dir for some reasons (not used)
Type: filesandordirs; Name: "{app}\Empire Earth - The Art of Conquest\Users\default\Civilizações"
; ----------------
Type: filesandordirs; Name: "{app}\Tools\Diagnostic\log.txt"


; Translation Note
; chinese, russian and korean have been translated with a translator and are therefore
; probably of poor quality. If you can check them and suggest improvements that's perfect!
[CustomMessages]
; AntiVirus
AntiVirusWarning=It is highly recommended to disable your AntiVirus before installation.%nBut you should not encounter any problems if you do not disable it.
french.AntiVirusWarning=Il est fortement recommandé de désactiver votre antivirus avant l'installation.%nMais vous ne devriez pas rencontrer de problèmes si vous ne le désactivez pas.
german.AntiVirusWarning=Es wird dringend empfohlen, dass Sie ihr Antivirenprogramm vor der Installation deaktivieren.%nIm Normalfall sollten Sie aber auch keine Probleme haben, wenn Sie es nicht deaktivieren.
italian.AntiVirusWarning=Si consiglia vivamente di disattivare l'AntiVirus prima dell'installazione.%nMa non dovreste incontrare alcun problema se non lo disattivate.
spanish.AntiVirusWarning=Se recomienda encarecidamente desactivar el AntiVirus antes de la instalación.%nPero no debería encontrar ningún problema si no lo deshabilita.
russian.AntiVirusWarning=Настоятельно рекомендуется отключить ваш антивирус перед установкой.%nНо вы не столкнетесь с какими-либо проблемами, если не отключите его.
polish.AntiVirusWarning=Mimo że nie powinieneś napotkać żadnych problemów podczas instalacji.%nZalecamy wyłączyć program antywirusowy przed rozpoczęciem instalacji, w celu uniknięcia dodatkowych problemów.
chinese.AntiVirusWarning=强烈建议在安装前禁用你的反病毒软件。%n但如果你不禁用它，应该不会遇到任何问题。
chinese_traditional.AntiVirusWarning=强烈建议在安装前禁用你的反病毒软件。%n但如果你不禁用它，应该不会遇到任何问题。
korean.AntiVirusWarning=설치하기 전에 바이러스 백신을 사용하지 않도록 설정하는 것이 좋습니다.%n그러나 비활성화하지 않으면 문제가 발생하지 않아야합니다.

; Legal
LegalQuestion=Do you have the original game and its expansion (or Gold Edition) on CD with valid keys or did you purchase the game digitally?
french.LegalQuestion=Avez-vous le jeu original et son extension (ou l'édition Gold) sur CD avec des clés valides ou avez-vous acheté le jeu numériquement ?
german.LegalQuestion=Haben Sie das Originalspiel und seine Erweiterung (oder Gold Edition) auf CD mit gültigen Schlüsseln oder haben Sie das Spiel digital erworben?
italian.LegalQuestion=Hai il gioco originale e la sua espansione (o Gold Edition) su CD con chiavi valide o hai acquistato il gioco in digitale?
spanish.LegalQuestion=¿Tiene el juego original y su expansión (o la Gold Edition) en CD con claves válidas o ha comprado el juego digitalmente?
russian.LegalQuestion=Есть ли у вас оригинальная игра и ее расширение (или Gold Edition) на CD с действующими ключами или вы приобрели игру в цифровом виде?
polish.LegalQuestion=Czy posiadasz oryginalną grę i dodatek (lub Gold Edycję) na CD z kluczami instalacyjnymi, czy też zakupiłeś grę cyfrowo?
chinese.LegalQuestion=你是否有原版游戏及其扩展版（或Gold版）的CD和有效的钥匙，或者你是通过数字方式购买游戏？
chinese_traditional.LegalQuestion=你是否有原版游戏及其扩展版（或Gold版）的CD和有效的钥匙，或者你是通过数字方式购买游戏？
korean.LegalQuestion=유효한 키가 있는 CD에 오리지널 게임과 확장(또는 Gold 에디션)이 있거나 디지털 방식으로 게임을 구입했습니까?

; Portable
PortableQuestion=You are currently running the portable version of the installer. This version is made to allow you to play on removable devices (USB). \
%nAn installation in portable mode cannot be uninstalled, as it is simply a copy of the game files. \
%nIf you don't know what you are doing please use the normal version of the installer. \
%n%nDo you want to continue the installation?
french.PortableQuestion=Vous utilisez actuellement la version portable de l'installateur. Cette version est faite pour vous permettre de jouer sur des périphériques amovibles (USB, etc...). \
%nUne installation en mode portable ne peut pas être désinstallée, car il s'agit simplement d'une copie des fichiers du jeu. \
%nSi vous ne savez pas ce que vous faites, veuillez utiliser la version normal de l'installateur. \
%n%nSouhaitez-vous poursuivre l'installation ?
german.PortableQuestion=Sie führen gerade die tragbare Version des Installationsprogramms aus. Diese Version wurde entwickelt, damit Sie auf Wechseldatenträgern (USB) spielen können. \
%nEine Installation im tragbaren Modus kann nicht deinstalliert werden, da es sich lediglich um eine Kopie der Spieldateien handelt. \
%nWenn Sie nicht wissen, was Sie tun, verwenden Sie bitte die normale Version des Installationsprogramms. \
%n%nMöchten Sie die Installation fortsetzen?
italian.PortableQuestion=Attualmente stai eseguendo la versione portatile del programma di installazione. Questa versione è fatta per permetterti di giocare su dispositivi rimovibili (USB). \
Un'installazione in modalità portatile non può essere disinstallata, in quanto è semplicemente una copia dei file di gioco. \
Se non sai cosa stai facendo, usa la versione normale del programma di installazione. \
%n%nVuoi continuare l'installazione?
spanish.PortableQuestion=Actualmente está ejecutando la versión portátil del instalador. Esta versión está hecha para permitirle jugar en dispositivos extraíbles (USB). \
%nUna instalación en modo portátil no puede ser desinstalada, ya que es simplemente una copia de los archivos del juego. \
%nSi no sabe lo que está haciendo por favor utilice la versión normal del instalador. \
%n%n¿Quiere continuar con la instalación?
russian.PortableQuestion=В настоящее время вы запускаете установку портативной версии игры. Она сделана для того, чтобы вы могли играть на съемных устройствах (USB). \
%nПортативная версия игры не имеет деинсталлятора, так как это просто копия файлов игры. \
%nЕсли вы не знаете, что делаете, пожалуйста, используйте обычную версию программы установки. \
%n%nВы хотите продолжить установку?
polish.PortableQuestion=Uruchomiłeś przenośną wersję instalatora. Ta wersja została stworzona, aby umożliwić Ci grę z pamięci przenośnej (USB). \
%nInstalacji w trybie przenośnym nie można odinstalować za pomocą deinstalatora, ponieważ jest to po prostu kopia plików gry. \
Jeśli nie jesteś pewien decyzji, zalecamy użycie normalnej wersji instalatora. \
%n%nCzy chcesz kontynuować instalację w trybie przenośnym?
chinese.PortableQuestion=你目前运行的是便携式版本的安装程序。这个版本是为了让你在可移动设备（USB）上播放。 \
在便携式模式下的安装程序不能被卸载，因为它只是游戏文件的一个副本。 \
%n如果你不知道你在做什么，请使用普通版本的安装程序。 \
%n%n你想继续安装吗？
chinese_traditional.PortableQuestion=你目前运行的是便携式版本的安装程序。这个版本是为了让你在可移动设备（USB）上播放。 \
在便携式模式下的安装程序不能被卸载，因为它只是游戏文件的一个副本。 \
%n如果你不知道你在做什么，请使用普通版本的安装程序。 \
%n%n你想继续安装吗？
korean.PortableQuestion=현재 설치 프로그램의 휴대용 버전을 실행 중입니다. 이 버전은 이동식 장치(USB)에서 재생할 수 있도록 하기 위해 만들어졌습니다. \
%n휴대용 모드의 설치는 단순히 게임 파일의 복사본이기 때문에 제거 할 수 없습니다. \
%n당신이 무엇을하고 있는지 모르는 경우 설치 프로그램의 일반 버전을 사용하시기 바랍니다. \
%n%n설치를 계속하시겠습니까?
 
; Game Update
GameUpdate=The game included in this setup is not up to date ({#MyAppVersion} => [LAST]), please update or YOU MAY NOT BE ABLE TO PLAY WITH OTHER PLAYERS. \
%n%nWould you like to download the latest version?
french.GameUpdate=Le jeu inclus dans cette installation n'est pas à jour ({#MyAppVersion} => [LAST]), veuillez le mettre à jour ou VOUS POURRIEZ NE PAS ÊTRE EN MESURE DE JOUER AVEC D'AUTRES JOUEURS. \
%n%nVoulez-vous télécharger la dernière version ?
german.GameUpdate=Das in diesem Installationsprogramm enthaltene Spiel ist nicht auf dem neuesten Stand ({#MyAppVersion} => [LAST]), bitte aktualisieren Sie es, SONST KÖNNEN SIE MÖGLICHERWEISE NICHT MIT ANDEREN SPIELERN SPIELEN. \
%n%nWollen Sie die neueste Version herunterladen?
italian.GameUpdate=Il gioco incluso in questo setup non è aggiornato ({#MyAppVersion} => [LAST]), per favore aggiorna o potresti non essere in grado di giocare con altri giocatori. \
%n%nVuoi scaricare l'ultima versione?
spanish.GameUpdate=El juego incluido en esta configuración no está actualizado ({#MyAppVersion} => [LAST]), por favor actualice o NO PODRÁ JUGAR CON OTROS JUGADORES. \
%n%n¿Quiere descargar la última versión?
russian.GameUpdate=Для игры, включенной в эту программу установки, доступно обновление ({#MyAppVersion} => [LAST]). Пожалуйста, обновите или ВЫ НЕ МОЖЕТЕ ИГРАТЬ С ДРУГИМИ ИГРОКАМИ. \
%n%nВы хотите скачать последнюю версию?
polish.GameUpdate=Wersja gry znajdująca się w tym programie instalacyjnym jest nieaktualna ({#MyAppVersion} => [LAST]). Zalecamy aktualizację, w celu rozwiązania problemów i możliwości połączeń multiplayer z innymi graczami. \
%n%nCzy chcesz pobrać teraz najnowszą wersję?
chinese.GameUpdate=这个设置中包含的游戏不是最新的（{#MyAppVersion} => [LAST]），请更新，否则你可能无法与其他玩家一起玩。 \
%n%n你想下载最新的版本吗？
chinese_traditional.GameUpdate=这个设置中包含的游戏不是最新的（{#MyAppVersion} => [LAST]），请更新，否则你可能无法与其他玩家一起玩。 \
%n%n你想下载最新的版本吗？
korean.GameUpdate=이 설정에 포함된 게임은 최신 상태({#MyAppVersion} => [LAST]) 최신 게임이 아니며, 업데이트해 주거나 다른 플레이어와 플레이할 수 없을 수도 있습니다. \
%n%n최신 버전을 다운로드하시겠습니까?
 
; Setup Update
SetupUpdate=The setup is not up to date ({#MySetupVersion} => [LAST]), it is strongly recommended to use the latest version to benefit from the latest fixes and compatibility improvements. \
%n%nWould you like to download the latest version?
french.SetupUpdate=Le programme d'installation n'est pas à jour ({#MySetupVersion} => [LAST]), il est fortement recommandé d'utiliser la dernière version pour bénéficier des dernières corrections et améliorations de compatibilité. \
%n%nVoulez-vous télécharger la dernière version ?
german.SetupUpdate=Das Installationsprogramm ist nicht auf dem neuesten Stand ({#MySetupVersion} => [LAST]). Es wird dringend empfohlen, die neueste Version zu verwenden, um von den neuesten Fehlerkorrekturen und Kompatibilitätsverbesserungen zu profitieren. \
%n%nWollen Sie die neueste Version herunterladen?
italian.SetupUpdate=Il programma di installazione non è aggiornato ({#MySetupVersion} => [LAST]), è fortemente consigliato di usare l'ultima versione per beneficiare delle ultime correzioni e dei miglioramenti di compatibilità. \
%n%nVuoi scaricare l'ultima versione?
spanish.SetupUpdate=El instalador no está actualizado ({#MySetupVersion} => [LAST]), se recomienda encarecidamente utilizar la última versión para beneficiarse de las últimas correcciones y mejoras de compatibilidad. \
%n%n¿Desea descargar la última versión?
russian.SetupUpdate=Для программы установки доступно обновление ({#MySetupVersion} => [LAST]), настоятельно рекомендуется использовать последнюю версию, чтобы воспользоваться последними исправлениями и улучшениями совместимости. \
%n%nВы хотите скачать последнюю версию?
polish.SetupUpdate=Wersja instalatora jest nieaktualna ({#MySetupVersion} => [LAST]). Wysoce zalecamy użycie najnowszej wersji w celu zastosowania najnowszych poprawek i ulepszonej kompatybilności. \
%n%nCzy chcesz pobrać teraz najnowszą wersję instalatora?
chinese.SetupUpdate=安装程序不是最新的（{#MySetupVersion} => [LAST]），强烈建议使用最新的版本以受益于最新的修复和兼容性改进。 \
%n%n你想下载最新的版本吗？
chinese_traditional.SetupUpdate=安装程序不是最新的（{#MySetupVersion} => [LAST]），强烈建议使用最新的版本以受益于最新的修复和兼容性改进。 \
%n%n你想下载最新的版本吗？
korean.SetupUpdate=설치 프로그램은 최신 ({#MySetupVersion} => [LAST]) 최신 버전의 혜택을 누리는 것이 좋습니다. \
%n%n최신 버전을 다운로드하시겠습니까?
  
; AlreadyInstalled
AlreadyInstalled=It seems that {#MyAppName} has already been installed. \
%nIt is recommended that you uninstall and install. \
%nGame saves are KEPT when uninstalling.  \
%n%nDo you want to continue the installation?
french.AlreadyInstalled=Il semble que {#MyAppName} ait déjà été installé. \
%nIl est recommandé de désinstaller et d'installer. \
%nLes sauvegardes de jeu sont CONSERVÉES lors de la désinstallation.  \
%n%nVoulez-vous continuer l'installation ?
german.AlreadyInstalled=Es scheint, dass {#MyAppName} bereits installiert wurde. \
%nEs wird empfohlen, dass Sie deinstallieren und neuinstallieren. \
%nSpielstände werden bei der Deinstallation BEHALTEN.  \
%n%nWollen Sie die Installation fortsetzen?
italian.AlreadyInstalled=Sembra che {#MyAppName} sia già stato installato. \
%nSi raccomanda di disinstallare e installare. \
%nI salvataggi di gioco vengono CONSERVATI quando si disinstalla.  \
%n%nVuoi continuare l'installazione?
spanish.AlreadyInstalled=Parece que {#MyAppName} ya ha sido instalado. \
%nSe recomienda desinstalar e instalar. \
%nLas partidas guardadas se CONSERVAN al desinstalar.  \
%n%n¿Desea continuar con la instalación?
russian.AlreadyInstalled=Кажется, что приложение {#MyAppName} уже установлено. \
%nРекомендуется удалить и переустановить. \
%nСохранения игры НЕ БУДУТ УДАЛЕНЫ при деинсталляции.  \
%n%nВы хотите продолжить установку?
polish.AlreadyInstalled=Wygląda na to, że {#MyAppName} został już zainstalowany. \
%nZalecane jest ręczne odinstalowanie i ponowne uruchomienie programu instalacyjnego. \
%nPodczas odinstalowywania zapisy gry zostają ZACHOWANE. \
%n%nCzy mimo to, chcesz kontynuować instalację?
chinese.AlreadyInstalled=似乎{#MyAppName}已经被安装了。 \
建议您卸载并安装。 \
%n当卸载时，游戏保存被保留。 \
%n%n你想继续安装吗？
chinese_traditional.AlreadyInstalled=似乎{#MyAppName}已经被安装了。 \
建议您卸载并安装。 \
%n当卸载时，游戏保存被保留。 \
%n%n你想继续安装吗？
korean.AlreadyInstalled={#MyAppName}가 이미 설치된 것 같습니다. \
%n제거 하 고 설치 하는 것이 좋습니다. \
%n게임 저장은 제거 할 때 유지됩니다. \
%n%n설치를 계속하시겠습니까?
 
UserInstallMode=You are using the user mode installation, which means that you will not need administrator rights for the installation. \
%nPlease note that this mode is not able to register the game with the computer's firewall, which may prevent you from hosting games (but you should still be able to join games). \
%nIf you have administrator rights on the machine, prefer the administrator mode.
french.UserInstallMode=Vous utilisez l'installation en mode utilisateur, ce qui signifie que vous n'aurez pas besoin de droits d'administrateur pour l'installation. \
%nVeuillez noter que ce mode n'est pas en mesure d'enregistrer le jeu auprès du pare-feu de l'ordinateur, ce qui peut vous empêcher d'héberger des parties (mais vous devriez toujours pouvoir rejoindre des parties). \
%n%nSi vous avez des droits administrateur sur la machine, préférez le mode administrateur.
german.UserInstallMode=Sie verwenden die Installation im Benutzermodus, was bedeutet, dass Sie für die Installation keine Administratorrechte benötigen. \
Bitte beachten Sie, dass dieser Modus nicht in der Lage ist, das Spiel bei der Firewall des Computers zu registrieren, was Sie möglicherweise daran hindert, Spiele zu veranstalten (Sie sollten aber trotzdem in der Lage sein, Spielen beizutreten). \
%nWenn Sie über Administratorrechte auf dem Computer verfügen, wählen Sie den Administratormodus.
italian.UserInstallMode=Stai usando l'installazione in modalità utente, il che significa che non avrai bisogno dei diritti di amministratore per l'installazione. \
%nNota che questa modalità non è in grado di registrare il gioco con il firewall del computer, il che potrebbe impedirti di ospitare le partite (ma dovresti comunque essere in grado di partecipare alle partite). \
%nSe hai i diritti di amministratore sulla macchina, preferisci la modalità amministratore.
spanish.UserInstallMode=Está utilizando la instalación en modo usuario, lo que significa que no necesitará derechos de administrador para la instalación. \
%nTenga en cuenta que este modo no es capaz de registrar el juego con el cortafuegos del ordenador, lo que puede impedirle alojar partidas (pero debería poder unirse a ellas). \
%nSi tienes derechos de administrador en la máquina, prefiere el modo administrador.
russian.UserInstallMode=Вы используете установку в режиме пользователя, что означает, что вам не нужны права администратора для установки. \
%nПримите во внимание, что этот режим не может зарегистрировать игру в брандмауэре компьютера, что может помешать вам проводить игры (но вы все равно должны иметь возможность присоединяться к играм). \
%nЕсли у вас есть права администратора на компьютере, предпочитайте режим администратора.
polish.UserInstallMode=Używasz instalacji w trybie użytkownika, co oznacza, że nie będziesz potrzebował praw administratora do instalacji. \
%nNależy pamiętać, że ten tryb nie jest w stanie zarejestrować gry w zaporze sieciowej komputera, co może uniemożliwić organizowanie gier (ale nadal powinieneś mieć możliwość dołączania do gier). \
%nJeśli masz prawa administratora na komputerze, wybierz tryb administratora.
chinese.UserInstallMode=你使用的是用户模式安装，这意味着你不需要管理员权限就可以安装。 \
%n请注意，这种模式不能在计算机的防火墙上注册游戏，这可能会妨碍你主持游戏（但你应该仍然能够加入游戏）。 \
%n如果你在机器上有管理员权限，请选择管理员模式。
chinese_traditional.UserInstallMode=你使用的是用户模式安装，这意味着你不需要管理员权限就可以安装。 \
%n请注意，这种模式不能在计算机的防火墙上注册游戏，这可能会妨碍你主持游戏（但你应该仍然能够加入游戏）。 \
%n如果你在机器上有管理员权限，请选择管理员模式。
korean.UserInstallMode=사용자 모드 설치를 사용하고 있으므로 설치에 대한 관리자 권한이 필요하지 않습니다. \
%n이 모드는 컴퓨터의 방화벽으로 게임을 등록할 수 없으며, 이는 게임을 호스팅하는 것을 방지할 수 있습니다(하지만 여전히 게임에 참여할 수 있어야 합니다). \
%n컴퓨터에 관리자 권한이 있는 경우 관리자 모드를 선호합니다.

; Sound Control
; Since our custom button isn't auto scaled to content
; better keep Mute / Unmute, tiny and everyone should understand 
SoundCtrlButtonCaptionSoundOn=Unmute 
SoundCtrlButtonCaptionSoundOff=Mute 

[Messages]
; Remplacing InnoSetup Password Label when using password for encryption
PasswordLabel3=Please write '{#MySetupPassword}' (case-sensitive), then click Next to continue.
IncorrectPassword=The password you entered is not correct. Please enter '{#MySetupPassword}' (case-sensitive).
french.PasswordLabel3=Veuillez saisir '{#MySetupPassword}' (attention à la distinction entre majuscules et minuscules) puis cliquez sur Suivant pour continuer.
french.IncorrectPassword=Le mot de passe saisi n'est pas valide. Merci de saisir '{#MySetupPassword}'.
german.PasswordLabel3=Bitte geben Sie '{#MySetupPassword}' ein, und klicken Sie danach auf Weiter. Achten Sie auf korrekte Groß- und Kleinschreibung. 
german.IncorrectPassword=Das eingegebene Passwort ist nicht korrekt. Bitte geben Sie '{#MySetupPassword}' noch einmal ein.
italian.PasswordLabel3=Inserire '{#MySetupPassword}', poi premere Avanti per continuare. Le password sono sensibili alle maiuscole/minuscole.
italian.IncorrectPassword=La password inserita non è corretta, riprovare. Inserisci '{#MySetupPassword}'.
spanish.PasswordLabel3=Por favor, introduzca '{#MySetupPassword}', y haga clic en Siguiente para continuar. La contraseña distingue entre mayúsculas y minúsculas
spanish.IncorrectPassword=La contraseña ingresada no es correcta. Por favor, introduzca '{#MySetupPassword}'.
russian.PasswordLabel3=Пожалуйста, введите '{#MySetupPassword}' (с учетом регистра), затем нажмите Далее, чтобы продолжить.
russian.IncorrectPassword=Введенный вами пароль неверен. Пожалуйста, введите '{#MySetupPassword}' (с учетом регистра).
polish.PasswordLabel3=Proszę wpisać '{#MySetupPassword}' (z uwzględnieniem wielkości liter), a następnie kliknąć 'Dalej', aby kontynuować.
polish.IncorrectPassword=Wprowadzone hasło jest nieprawidłowe. Proszę wpisać '{#MySetupPassword}' (z uwzględnieniem wielkości liter).
chinese.PasswordLabel3=请写上'{#MySetupPassword}'（区分大小写），然后点击下一步继续。
chinese.IncorrectPassword=你输入的密码不正确。请输入'{#MySetupPassword}'（区分大小写）。
chinese_traditional.PasswordLabel3=请写上'{#MySetupPassword}'（区分大小写），然后点击下一步继续。
chinese_traditional.IncorrectPassword=你输入的密码不正确。请输入'{#MySetupPassword}'（区分大小写）。
korean.PasswordLabel3='{#MySetupPassword}'(사례 에 민감한)를 작성한 다음 다음을 클릭하여 계속하십시오.
korean.IncorrectPassword=입력한 암호가 올바르지 않습니다. '{#MySetupPassword}'(사례 에 민감한)를 입력하십시오.
; BeveledLabel=Little message at the bottom of the setup in case we want but it's ugly

[Run]
; Add Cert in Windows Trusted Root CA Store
#if SignSetup
  Filename: "{sys}\certutil.exe"; Parameters: "-addstore root ""{tmp}\{#CertFileName}"""; Flags: runhidden; Tasks: certinclude; \
    StatusMsg: "Adding Empire Earth Community Certificate Authority (issued by EnergyCube)"; MinVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
  Filename: "{sys}\certutil.exe"; Parameters: "-user -addstore root ""{tmp}\{#CertFileName}"""; Flags: runhidden; Tasks: certinclude; \
    StatusMsg: "Adding Empire Earth Community Certificate Authority (issued by EnergyCube)"; MinVersion: 0,6.0; Components: game; Check: not IsAdminInstallMode
#endif

; Install DirectPlay (Never tested on x86) ({sys}\dism.exe should work)
; Disabled because seems useless
; Filename: "{win}\System32\dism.exe"; Parameters: "/Online /Enable-Feature /FeatureName:""DirectPlay"" /all /NoRestart"; Flags: runhidden; StatusMsg: "Installing DirectPlay"; \
;	MinVersion: 0,6.2; Tasks: directplay; Check: Is64BitInstallMode and IsAdminInstallMode
; Filename: "{win}\sysnative\dism.exe"; Parameters: "/Online /Enable-Feature /FeatureName:""DirectPlay"" /all /NoRestart"; Flags: runhidden; StatusMsg: "Installing DirectPlay"; \
;	MinVersion: 0,6.2; Tasks: directplay; Check: not Is64BitInstallMode and IsAdminInstallMode

; FireWall Remover (Copy from [UninstallRun] to remove previous entry in case it was missconfigured)
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule program=""{app}\Empire Earth\Empire Earth.exe"" name=all"; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} in Firewall"; Tasks: firewallexception; MinVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule program=""{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"" name=all"; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} : AoC in Firewall"; Tasks: firewallexception; MinVersion: 0,6.0; Components: gameaoc; Check: IsAdminInstallMode

; Old Windows FireWall (advfirewall is only available from Vista)
Filename: "{sys}\netsh.exe"; Parameters: "firewall delete portopening protocol=ALL port=33334"; Flags: runhidden runascurrentuser; StatusMsg: "Removing {#MyAppName} Port in Firewall"; \
  Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "firewall delete portopening protocol=ALL port=33335"; Flags: runhidden runascurrentuser; StatusMsg: "Removing {#MyAppName} Port in Firewall"; \
  Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "firewall delete portopening protocol=ALL port=33336"; Flags: runhidden runascurrentuser; StatusMsg: "Removing {#MyAppName} Port in Firewall"; \
  Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: game; Check: IsAdminInstallMode

Filename: "{sys}\netsh.exe"; Parameters: "firewall delete allowedprogram ""{app}\Empire Earth\Empire Earth.exe"""; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} in Firewall"; Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "firewall delete allowedprogram ""{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"""; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} : AoC in Firewall"; Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: gameaoc; Check: IsAdminInstallMode


; FireWall Register
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} - TCP - Out"" program=""{app}\Empire Earth\Empire Earth.exe"" protocol=TCP dir=out action=allow enable=yes localport=any"; \
  Flags: runhidden; Tasks: firewallexception;StatusMsg: "Opening Empire Earth in Firewall"; MinVersion: 0,6.0; Components: game; Check: IsAdminInstallMode 
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} - TCP - In"" program=""{app}\Empire Earth\Empire Earth.exe"" protocol=TCP dir=in action=allow enable=yes localport=any"; \
  Flags: runhidden; Tasks: firewallexception; StatusMsg: "Opening Empire Earth in Firewall"; MinVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} - UDP - Out"" program=""{app}\Empire Earth\Empire Earth.exe"" protocol=UDP dir=out action=allow enable=yes localport=any"; \
  Flags: runhidden; Tasks: firewallexception; StatusMsg: "Opening Empire Earth in Firewall"; MinVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} - UDP - In"" program=""{app}\Empire Earth\Empire Earth.exe"" protocol=UDP dir=in action=allow enable=yes localport=any"; \
  Flags: runhidden; Tasks: firewallexception; StatusMsg: "Opening Empire Earth in Firewall"; MinVersion: 0,6.0; Components: game; Check: IsAdminInstallMode

Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} - AoC - TCP - Out"" program=""{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"" protocol=TCP dir=out action=allow enable=yes localport=any"; \
  Flags: runhidden; Tasks: firewallexception; StatusMsg: "Opening Empire Earth : AoC in Firewall"; MinVersion: 0,6.0; Components: gameaoc; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} - AoC - TCP - In"" program=""{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"" protocol=TCP dir=in action=allow enable=yes localport=any"; \
  Flags: runhidden; Tasks: firewallexception; StatusMsg: "Opening Empire Earth : AoC in Firewall"; MinVersion: 0,6.0; Components: gameaoc; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} - AoC - UDP - Out"" program=""{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"" protocol=UDP dir=out action=allow enable=yes localport=any"; \
  Flags: runhidden; Tasks: firewallexception; StatusMsg: "Opening Empire Earth : AoC in Firewall"; MinVersion: 0,6.0; Components: gameaoc; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} - AoC - UDP - In"" program=""{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"" protocol=UDP dir=in action=allow enable=yes localport=any"; \
  Flags: runhidden; Tasks: firewallexception; StatusMsg: "Opening Empire Earth : AoC in Firewall"; MinVersion: 0,6.0; Components: gameaoc; Check: IsAdminInstallMode

; Old Windows FireWall (advfirewall is only available from Vista)
Filename: "{sys}\netsh.exe"; Parameters: "firewall add portopening protocol=ALL port=33334 name=""{#MyAppName} Port 33334"""; Flags: runhidden; \
  StatusMsg: "Opening {#MyAppName} Port in Firewall"; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Tasks: firewallexception; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "firewall add portopening protocol=ALL port=33335 name=""{#MyAppName} Port 33335"""; Flags: runhidden; \
  StatusMsg: "Opening {#MyAppName} Port in Firewall"; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Tasks: firewallexception; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "firewall add portopening protocol=ALL port=33336 name=""{#MyAppName} Port 33336"""; Flags: runhidden; \
  StatusMsg: "Opening {#MyAppName} Port in Firewall"; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Tasks: firewallexception; Components: game; Check: IsAdminInstallMode

Filename: "{sys}\netsh.exe"; Parameters: "firewall add allowedprogram program=""{app}\Empire Earth\Empire Earth.exe"" name=""{#MyAppName}"" mode=ENABLE"; \
  Flags: runhidden; StatusMsg: "Opening {#MyAppName} in Firewall"; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Tasks: firewallexception; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "firewall add allowedprogram program=""{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"" name=""{#MyAppName} - AoC"" mode=ENABLE"; \
  Flags: runhidden; StatusMsg: "Opening {#MyAppName} : AoC in Firewall"; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Tasks: firewallexception; Components: gameaoc; Check: IsAdminInstallMode

; DX9 Setup
Filename: "{tmp}\DirectX_9\DXSETUP.exe"; Parameters: "/silent"; Flags: runhidden; \
    StatusMsg: "Installing DirectX 9..."; MinVersion: 0,5.0; Components: additional\directx_wrapper\dx9; Check: IsAdminInstallMode

#if InstallType == "NeoEE"
  // NeoEE CDKeys Regedit Hell
  // HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Sierra\CDKeys
  // HKEY_LOCAL_MACHINE\Software\Sierra\CDKeys
  Filename: "{tmp}\authtools.exe"; Parameters: "-eec={app}\Empire Earth, -authserv=neoee.net, -port=10003"; Flags: runhidden; \
    StatusMsg: "Register Empire Earth NeoEE CDKey"; MinVersion: 0,5.0; Tasks: neoee_cdkeys; Components: game and not gameaoc;
  Filename: "{tmp}\authtools.exe"; Parameters: "-eec={app}\Empire Earth, -aoc={app}\Empire Earth - The Art of Conquest, -authserv=neoee.net, -port=10003"; Flags: runhidden; \
    StatusMsg: "Register Empire Earth Neo EE & AoC CDKey"; MinVersion: 0,5.0; Tasks: neoee_cdkeys; Components: game and gameaoc;
#endif

[UninstallRun]
; Uninstall DirectPlay
; Disabled because seems useless
; Filename: "{win}\System32\dism.exe"; Parameters: "/Online /Disable-Feature /FeatureName:""DirectPlay"" /NoRestart"; Flags: runhidden runascurrentuser; \
;	StatusMsg: "Uninstalling DirectPlay"; MinVersion: 0,6.2; Tasks: directplay; Check: Is64BitInstallMode and IsAdminInstallMode
; Filename: "{win}\sysnative\dism.exe"; Parameters: "/Online /Disable-Feature /FeatureName:""DirectPlay"" /NoRestart"; Flags: runhidden runascurrentuser; \
;	StatusMsg: "Uninstalling DirectPlay"; MinVersion: 0,6.2; Tasks: directplay; Check: not Is64BitInstallMode and IsAdminInstallMode

; FireWall
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule program=""{app}\Empire Earth\Empire Earth.exe"" name=all"; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} in Firewall"; Tasks: firewallexception; MinVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule program=""{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"" name=all"; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} : AoC in Firewall"; Tasks: firewallexception; MinVersion: 0,6.0; Components: gameaoc; Check: IsAdminInstallMode

; Old Windows FireWall (advfirewall is only available from Vista)
Filename: "{sys}\netsh.exe"; Parameters: "firewall delete portopening protocol=ALL port=33334"; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} Port in Firewall"; Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "firewall delete portopening protocol=ALL port=33335"; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} Port in Firewall"; Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "firewall delete portopening protocol=ALL port=33336"; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} Port in Firewall"; Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: game; Check: IsAdminInstallMode

Filename: "{sys}\netsh.exe"; Parameters: "firewall delete allowedprogram ""{app}\Empire Earth\Empire Earth.exe"""; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} in Firewall"; Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: game; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "firewall delete allowedprogram ""{app}\Empire Earth - The Art of Conquest\EE-AOC.exe"""; Flags: runhidden runascurrentuser; \
  StatusMsg: "Removing {#MyAppName} : AoC in Firewall"; Tasks: firewallexception; MinVersion: 0,5.0; OnlyBelowVersion: 0,6.0; Components: gameaoc; Check: IsAdminInstallMode

[Code]
// Since the setup need to work from 98 to 11 trying to use ssl would be a disaster
// So we will use HTTP only, GameVersionURL and SetupVersionURL URLs need to accept HTTP 
const
  SetupURL = 'http://empireearth.eu/download';
#if InstallType == "EE"
  GameVersionURL = '/setup/game/game.version';
  SetupVersionURL = '/setup/game/setup.version';
#elif InstallType == "NeoEE"
  GameVersionURL = '/setup/game/neo/game.version';
  SetupVersionURL = '/setup/game/neo/setup.version';
#else
  #error "Update not supported !"
#endif

// Audio Module
#if AudioModule
  const  
    BASS_SAMPLE_LOOP = 4;
    BASS_UNICODE = $80000000;
    BASS_ACTIVE_STOPPED = 0;
    BASS_ACTIVE_PLAYING = 1;
    BASS_ACTIVE_STALLED = 2;
    BASS_ACTIVE_PAUSED  = 3;
    BASS_CONFIG_GVOL_STREAM = 5;
  const
    #ifndef UNICODE
      EncodingFlag = 0;
    #else
      EncodingFlag = BASS_UNICODE;
    #endif
  type
    HSTREAM = DWORD;

  function BASS_Init(device: LongInt; freq, flags: DWORD; 
    win: HWND; clsid: Cardinal): BOOL;
    external 'BASS_Init@files:bass.dll stdcall';
  function BASS_StreamCreateFile(mem: BOOL; f: string; offset1: DWORD; 
    offset2: DWORD; length1: DWORD; length2: DWORD; flags: DWORD): HSTREAM;
    external 'BASS_StreamCreateFile@files:bass.dll stdcall';
  function BASS_Start: BOOL;
    external 'BASS_Start@files:bass.dll stdcall';
  function BASS_Pause: BOOL;
    external 'BASS_Pause@files:bass.dll stdcall';
  function BASS_ChannelPlay(handle: DWORD; restart: BOOL): BOOL; 
    external 'BASS_ChannelPlay@files:bass.dll stdcall';
  function BASS_SetConfig(option: DWORD; value: DWORD ): BOOL;
    external 'BASS_SetConfig@files:bass.dll stdcall';
  function BASS_ChannelIsActive(handle: DWORD): DWORD;
    external 'BASS_ChannelIsActive@files:bass.dll stdcall';
  function BASS_Free: BOOL;
    external 'BASS_Free@files:bass.dll stdcall';
  
  var
	InitBass: Boolean;
	SoundStream: HSTREAM;
    Muted: Boolean;
    SoundCtrlButton: TNewButton;
#endif

type
  TIntegerArray = array of Integer;
  TCompareResult = (
    crLesser,
    crEquals,
    crGreater
  );

function Max(A, B: Integer): Integer;
begin
  if A > B then Result := A else Result := B;
end;

function CompareValue(A, B: Integer): TCompareResult;
begin
  if A = B then
    Result := crEquals
  else
  if A < B then
    Result := crLesser
  else
    Result := crGreater;
end;

function AddVersionChunk(const S: string; var A: TIntegerArray): Integer;
var
  Chunk: Integer;
begin
  Chunk := StrToIntDef(S, -1);
  if Chunk <> -1 then
  begin 
    Result := GetArrayLength(A) + 1;
    SetArrayLength(A, Result);
    A[Result - 1] := Chunk;
  end
  else
    RaiseException('Invalid format of version string');
end;

function ParseVersionStr(const S: string; var A: TIntegerArray): Integer;
var
  I: Integer;
  Count: Integer;
  Index: Integer;
begin
  Count := 0;
  Index := 1;

  for I := 1 to Length(S) do
  begin
    case S[I] of
      '.':
      begin
        AddVersionChunk(Copy(S, Index, Count), A);
        Count := 0;
        Index := I + 1;
      end;
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
      begin
        Count := Count + 1;
      end;
    else
      RaiseException('Invalid char in version string');
    end;
  end;
  Result := AddVersionChunk(Copy(S, Index, Count), A);
end;

function GetVersionValue(const A: TIntegerArray; Index,
  Length: Integer): Integer;
begin
  Result := 0;
  if (Index >= 0) and (Index < Length) then
    Result := A[Index];
end;

function CompareVersionStr(const A, B: string): TCompareResult;
var
  I: Integer;
  VerLenA, VerLenB: Integer;
  VerIntA, VerIntB: TIntegerArray;
begin
  Result := crEquals;

  VerLenA := ParseVersionStr(A, VerIntA);
  VerLenB := ParseVersionStr(B, VerIntB);

  for I := 0 to Max(VerLenA, VerLenB) - 1 do
  begin
    Result := CompareValue(GetVersionValue(VerIntA, I, VerLenA),
      GetVersionValue(VerIntB, I, VerLenB));
    if Result <> crEquals then
      Exit;
  end;
end;

function DownloadFile(const URL: string; var Response: string): Boolean;
var
  WinHttpRequest: Variant;
begin
  Result := True;
  try
    WinHttpRequest := CreateOleObject('WinHttp.WinHttpRequest.5.1');
    WinHttpRequest.Open('GET', URL, False);
    WinHttpRequest.Send;
    Response := WinHttpRequest.ResponseText;
  except
    Result := False;
    Response := GetExceptionMessage;
  end;
end;

function GetCompatibilityFlags(Param: String): String;
begin
  Result :=  '~'

  if IsTaskSelected('everyoneadminstart') then
  begin
    Result := Result + ' RUNASADMIN'; 
  end;

  if IsTaskSelected('compatibility') then
  begin
    Result := Result + ' DWM8And16BitMitigation HIGHDPIAWARE HeapClearAllocation';
  end;
end;

function GetInstallDriveLetter(Param: String): String;
begin
  Result := copy(ExpandConstant('{app}'), 1, 2);
end;

function GetInstallWithoutDriveLetter(Param: String): String;
var
  S : String;
begin
  S := ExpandConstant('{app}');
  delete(S, 1, 2);
  Result := S;
end;

function IsWine(): Boolean;
begin
  Result := False;
  if FileExists(GetEnv('winsysdir') + '\winecfg.exe') then
    Result := True;
  if RegKeyExists(HKEY_CURRENT_USER, 'Software\Wine') then   
    Result := True;
  if RegKeyExists(HKEY_LOCAL_MACHINE, 'Software\Wine') then   
    Result := True; 
end;

function GetInstallWithoutDriveLetterBase(Param: String): String;
begin
    Result := UpperCase(GetInstallWithoutDriveLetter(Param));
end;

// Return True when update dialog return yes (= exit setup & open web page)
function CheckUpdate: Boolean;
var
  LocalVersion: String;
  LatestVersion: String;
  UpdateMsg: String;
  UpdateAlreadyWarned: Bool;
  ErrorCode : Integer;
begin
  Result := False;
  // Update Check
  // (UpdateAlreadyWarned) No need to double warn since, a game update will also produce a setup update anyway
  if DownloadFile('http://{#UpdateUrl}' + GameVersionURL, LatestVersion) or DownloadFile('http://{#UpdateUrlMirror}' + GameVersionURL, LatestVersion) then
  begin
    LocalVersion := ExpandConstant('{#MyAppVersion}');
    if CompareVersionStr(LatestVersion, LocalVersion) = crGreater then
    begin
      UpdateMsg := ExpandConstant('{cm:GameUpdate}');
      StringChangeEx(UpdateMsg, '[LAST]', LatestVersion, False);
      if MsgBox(UpdateMsg, mbError, MB_YESNO) = IDYES then
      begin
        ShellExec('', SetupURL, '', '', SW_SHOW, ewNoWait, ErrorCode);
        Result := True;
        Exit;
      end;
      UpdateAlreadyWarned := True;
    end;
  end;

  if (not UpdateAlreadyWarned) then
  begin
    if DownloadFile('http://{#UpdateUrl}' + SetupVersionURL, LatestVersion) or DownloadFile('http://{#UpdateUrlMirror}' + SetupVersionURL, LatestVersion) then
    begin
      LocalVersion := ExpandConstant('{#MySetupVersion}');
      if CompareVersionStr(LatestVersion, LocalVersion) = crGreater then
      begin
        UpdateMsg := ExpandConstant('{cm:SetupUpdate}');
        StringChangeEx(UpdateMsg, '[LAST]', LatestVersion, False);
        if MsgBox(UpdateMsg, mbError, MB_YESNO) = IDYES then
        begin
          ShellExec('', SetupURL, '', '', SW_SHOW, ewNoWait, ErrorCode);
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;

#if AudioModule
  procedure SoundCtrlButtonClick(Sender: TObject);
  begin
    if not Muted then
    begin
      if BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, 0) then
      begin
        SoundCtrlButton.Caption := ExpandConstant('{cm:SoundCtrlButtonCaptionSoundOn}');
        Muted := True;
      end;
    end
      else
    begin
      if BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, 2500) then
      begin
        SoundCtrlButton.Caption := ExpandConstant('{cm:SoundCtrlButtonCaptionSoundOff}');
        Muted := False;
      end;
    end;
  end;
#endif


function InitializeSetup: Boolean;
var
  ErrorCode : Integer;
begin

  try
    if (WizardSupressMsgBoxes = False) then
      if (CheckUpdate()) then
        Exit;
  except
    MsgBox('Unnable to check update!', mbError, MB_OK);
  end;
  
  // Already Installed
  if (WizardSupressMsgBoxes = False) and
    #if InstallType == "EE"
      // EE
      ( RegValueExists(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{4C0B46D8-E7EB-4B95-97D4-A578D9B914C6}_is1', 'UninstallString')
      or
        RegValueExists(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{4C0B46D8-E7EB-4B95-97D4-A578D9B914C6}_is1', 'UninstallString')
      or 
        // Retail EE InstallShield Setup
        RegValueExists(HKEY_CURRENT_USER, 'SOFTWARE\WOW6432Node\Sierra OnLine\Setup\EEARTH', 'Directory'))      
    #elif InstallType == "NeoEE"
      // NeoEE
      (RegValueExists(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{A24FCC7A-5491-4FEA-837B-4E4430C349DA}_is1', 'UninstallString')
      or
       RegValueExists(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{A24FCC7A-5491-4FEA-837B-4E4430C349DA}_is1', 'UninstallString'))
    #endif
    then
    begin
      if MsgBox(ExpandConstant('{cm:AlreadyInstalled}'), mbInformation, MB_YESNO) = IDNO then
      begin
        Exit;
      end;
    end
  else if (WizardSupressMsgBoxes = False) then
  begin
    // Legal Question
    if MsgBox(ExpandConstant('{cm:LegalQuestion}'), mbConfirmation, MB_YESNO) = IDNO then
    begin
      ShellExec('', 'https://www.gog.com/game/empire_earth_gold_edition', '', '', SW_SHOW, ewNoWait, ErrorCode);
      Exit;
    end;
  end;

  #if TestID != 0
    // Test Warning
    if WizardSupressMsgBoxes = False then
      MsgBox('THIS IS A TEST SETUP ID = {#TestID} [Setup v{#MySetupVersion} - Game v{#MyAppVersion}]' + #13#10 + 'PLEASE USE THIS INSTALLER ONLY FOR TESTING' + #13#10 + 'DO >>NOT<< SHARE IT!' , mbInformation, MB_OK);
  #endif
  
  // AntiVirus/Portable/User Warning
  if (WizardSupressMsgBoxes = False) then
  begin
    if IsAdminInstallMode then
    begin
      MsgBox(ExpandConstant('{cm:AntiVirusWarning}'), mbInformation, MB_OK);
    end
    else if (ExpandConstant('{#InstallMode}') = 'Portable') then
    begin
      if MsgBox(ExpandConstant('{cm:PortableQuestion}'), mbConfirmation, MB_YESNO) = IDNO then
        Exit;
    end
    else begin
      MsgBox(ExpandConstant('{cm:UserInstallMode}'), mbInformation, MB_OK);
    end;
  end;
  
  #if InstallType == "NeoEE"
    // Wine Environment Detection
    if IsWine() and (WizardSupressMsgBoxes = False) then
      MsgBox('Wine Detected !' + #13#10 + 'NeoEE connection GUI which causes the game to crash because it uses GDI will be disabled.', mbInformation, MB_OK);
  #endif
  
  #if AudioModule
    if (WizardSupressMsgBoxes = False) then
      begin
      ExtractTemporaryFile('Loop.flac');
	  InitBass := BASS_Init(-1, 44100, 0, 0, 0);
      if InitBass then
      begin
        SoundStream := BASS_StreamCreateFile(False, 
          ExpandConstant('{tmp}\Loop.flac'), 0, 0, 0, 0, 
          EncodingFlag or BASS_SAMPLE_LOOP);
        BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, 2500);
	  end;
	end;
  #endif
  
  Result :=  True;
end;

function IsAnotherGameInstalled(Params: String): Boolean;
begin
  Result := False;

  #if InstallType == "EE"
      // EE
      if RegValueExists(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{A24FCC7A-5491-4FEA-837B-4E4430C349DA}_is1', 'UninstallString')
      or RegValueExists(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{A24FCC7A-5491-4FEA-837B-4E4430C349DA}_is1', 'UninstallString')
      then begin
        Result := True;
      end;
  #elif InstallType == "NeoEE"
      // NeoEE
      if RegValueExists(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{4C0B46D8-E7EB-4B95-97D4-A578D9B914C6}_is1', 'UninstallString')
      or RegValueExists(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{4C0B46D8-E7EB-4B95-97D4-A578D9B914C6}_is1', 'UninstallString')
      then begin
        Result := True;
      end;
  #endif

end;

function IsAnotherGameInstalledWithCertificate: Boolean;
var
  Tmp: String;
begin
  Result := False;
  #if InstallType == "EE"
      // EE

      if not IsAdminInstallMode and RegQueryStringValue(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{A24FCC7A-5491-4FEA-837B-4E4430C349DA}_is1', 'Inno Setup: Selected Tasks', Tmp)
      then begin
        if Pos('certinclude', Tmp) > 0 then
        begin
          Result := True;
          exit;
        end;
      end;

      if IsAdminInstallMode and RegQueryStringValue(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{A24FCC7A-5491-4FEA-837B-4E4430C349DA}_is1', 'Inno Setup: Selected Tasks', Tmp)
      then begin
        if Pos('certinclude', Tmp) > 0 then
        begin
          Result := True;
          exit;
        end;
      end;
  #elif InstallType == "NeoEE"
      // NeoEE
      if not IsAdminInstallMode and RegQueryStringValue(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{4C0B46D8-E7EB-4B95-97D4-A578D9B914C6}_is1', 'Inno Setup: Selected Tasks', Tmp)
      then begin   
        if Pos('certinclude', Tmp) > 0 then
        begin
          Result := True;
          exit;
        end;
      end;

      if IsAdminInstallMode and RegQueryStringValue(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{4C0B46D8-E7EB-4B95-97D4-A578D9B914C6}_is1', 'Inno Setup: Selected Tasks', Tmp)
      then begin   
        if Pos('certinclude', Tmp) > 0 then
        begin
          Result := True;
          exit;
        end;
      end;
  #endif  
end;

function WizardIsComponentSelectedCompatible(Compo: String): Boolean;
var
  Tmp: String;
begin
  Result := False;
  #if InstallType == "EE"
      // EE
      if RegQueryStringValue(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{4C0B46D8-E7EB-4B95-97D4-A578D9B914C6}_is1', 'Inno Setup: Selected Tasks', Tmp)
      then begin   
        if Pos(Compo, Tmp) > 0 then
        begin
          Result := True;
          exit;
        end;
      end;

      if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{4C0B46D8-E7EB-4B95-97D4-A578D9B914C6}_is1', 'Inno Setup: Selected Tasks', Tmp)
      then begin   
        if Pos(Compo, Tmp) > 0 then
        begin
          Result := True;
          exit;
        end;
      end;
      
  #elif InstallType == "NeoEE"
      // NeoEE
      if RegQueryStringValue(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{A24FCC7A-5491-4FEA-837B-4E4430C349DA}_is1', 'Inno Setup: Selected Tasks', Tmp)
      then begin
        if Pos(Compo, Tmp) > 0 then
        begin
          Result := True;
          exit;
        end;
      end;

      if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{A24FCC7A-5491-4FEA-837B-4E4430C349DA}_is1', 'Inno Setup: Selected Tasks', Tmp)
      then begin
        if Pos(Compo, Tmp) > 0 then
        begin
          Result := True;
          exit;
        end;
      end;
  #endif  
end;

#if CertInclude
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  ErrorCode: Integer;
begin
  if (CurUninstallStep = usUninstall) and (WizardIsComponentSelectedCompatible('certinclude')) then begin
    if IsAdminInstallMode and not IsAnotherGameInstalledWithCertificate then
    begin
      Exec(ExpandConstant('{sys}\certutil.exe'), '-delstore root ""{#CertHashSHA1}"""', '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
    end
    else if not IsAnotherGameInstalledWithCertificate and not IsAdminInstallMode then
    begin
      Exec(ExpandConstant('{sys}\certutil.exe'), '-user -delstore root ""{#CertHashSHA1}""', '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
    end;
  end;
end;
#endif

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  
  // Register files after components page
  if (CurPageID = wpSelectComponents) then
	begin

    // Register Online Files (Game default is in english, online files will recover the located one if asked)
    // Mirror Order
    // EE Community HTTPS (Energy) => Zocker HTTPS => EE Community HTTP (Energy) => Zocker HTTP
    // Storage Localized structure : {base_url}/localized/{language}/{GameType}/
    // Note: EELearningCampaign.ssa is the same for AoC, the setup will copy the one of EE
    
    // Clears files if the user have the bad idea of going back to component to change them
    idpClearFiles();

    // EE Community Server HTTPS
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Language.dll'), ExpandConstant('{tmp}\EE\Language.dll'), 'game\update'); 
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/data.ssa'), ExpandConstant('{tmp}\EE\Data\data.ssa'), 'game\update');
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EELearningCampaign.ssa'), ExpandConstant('{tmp}\EE\Data\Campaigns\EELearningCampaign.ssa'), 'game\update');
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheBritish.ssa'), ExpandConstant('{tmp}\EE\Data\Campaigns\EETheBritish.ssa'), 'game\update');
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheFuture.ssa'), ExpandConstant('{tmp}\EE\Data\Campaigns\EETheFuture.ssa'), 'game\update');
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGermans.ssa'), ExpandConstant('{tmp}\EE\Data\Campaigns\EETheGermans.ssa'), 'game\update'); 
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGreeks.ssa'), ExpandConstant('{tmp}\EE\Data\Campaigns\EETheGreeks.ssa'), 'game\update');
    if (IsComponentSelected('additional\movies')) then
    begin        
      idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Movies/Empire Earth.bik'), ExpandConstant('{tmp}\EE\Data\Movies\Empire Earth.bik'), 'game\update');
    end;   
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_WONStatus.cfg'), ExpandConstant('{tmp}\EE\Data\WONLobby Resources\_WONStatus.cfg'), 'game\update');
    #if InstallType != "NeoEE"
      idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_GameResource.cfg'), ExpandConstant('{tmp}\EE\Data\WONLobby Resources\_GameResource.cfg'), 'game\update');
      idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource.cfg'), ExpandConstant('{tmp}\EE\Data\WONLobby Resources\_LobbyResource.cfg'), 'game\update');
    #else
      idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_GameResource_Neo.cfg'), ExpandConstant('{tmp}\EE\Data\WONLobby Resources\_GameResource.cfg'), 'game\update');
      idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource_Neo.cfg'), ExpandConstant('{tmp}\EE\Data\WONLobby Resources\_LobbyResource.cfg'), 'game\update');
    #endif

    // Zocker Server HTTPS
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Language.dll'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Language.dll')); 
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/data.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/data.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EELearningCampaign.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EELearningCampaign.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheBritish.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EETheBritish.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheFuture.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EETheFuture.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGermans.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EETheGermans.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGreeks.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EETheGreeks.ssa'));
    if (IsComponentSelected('additional\movies')) then
    begin
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Movies/Empire Earth.bik'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/Movies/Empire Earth.bik'));
    end;
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_WONStatus.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_WONStatus.cfg'));
    #if InstallType != "NeoEE"
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_GameResource.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_GameResource.cfg')); 
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource.cfg'));
    #else
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_GameResource_Neo.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_GameResource_Neo.cfg')); 
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource_Neo.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource_Neo.cfg'));
    #endif
    
    // EE Community Server HTTP
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Language.dll'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Language.dll')); 
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/data.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/data.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EELearningCampaign.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EELearningCampaign.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheBritish.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheBritish.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheFuture.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheFuture.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGermans.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGermans.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGreeks.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGreeks.ssa'));
    if (IsComponentSelected('additional\movies')) then
    begin
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Movies/Empire Earth.bik'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/Movies/Empire Earth.bik'));
    end;
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_WONStatus.cfg'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_WONStatus.cfg'));  
    #if InstallType != "NeoEE" 
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_GameResource.cfg'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_GameResource.cfg'));
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource.cfg'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource.cfg')); 
    #else
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_GameResource_Neo.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_GameResource_Neo.cfg')); 
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource_Neo.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource_Neo.cfg'));
    #endif
    
    // Zocker Server HTTP
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Language.dll'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Language.dll')); 
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/data.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/data.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EELearningCampaign.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EELearningCampaign.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheBritish.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EETheBritish.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheFuture.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EETheFuture.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGermans.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EETheGermans.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Campaigns/EETheGreeks.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/Campaigns/EETheGreeks.ssa'));
    if (IsComponentSelected('additional\movies')) then
    begin
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/Movies/Empire Earth.bik'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/Movies/Empire Earth.bik'));
    end;
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_WONStatus.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_WONStatus.cfg'));     
    #if InstallType != "NeoEE"  
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_GameResource.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_GameResource.cfg'));
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource.cfg'));
    #else
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_GameResource_Neo.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_GameResource_Neo.cfg'));
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource_Neo.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/EE/Data/WONLobby Resources/_LobbyResource_Neo.cfg'));;
    #endif
       
    // -------- AoC --------
    
    // EE Community Server HTTPS
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Language.dll'), ExpandConstant('{tmp}\AoC\Language.dll'), 'gameaoc\update');
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/data.ssa'), ExpandConstant('{tmp}\AoC\Data\data.ssa'), 'gameaoc\update');
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCAsian.ssa'), ExpandConstant('{tmp}\AoC\Data\Campaigns\AOCAsian.ssa'), 'gameaoc\update');
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCPacific.ssa'), ExpandConstant('{tmp}\AoC\Data\Campaigns\AOCPacific.ssa'), 'gameaoc\update');
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCRoman.ssa'), ExpandConstant('{tmp}\AoC\Data\Campaigns\AOCRoman.ssa'), 'gameaoc\update'); 
    idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_WONStatus.cfg'), ExpandConstant('{tmp}\AoC\Data\WONLobby Resources\_WONStatus.cfg'), 'gameaoc\update');   
    #if InstallType != "NeoEE"  
      idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource.cfg'), ExpandConstant('{tmp}\AoC\Data\WONLobby Resources\_GameResource.cfg'), 'gameaoc\update');
      idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource.cfg'), ExpandConstant('{tmp}\AoC\Data\WONLobby Resources\_LobbyResource.cfg'), 'gameaoc\update');   
    #else
      idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource_Neo.cfg'), ExpandConstant('{tmp}\AoC\Data\WONLobby Resources\_GameResource.cfg'), 'gameaoc\update');
      idpAddFileComp(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource_Neo.cfg'), ExpandConstant('{tmp}\AoC\Data\WONLobby Resources\_LobbyResource.cfg'), 'gameaoc\update');
    #endif
    
    // Zocker Server HTTPS
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Language.dll'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Language.dll'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/data.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Data/data.ssa'))
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCAsian.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Data/Campaigns/AOCAsian.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCPacific.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Data/Campaigns/AOCPacific.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCRoman.ssa'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Data/Campaigns/AOCRoman.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_WONStatus.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_WONStatus.cfg'));
    #if InstallType != "NeoEE"
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource.cfg'));
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource.cfg'));
    #else 
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource_Neo.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource_Neo.cfg'));
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource_Neo.cfg'), ExpandConstant('https://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource_Neo.cfg'));
    #endif
   
    // EE Community Server HTTP
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Language.dll'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Language.dll'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/data.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Data/data.ssa'))
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCAsian.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCAsian.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCPacific.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCPacific.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCRoman.ssa'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCRoman.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_WONStatus.cfg'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_WONStatus.cfg'));     
    #if InstallType != "NeoEE"
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource.cfg'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource.cfg'));
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource.cfg'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource.cfg'));;
    #else 
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource_Neo.cfg'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource_Neo.cfg'));
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource_Neo.cfg'), ExpandConstant('http://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource_Neo.cfg'));;
    #endif
      
    // Zocker Server HTTP
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Language.dll'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Language.dll'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/data.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Data/data.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCAsian.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Data/Campaigns/AOCAsian.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCPacific.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Data/Campaigns/AOCPacific.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/Campaigns/AOCRoman.ssa'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Data/Campaigns/AOCRoman.ssa'));
    idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_WONStatus.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_WONStatus.cfg'));   
    #if InstallType != "NeoEE"
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource.cfg'));
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource.cfg'));
    #else  
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource_Neo.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_GameResource_Neo.cfg'));
      idpAddMirror(ExpandConstant('https://{#UpdateUrl}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource_Neo.cfg'), ExpandConstant('http://{#UpdateUrlMirror}/localized/{language}/AoC/Data/WONLobby Resources/_LobbyResource_Neo.cfg'));
    #endif
  end;
  
  Result := True;
end;

procedure DeinitializeSetup;
begin
  #if AudioModule
    BASS_Free;
  #endif
end;
 
procedure InitializeWizard;
var
  BackgroundImage: TBitmapImage;
  Diff: double;
  ScrWidth: double;
  ScrHeight: double;
begin
  
  #if AudioModule
    if InitBass then
    begin
      BASS_ChannelPlay(SoundStream, False);
      SoundCtrlButton := TNewButton.Create(WizardForm);
      SoundCtrlButton.Parent := WizardForm; 
      SoundCtrlButton.Left := WizardForm.InnerNotebook.Left / 2; //+ WizardForm.OuterNotebook.Left
      //SoundCtrlButton.Left := WizardForm.ClientWidth - WizardForm.NextButton.Left - WizardForm.NextButton.Width;
      SoundCtrlButton.Top := WizardForm.NextButton.Top;
      SoundCtrlButton.Width := WizardForm.NextButton.Width;
      SoundCtrlButton.Height := WizardForm.NextButton.Height
      SoundCtrlButton.Anchors := [akLeft, akBottom];
      SoundCtrlButton.Caption := ExpandConstant('&{cm:SoundCtrlButtonCaptionSoundOff}');
      SoundCtrlButton.OnClick := @SoundCtrlButtonClick;
    end;
  #endif


  if (WizardSupressMsgBoxes = False) then
  begin
    BackgroundImage := TBitmapImage.Create(MainForm);
    BackgroundImage.Parent := MainForm;
    BackgroundImage.SetBounds(0, 0, MainForm.ClientWidth, MainForm.ClientHeight);
    BackgroundImage.Stretch := True;

    // Auto Select 16:9 or 4:3
    ScrWidth := MainForm.ClientWidth;
    ScrHeight := MainForm.ClientHeight;

    Diff := ScrWidth / ScrHeight
    
    if (Diff > 1.55) then
    begin
      ExtractTemporaryFile('SetupBackground-16-9.bmp');
      BackgroundImage.Bitmap.LoadFromFile(ExpandConstant('{tmp}\SetupBackground-16-9.bmp'));
    end;

    if (Diff <= 1.55) then
    begin
      ExtractTemporaryFile('SetupBackground-4-3.bmp');
      BackgroundImage.Bitmap.LoadFromFile(ExpandConstant('{tmp}\SetupBackground-4-3.bmp'));
    end;
  end;
    
  // Create tmp dir to download files
  CreateDir(ExpandConstant('{tmp}\EE'));
  CreateDir(ExpandConstant('{tmp}\EE\Data'));
  CreateDir(ExpandConstant('{tmp}\EE\Data\Campaigns'));  
  CreateDir(ExpandConstant('{tmp}\EE\Data\Movies'));   
  CreateDir(ExpandConstant('{tmp}\EE\Data\WONLobby Resources'))
  CreateDir(ExpandConstant('{tmp}\AoC'));        
  CreateDir(ExpandConstant('{tmp}\AoC\Data'));
  CreateDir(ExpandConstant('{tmp}\AoC\Data\Campaigns'));     
  CreateDir(ExpandConstant('{tmp}\AoC\Data\WONLobby Resources'));

  idpSetOption('DetailedMode',  '1');   
  idpSetOption('ConnectTimeout', '500');  
  idpSetOption('SendTimeout', '500');       
  idpSetOption('ReceiveTimeout', '500');       
  idpSetOption('ErrorDialog', 'UrlList');          
  idpSetOption('InvalidCert', 'Ignore');          
  idpSetOption('AllowContinue', '1');

  idpDownloadAfter(wpReady);
end;