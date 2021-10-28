<#
Script for Managment OCI Intances
Author: Marcos Silvestrini
#>

#Get instances
Function Get-OCIINstances {
    #list all instances in compartment
    $compartment_OCID = Read-Host -Prompt "Enter Your Compartment OCID"
    $output = oci compute instance list --compartment-id $compartment_OCID | ConvertFrom-Json
    $output.Data | Select-Object 'display-name', 'lifecycle-state'
    Start-Sleep 1
    While ($opcao -ne 1) {
        $opcao = Read-Host -Prompt "Press 1 to return menu"
    }
}


#menu function
Function Menu {
    @'
---------------------------------

1 - List All Instances
2 - Stop Instance
3 - Start Instance
4 - Terminate Instance
5 - Exit

---------------------------------
'@

}

#main function
Function Main {
    While ($option -ne 5) {
        Clear-Host
        Menu
        $option = Read-Host -Prompt "Enter Option"
        switch ($option) {
            1 { Clear-Host; Get-OCIINstances }
            2 { Clear-Host; Write-Host "Stop Instance" }
            3 { Clear-Host; Write-Host "Start Instance" }
            4 { Clear-Host; Write-Host "Terminate Instance" }
            5 { Clear-Host; Write-Host "Exit" }
            Default { Write-Host "Invalid Option!!!"; $option = 5 }
        }
        Start-Sleep 1
    }
}
#Execute Progran
Main