<# diskVersionAccess State of the Disk Version. 
    Values are: 0 (Production), 
                1 (Maintenance), 
                2 (MaintenanceHighestVersion), 
                3 (Override), 
                4 (Merge), 
                5 (MergeMaintenance), 
                6 (MergeTest),
                7 (Test). It is equal to "" if the Device is not active. Default=0
#>

$DiskVersion = (@{Name=" Disk Type";Expression={if ($_.DiskVersionAccess -eq 0) {"Production"} `
                                                    elseif ($_.DiskVersionAccess -eq 1) {"Maintenance"} `
                                                    elseif ($_.DiskVersionAccess -eq 2) {"MaintenanceHighestVersion"} `
                                                    elseif ($_.DiskVersionAccess -eq 3) {"Override"} `
                                                    elseif ($_.DiskVersionAccess -eq 4) {"Maintenance"} `
                                                    elseif ($_.DiskVersionAccess -eq 5) {"MergeMaintenance"} `
                                                    elseif ($_.DiskVersionAccess -eq 6) {"MergeTest"} `
                                                    elseif ($_.DiskVersionAccess -eq 7) {"Test"} `
                                                    } `
                   })

# Example 1
Get-PvsDeviceInfo | Select-Object -Property CollectionName,ServerName,Name,DeviceMac, DiskFileName,DiskVersion,$DiskVersion, DiskLocatorName | Sort-Object -Property CollectionName,type| ft -AutoSize # Export-Csv -Path C:\temp\filename.csv #ft -AutoSize

# Example 1.1 - B Only Master servres
Get-PvsDeviceInfo | Where-Object {$_.Name -like "CTXMasterServerName*" } | Select-Object -Property CollectionName,ServerName,Name,DeviceMac, DiskFileName,DiskVersion,$DiskVersion, DiskLocatorName | Sort-Object -Property CollectionName,type| ft -AutoSize

#Example 1.2 - B Only Master servers and not from Specified PVS server
Get-PvsDeviceInfo | Where-Object {$_.Name -like "CTXMasterServerName*" -and $_.ServerName -notin "SERVER11" } | Select-Object -Property CollectionName,ServerName,Name,DeviceMac, DiskFileName,DiskVersion,$DiskVersion, DiskLocatorName | Sort-Object -Property CollectionName,type| ft -AutoSize

# Example 2
Get-PvsDeviceInfo | Where-Object {$_.CollectionName -like "CTX_NameOfDeviceCollection"}  | Select-Object -Property CollectionName,ServerName,Name,DeviceMac, DiskFileName,DiskVersion,$DiskVersion, DiskLocatorName | Sort-Object -Property CollectionName,type| ft -AutoSize # Export-Csv -Path C:\temp\filename.csv #ft -AutoSize

Get-PvsDeviceInfo | Where-Object {$_.CollectionName -like "CTX_NameOfDeviceCollection"} | Select-Object -Property CollectionName,ServerName,Name,DeviceMac, DiskFileName,DiskVersion,$DiskVersion, DiskLocatorName | Sort-Object -Property CollectionName,type| ft -AutoSize


# Get-PvsDeviceInfo | Where-Object {$_.CollectionName -like "CTX_NameOfDeviceCollection"}  


#=======================================================================================================================================

Get-PvsDeviceInfo | Select-Object -Property CollectionName,ServerName,Name,DeviceMac, DiskFileName,DiskVersion,DiskVersionAccess,DiskLocatorName | Sort-Object -Property CollectionName,type| ft -AutoSize # Export-Csv -Path C:\temp\CTX_NameOfDeviceCollection.csv #ft -AutoSize
Get-PvsDeviceInfo | Where-Object {$_.CollectionName -like "CTX_NameOfDeviceCollection"}  |Select-Object -Property CollectionName,ServerName,Name,DeviceMac,Ip, DiskFileName,DiskVersion,DiskLocatorName |ft -AutoSize

Get-PvsDeviceInfo | Where-Object {$_.CollectionName -like "CTX_NameOfDeviceCollection"}  |Select-Object -Property *

Get-PvsDeviceInfo | Where-Object {$_.CollectionName -like "CTX_NameOfDeviceCollection"}  |Select-Object -Property CollectionName,ServerName,Name,DeviceMac,Ip, DiskFileName,DiskVersion,DiskLocatorName,Type |ft -AutoSize |gm

Get-PvsDeviceInfo | Where-Object {$_.CollectionName -like "CTX_NameOfDeviceCollection"}  |Select-Object -Property CollectionName,Name,Type |gm
Get-PvsDisk -DiskLocatorName "PVS_STORE (G:)\XA65_CTX_Core_4"

Get-PvsDeviceInfo | Where-Object {$_.CollectionName -like "CTX_NameOfDeviceCollection"} | Select-Object -Property CollectionName,Name, @{Name="Type---"; Expression={$_.type=(if($_.type -eq "1"){$_.type = "TEST"})}}

Get-PvsDeviceInfo | Where-Object {$_.CollectionName -like "CTX_NameOfDeviceCollection"} | Select-Object -Property CollectionName,Name, @{Name+"TYPE";($_.type=(if($_.type -eq 1){TES}))}

# diskVersionAccess State of the Disk Version. Values are: 0 (Production), 1 (Maintenance), 2 (MaintenanceHighestVersion), 3 (Override), 4 (Merge), 5 (MergeMaintenance), 6 (MergeTest), and 7 (Test). It is equal to "" if the Device is not active. Default=0

