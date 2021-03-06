﻿                     ####################################################################################
                     #    .SYNOPSIS                                                                     #
                     #       Remove User profiles.                                                      #
                     #    .DESCRIPTION                                                                  #
                     #       Remove User profiles except Administrator, Default, Public &               #
                     #       Ctx_StreamingSvc                                                           #
                     #                                                                                  #
                     #    .NOTES                                                                        #
                     #       File Name      : Remove-Profile.ps1                                        #
                     #       Author         : Manish Patel                                              #
                     #       Script Version : 1.0                                                       #
                     #       Last Modified  : May 8, 2015                                               #
                     #       Prerequisite   : PowerShell.                                               #
                     #       Copyright      : Manish Patel                                              #
                     ####################################################################################


$Path = Get-ChildItem -Path C:\Users\
$ProfileNames = $Path.Name
$ProfileNames
$ProfileNames.Count

foreach ($ProfileName in $ProfileNames)
    {
        Write-Host "Prfoile name is: $ProfileName" -BackgroundColor DarkCyan

        if ($ProfileName -eq "Administrator" -or $ProfileName -eq "Default" -or $ProfileName -eq "Public" -or $ProfileName -eq "Ctx_StreamingSvc")
            {
               Write-Host """$ProfileName"", profile won’t be removed." -ForegroundColor Green `n 
            }
        else
            {
                Write-Host """$ProfileName"", profile will be removed." -ForegroundColor Cyan `n 
                (Get-WmiObject -Class Win32_userprofile | Where-Object {$_.localpath -like "C:\users\$ProfileName"}).delete()
            }
    }