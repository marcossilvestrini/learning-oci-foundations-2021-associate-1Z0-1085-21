#set policy
Set-ExecutionPolicy RemoteSigned

#Force PowerShell to use TLS 1.2 for Windows 2012 and Windows 2016:
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#vars
$tenancy_OCID=""
$compartment_OCID=""
$user_OCID=""

# setup oci
oci setup config