cd $PSScriptRoot
Import-Module .\ProductivityTools.IIS.psm1 -Force

#New-IISSite -Name "xx1" -BindingInformation "*:8080" -PhysicalPath "D:\Trash\website" -Verbose

New-IISSiteIfDoesNotExist -Name "xx" -BindingInformation "*:8080" -PhysicalPath "D:\Trash\website" -Verbose
