<#
Script for Managment OCI Resources
Author: Marcos Silvestrini
Data: 28/10/2021
#>

#Convert Json from hashtable
Function Convert-JsonToHash($json) {
    $hashtable = [ordered]@{}
    #Powershell 5
    $out = $json | ConvertFrom-Json
    $out.psobject.properties | ForEach-Object { $hashtable[$_.Name] = $_.Value }
    #Powershell 6 or Later
    #$hashtable = $json | ConvertFrom-Json -AsHashtable
    return $hashtable
}


#Get compartments
Function Get-Compartments {
    Write-Host "Please wait...find ressource [COMPARTMENTS] in OCI"
    $hashtable = [ordered]@{}
    $json = oci iam compartment list
    $hashtable = Convert-JsonToHash $json
    return $hashtable.Data.Name
}


#Get compartment-id
Function Get-CompartmentID() {
    Write-Host "Please wait...find ressource [COMPARTMENT-ID] in OCI"
    $hashtable = [ordered]@{}
    $id = $null
    $json = oci iam compartment list
    $hashtable = Convert-JsonToHash $json
    $name = Read-Host -Prompt "Enter Compartment Name"
    $hashtable.Data | ForEach-Object {
        If ($_.name -eq $name) {
            $id = $_.id
            return
        }
    }
    return $id
}


#Get instances
Function Get-OCInstances() {
    Write-Host "Please wait...find ressource [INSTANCES] in OCI"
    $hashtable = [ordered]@{}
    $instances = [ordered]@{}
    #list all instances in compartment
    $id = Get-CompartmentID
    $json = oci compute instance list --compartment-id $id
    $hashtable = Convert-JsonToHash $json
    #$output.Data | Select-Object 'display-name', 'lifecycle-state'
    $hashtable.Data | ForEach-Object {
        if ($_.'lifecycle-state' -ne "TERMINATED") {
            $instances.Add($_.'display-name', $_.'lifecycle-state')
        }
    }
    return $instances
}


#Get instance-id
Function Get-InstanceID() {
    Write-Host "Please wait...find ressource [INSTANCE-ID] in OCI"
    $hashtable = [ordered]@{}
    #$compartmentID = Get-CompartmentID
    #$json = oci compute instance list --compartment-id $compartmentID
    #$hashtable = Convert-JsonToHash $json
    #return $hashtable.Data.id
}


#menu function
Function Menu {
    @'
---------------------------------

1 - Get Compartments
2 - Get Compartment ID
3 - List All Instances
4 - Get Instance ID
5 - Stop Instance
6 - Start Instance
7 - Terminate Instance
8 - Exit

---------------------------------
'@

}


#retrun to menu
Function ReturnMenu {
    $option = -1
    While ($option -ne 1) {
        $option = Read-Host -Prompt "Enter 1 for return menu"
        if ($option -eq 1) { break }
    }
}


#main function
Function Main {
    While ($option -ne 8) {
        Clear-Host
        Menu
        $option = Read-Host -Prompt "Enter Option"
        switch ($option) {
            1 { Clear-Host; Get-Compartments; ReturnMenu }
            2 { Clear-Host; Get-CompartmentID; ReturnMenu }
            3 { Clear-Host; Get-OCInstances; ReturnMenu }
            4 { Clear-Host; Write-Host "Get Instance ID"; Get-InstanceID; ReturnMenu }
            5 { Clear-Host; Write-Host "Stop Instance"; ReturnMenu }
            6 { Clear-Host; Write-Host "Start Instance" ; ReturnMenu }
            7 { Clear-Host; Write-Host "Terminate Instance"; ReturnMenu }
            8 { Clear-Host; Write-Host "Exit" }
            Default { Write-Host "Invalid Option!!!"; $option = 8 }
        }
        #Start-Sleep 1
    }
}


#Begin Test area

#Variables
$compartmentName = "sandbox"

#Get-Compartments
#Get-CompartmentID
Get-OCInstances

#End Test area

#Begin Progran
#Main