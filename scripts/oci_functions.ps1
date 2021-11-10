<#
Script for Managment OCI Resources
Author: Marcos Silvestrini
Data: 28/10/2021
#>

#Convert Json from hashtable
Function Convert-JsonToHash {
    <#
    .SYNOPSIS
        Convert Json to Hashtable
    .DESCRIPTION
        Function for convert object json for ordered hashtable
        This function return a hashtable
    .EXAMPLE
        Convert-JsonToHash $json
    #>

    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $json
    )

    begin {
        $hashtable = [ordered]@{}
        #Powershell 5
    }

    process {
        $out = $json | ConvertFrom-Json
        $out.psobject.properties | ForEach-Object { $hashtable[$_.Name] = $_.Value }
        #Powershell 6 or Later
        #$hashtable = $json | ConvertFrom-Json -AsHashtable
    }

    end {
        return $hashtable
    }
}


#Get compartments
Function Get-Compartments {
    <#
    .SYNOPSIS
        Get OCI compartments
    .DESCRIPTION
        Function for get oci compartments em Oracle Cloud
        This function read ~/.oci/config foi conect in Oracle Cloud
    .EXAMPLE
        Get-Compartments
    #>

    param (

    )

    begin {
        Write-Host "---------------------------------------"
        Write-Host "Please wait...find ressource [COMPARTMENTS] in OCI"
        $hashtable = [ordered]@{}
    }

    process {
        $json = oci iam compartment list
        $hashtable = Convert-JsonToHash $json
    }

    end {
        return $hashtable
    }
}

#Compartments ToString
Function CompartmentsToString {
    <#
    .SYNOPSIS
        Compartment ToString
    .DESCRIPTION
        Function to print compartment names friendly
        Print all compartments name in tenancy
    .EXAMPLE
        CompartmentsToString
    #>

    param (

    )

    begin {
        $hashtable = [ordered]@{}
        $compartments = [ordered]@{}
    }

    process {
        $hashtable = Get-Compartments
        for ($i = 0; $i -lt $hashtable.Data.count; $i++ ) {
            Write-Host "---------------------------------------"
            Write-Host "Compartment Name: $($hashtable.Data[$i].Name)"
            Write-Host "Compartment State: $($hashtable.Data[$i].'lifecycle-state')"
            Write-Host "Compartment Create in: $($hashtable.Data[$i].'time-created')"
            Write-Host "---------------------------------------"
        }
    }

    end {

    }
}


#Get compartment-id
Function Get-CompartmentID {
    <#
    .SYNOPSIS
        Get compartment-id
    .DESCRIPTION
        Function for get compartment-id for specific id
        This function return string compartment-id
    .EXAMPLE
        Get-CompartmentID "sandbox"
    #>

    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $compartmentName
    )

    begin {
        Write-Host "---------------------------------------"
        Write-Host "Please wait...find ressource [COMPARTMENT-ID] in OCI"
        $hashtable = [ordered]@{}
        $id = $null
    }

    process {
        $hashtable = Get-Compartments
        $hashtable.Data | ForEach-Object {
            If ($_.name -eq $compartmentName) {
                $id = $_.id
                return
            }
        }
    }

    end {
        return $id
    }
}


#Get instances
Function Get-OCInstances() {
    Write-Host "---------------------------------------"
    Write-Host "Please wait...find ressource [INSTANCES] in OCI"
    $hashtable = [ordered]@{}
    $instances = [ordered]@{}
    #list all instances in compartment
    $compartmentID = Get-CompartmentID
    $json = oci compute instance list --compartment-id $compartmentID
    $hashtable = Convert-JsonToHash $json
    $hashtable.Data | ForEach-Object {
        if ($_.'lifecycle-state' -ne "TERMINATED") {
            $instances.Add($_.'display-name', $_.'lifecycle-state')
        }
    }
    return $instances
}


#Get instance-id
Function Get-InstanceID() {
    Write-Host "---------------------------------------"
    Write-Host "Please wait...find ressource [INSTANCE-ID] in OCI"
    $hashtable = [ordered]@{}
    $instances = [ordered]@{}
    #list all instances in compartment
    $compartmentID = Get-CompartmentID
    $json = oci compute instance list --compartment-id $compartmentID
    $hashtable = Convert-JsonToHash $json
    $hashtable.Data | ForEach-Object {
        if ($_.'lifecycle-state' -ne "TERMINATED") {
            $instances.Add($_.id, $_.'display-name')
        }
    }
    Write-Host "---------------------------------------"
    Write-Host "Instances found..."
    $instances.Values
    Write-Host "---------------------------------------"
    $instance = Read-Host -Prompt "Switch Instance Name"
    $instances | ForEach-Object {
        if ($_.Name -eq $instance) {
            $id = $_.Value
            return
        }
    }
    return $id
}


#menu function
Function Menu {
    @'
---------------------------------

1 - List All Compartments
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
            1 { Clear-Host; CompartmentsToString; ReturnMenu }
            2 { Clear-Host; Get-CompartmentID; ReturnMenu }
            3 { Clear-Host; Get-OCInstances; ReturnMenu }
            4 { Clear-Host; Write-Host "Get Instance ID"; Get-InstanceID; ReturnMenu }
            5 { Clear-Host; Write-Host "Stop Instance"; ReturnMenu }
            6 { Clear-Host; Write-Host "Start Instance" ; ReturnMenu }
            7 { Clear-Host; Write-Host "Terminate Instance"; ReturnMenu }
            8 { Clear-Host; Write-Host "Exit" }
            Default { Write-Host "Invalid Option!!!"; $option = 8 }
        }
    }
}

#Begin Test area

#Variables
$compartmentName = "sandbox"


#End Test area

#Begin Progran
Main


