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
    SET appcmd=CALL %WINDIR%\system32\inetsrv\appcmd
    $exists = (.\appcmd.exe list apppool /name:$Name) -ne $null

    if ($exists -eq $false)
    {
        Write-Host 'App Pool does not exist'
    }
    else
    {
        Write-Host 'App Pool exists'
    }
    Pop-Location

}

Export-ModuleMember New-IISSiteIfDoesNotExist