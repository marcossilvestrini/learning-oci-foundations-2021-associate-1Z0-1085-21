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
    }

    process {
        #Powershell 5
        $out = $json | ConvertFrom-Json -ErrorAction Stop
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

    begin {
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

    begin {
        $hashtable = [ordered]@{}
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
        Get-CompartmentID -compartmentName "sandbox"
    #>

    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $compartmentName
    )

    begin {
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
Function Get-OCInstances {
    <#
    .SYNOPSIS
        Get OCI Instances
    .DESCRIPTION
        Get OCI instance in compartment
        Return hashtable of instances
    .EXAMPLE
        Get-OCInstances -compartmentName "sandbox"

    #>

    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $compartmentName
    )

    begin {
        $hashtable = [ordered]@{}
    }

    process {
        $compartmentID = Get-CompartmentID -compartmentName $compartmentName
        $json = oci compute instance list --compartment-id $compartmentID
        $hashtable = Convert-JsonToHash $json
    }

    end {
        return $hashtable
    }
}

#Instances ToString
Function InstancesToString {
    <#
    .SYNOPSIS
        Instances ToString
    .DESCRIPTION
        Function to print instances names friendly
        Print all instance name in tenancy
    .EXAMPLE
        InstancesToString -compartmentName "sandbox"
    #>

    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $compartmentName
    )

    begin {
        $hashtable = [ordered]@{}
    }

    process {
        $hashtable = Get-OCInstances -compartmentName $compartmentName
        for ($i = 0; $i -lt $hashtable.Data.count; $i++ ) {
            Write-Host "---------------------------------------"
            Write-Host "Instance Name: $($hashtable.Data[$i].'display-name')"
            Write-Host "Instance State: $($hashtable.Data[$i].'lifecycle-state')"
            Write-Host "Instance Create in: $($hashtable.Data[$i].'time-created')"
            Write-Host "---------------------------------------"
        }
    }

    end {

    }
}


#Get instance-id
Function Get-InstanceID {
    <#
    .SYNOPSIS
        Get Instance ID
    .DESCRIPTION
        Function for get instance-id to specific instance name in specifi compartment name
        Print instance id
    .EXAMPLE
        Get-InstanceID -compartmentName "sandbox" -instanceName $instanceName
    #>

    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $compartmentName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $instanceName
    )

    begin {
        $hashtable = [ordered]@{}
        $id = ""
    }

    process {
        $hashtable = Get-OCInstances -compartmentName $compartmentName
        $hashtable.Data | ForEach-Object {
            if ($_.'display-name' -eq $instanceName) {
                $id = $_.id
                return
            }
        }

    }

    end {
        return $id

    }
}

#Stop OCI Intance
Function Stop-OCInstance {
    <#
    .SYNOPSIS
        Stop OCI Instance
    .DESCRIPTION
        Function for stop oci instance name
    .EXAMPLE
        Stop-OCInstance -compartmentName "sandbox" -instanceName "web-server"
    #>
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $compartmentName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $instanceName
    )

    begin {
        $id = ""
    }

    process {
        $id = Get-InstanceID -compartmentName $compartmentName -instanceName $instanceName
        Write-Host  "Please wait...process action"
        oci compute instance action --action SOFTSTOP --instance-id $id
    }

    end {
        return $?
    }
}


#Start OCI Intance
Function Start-OCInstance {
    <#
    .SYNOPSIS
        Start OCI Instance
    .DESCRIPTION
        Function for start oci instance name
    .EXAMPLE
        Start-OCInstance -compartmentName "sandbox" -instanceName "web-server"
    #>
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $compartmentName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $instanceName
    )

    begin {
        $id = ""
    }

    process {
        $id = Get-InstanceID -compartmentName $compartmentName -instanceName $instanceName
        Write-Host  "Please wait...process action"
        oci compute instance action --action START --instance-id $id
    }

    end {
        return $?
    }
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
            1 {
                Clear-Host
                Write-Host "---------------------------------------"
                Write-Host "Please wait...find ressource [COMPARTMENTS] in OCI"
                CompartmentsToString
                ReturnMenu
            }
            2 {
                Clear-Host
                Write-Host "---------------------------------------"
                Write-Host "Please wait...find ressource [COMPARTMENT-ID] in OCI"
                $compartmentName = Read-Host -Prompt "Enter compartment name"
                Get-CompartmentID -compartmentName $compartmentName
                ReturnMenu
            }
            3 {
                Clear-Host
                Write-Host "---------------------------------------"
                Write-Host "Please wait...find ressource [INSTANCES] in OCI"
                $compartmentName = Read-Host -Prompt "Enter compartment name"
                InstancesToString -compartmentName $compartmentName
                ReturnMenu
            }
            4 {
                Clear-Host
                Write-Host "---------------------------------------"
                Write-Host "Please wait...find ressource [INSTANCE-ID] in OCI"
                $compartmentName = Read-Host -Prompt "Enter compartment name"
                $instanceName = Read-Host -Prompt "Enter instance name"
                Get-InstanceID -compartmentName $compartmentName $instanceName $instanceName
                ReturnMenu
            }
            5 {
                Clear-Host
                Write-Host "---------------------------------------"
                Write-Host "Please wait...execute action [STOP-INSTANCE] in OCI"
                $compartmentName = Read-Host -Prompt "Enter compartment name"
                $instanceName = Read-Host -Prompt "Enter instance name"
                Stop-OCInstance -compartmentName $compartmentName -instanceName $instanceName
                ReturnMenu
            }
            6 {
                Clear-Host
                Write-Host "---------------------------------------"
                Write-Host "Please wait...execute action [STARTA-INSTANCE] in OCI"
                $compartmentName = Read-Host -Prompt "Enter compartment name"
                $instanceName = Read-Host -Prompt "Enter instance name"
                Start-OCInstance -compartmentName $compartmentName -instanceName $instanceName
                ReturnMenu
            }
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


