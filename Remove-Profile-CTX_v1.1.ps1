                     ####################################################################################
                     #    .SYNOPSIS                                                                     #
                     #       Remove User profiles.                                                      #
                     #    .DESCRIPTION                                                                  #
                     #       Remove User profiles except Administrator, Default, Public &               #
                     #       Ctx_StreamingSvc                                                           #
                     #                                                                                  #
                     #    .NOTES                                                                        #
                     #       File Name      : Remove-Profile.ps1                                        #
                     #       Author         :  https://github.com/mpatel-402455                         #
                     #       Script Version : 1.1                                                       #
                     #       Last Modified  : JUne 4, 2015                                              #
                     #       Prerequisite   : PowerShell.                                               #
                     #       Copyright      :  https://github.com/mpatel-402455                         #
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

# Check for folders

$Path = Get-ChildItem -Path C:\Users\
$DirNames = $Path.Name
$DirNames
$DirNames.Count

foreach ($DirName in $DirNames)
    {
        Write-Host "Directory name is: $DirName" -BackgroundColor DarkCyan

        if ($DirName -eq "Administrator" -or $DirName -eq "Default" -or $DirName -eq "Public" -or $DirName -eq "Ctx_StreamingSvc")
            {
               Write-Host """$DirName"", Directory won’t be removed." -ForegroundColor Green `n 
            }
        else
            {
               Write-Host """$DirName"", Directory will be removed." -ForegroundColor Cyan `n
               Remove-Item "C:\Users\$DirName" -Recurse -Force

            }
    } 


