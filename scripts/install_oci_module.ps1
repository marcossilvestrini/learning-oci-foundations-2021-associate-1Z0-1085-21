#Require Powershell version 6 or later
#Requires -Version 6

#Install-Module OCI.PSModules
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module OCI.PSModules.Audit -Force
Install-Module -Name OCI.PSModules.Identity -Force
Install-Module OCI.PSModules -Force