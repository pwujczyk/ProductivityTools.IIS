function ValidateAdmin() {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -eq $false) {
        Write-Error "This script must be executed as Administrator.";

    }
}

function New-IISSite() {
    [cmdletbinding()]
    param ([string]$Name, [string]$BindingInformation, [string]$PhysicalPath)
    
    ValidateAdmin
    Push-Location $pwd

    Write-Verbose "Name: $Name"
    Write-Verbose "Binding information: $BindingInformation"
    Write-Verbose "Physical Path: $PhysicalPath"
    $httpbinding = "http://$BindingInformation"
    Write-Verbose "Http binding: $httpbinding"
    cd $env:SystemRoot\system32\inetsrv
    
    .\appcmd.exe add site /name:$Name /bindings:$httpbinding /physicalpath:$PhysicalPath
    
    Pop-Location
    #.\appcmd.exe add site /name:PTFeedback /bindings:http://*:8001 /physicalpath:"C:\\Bin\\IIS\\PTFeedback"
    #New-IISSite -Name $Name -BindingInformation $BindingInformation -PhysicalPath $PhysicalPath

}

function New-IISSiteIfDoesNotExist() {
    [cmdletbinding()]
    param ([string]$Name, [string]$BindingInformation, [string]$PhysicalPath)

    ValidateAdmin
    Push-Location $pwd
    cd $env:SystemRoot\system32\inetsrv
    $exists = (.\appcmd.exe list sites /name:$Name) -ne $null
    Write-Host $exists

    if ($exists) {
        Write-Verbose "App Pool $Name exists"
    }
    else {
        Write-Verbose "App Pool $Name does not exist"
        New-IISSite -Name $Name -BindingInformation $BindingInformation -PhysicalPath $PhysicalPath

    }
    Pop-Location

}

Export-ModuleMember New-IISSite
Export-ModuleMember New-IISSiteIfDoesNotExist