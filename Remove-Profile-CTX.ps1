                     ####################################################################################
                     #    .SYNOPSIS                                                                     #
                     #       Remove User profiles.                                                      #
                     #    .DESCRIPTION                                                                  #
                     #       Remove User profiles except Administrator, Default, Public &               #
                     #       Ctx_StreamingSvc                                                           #
                     #                                                                                  #
                     #    .NOTES                                                                        #
                     #       File Name      : Remove-Profile.ps1                                        #
                     #       Author         : Manish Patel                                              #
                     #       Script Version : 1.2                                                       #
                     #       Last Modified  : June 16, 2015                                             #
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

        elseif ("C:\Users\$ProfileName" -eq (Get-WmiObject -Class Win32_UserProfile | Where-Object {$_.localpath -like "C:\Users\$ProfileName"}).LocalPath) 
            {
               Write-Host """$ProfileName"", profile will be removed." -ForegroundColor Cyan `n 
               (Get-WmiObject -Class Win32_UserProfile | Where-Object {$_.localpath -like "C:\users\$ProfileName"}).delete()   
            }

        else
            {
               Write-Host """$ProfileName"", is not a Profile and the directory will be removed." -ForegroundColor Cyan `n
               Remove-Item "C:\Users\$ProfileName" -Recurse -Force
            }
    }