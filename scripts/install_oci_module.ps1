#Require Powershell version 6 or later
#Requires -Version 6

#Install-Module OCI.PSModules
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name OCI.PSModules.Identity -Force