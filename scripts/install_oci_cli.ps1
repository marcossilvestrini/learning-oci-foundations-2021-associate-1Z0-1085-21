#set policy
Set-ExecutionPolicy RemoteSigned

#Force PowerShell to use TLS 1.2 for Windows 2012 and Windows 2016:
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Download the installer script
Invoke-WebRequest https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.ps1 `
-OutFile install.ps1

#installer script without prompting the user, accepting the default settings, run the
.\install.ps1 -AcceptAllDefaults

#delete scripts install
rm install.ps1 -force

#validate install
oci --version