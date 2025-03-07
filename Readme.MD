

# ProductivityTools.IIS

It allows to create website in IIS from powershell. It also allows to create website if it does not exist.

<!--more-->

There is Powershell module **IISAdministration** that allows to create IIS website from Powershell, but you need to install additional features in windows to have it (you cannot just ```install-module IISAdministration```) 



Usage:

```
New-IISSite -Name "xx1" -BindingInformation "*:8080" -PhysicalPath "D:\Trash\website" -Verbose
New-IISSiteIfDoesNotExist -Name "xx" -BindingInformation "*:8080" -PhysicalPath "D:\Trash\website" -Verbose

```