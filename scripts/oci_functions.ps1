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
    $hashtable = [ordered]@{}
    $json = oci iam compartment list
    $hashtable = Convert-JsonToHash $json
    return $hashtable.Data
}

#Get compartment-id
Function Get-CompartmentID($name) {
    $hashtable = [ordered]@{}
    $id = $null
    $json = oci iam compartment list
    $hashtable = Convert-JsonToHash $json
    $hashtable.Data | ForEach-Object {
        If ($_.name -eq $name) {
            $id = $_.id
            return
        }
    }
    return $id
}

#Get instances
Function Get-OCInstances($compartment) {
    #list all instances in compartment
    $id = Get-CompartmentID $compartment
    $output = oci compute instance list --compartment-id $id | ConvertFrom-Json
    $output.Data | Select-Object 'display-name', 'lifecycle-state'

}

#menu function
Function Menu {
    @'
---------------------------------

1 - Get Compartments
2 - Get Compartment ID
3 - List All Instances
4 - Stop Instance
5 - Start Instance
6 - Terminate Instance
7 - Exit

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
    While ($option -ne 7) {
        Clear-Host
        Menu
        $option = Read-Host -Prompt "Enter Option"
        switch ($option) {
            1 { Clear-Host; Get-Compartments; ReturnMenu }
            2 { Clear-Host; $compartment = Read-Host -Prompt "Enter Compartment Name"; Get-CompartmentID $compartment; ReturnMenu }
            3 { Clear-Host; $compartment = Read-Host -Prompt "Enter Compartment Name"; Get-OCInstances $compartment; ReturnMenu }
            4 { Clear-Host; Write-Host "Stop Instance"; ReturnMenu }
            5 { Clear-Host; Write-Host "Start Instance" ; ReturnMenu }
            6 { Clear-Host; Write-Host "Terminate Instance"; ReturnMenu }
            7 { Clear-Host; Write-Host "Exit" }
            Default { Write-Host "Invalid Option!!!"; $option = 7 }
        }
        Start-Sleep 1
    }
}

#Begin Test area

#Variables
$compartmentName = "sandbox"

#Get-Compartments
#Get-CompartmentID $compartmentName
#Get-OCInstances $compartmentName

#End Test area


#Begin Progran
Main