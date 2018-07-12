                     ####################################################################################
                     #    .SYNOPSIS                                                                     #
                     #       Remove FontCache Files.                                                    #
                     #    .DESCRIPTION                                                                  #
                     #       Remove FontCache Files when server starts                                  #
                     #                                                                                  #
                     #    .NOTES                                                                        #
                     #       File Name      : Check-FontCacheFile.ps1                                   #
                     #       Author         :  https://github.com/mpatel-402455                         #
                     #       Script Version : 1.0                                                       #
                     #       Last Modified  : June 23, 2015                                             #
                     #       Prerequisite   : PowerShell.                                               #
                     #       Copyright      :  https://github.com/mpatel-402455                         #
                     ####################################################################################

$XaServers = import-csv -path 'C:\MyScripts\Citrix Scripts\XA XENAPP SERVERS_List.csv'
#$XaServers = "CTXsrv01"
#,"CTXsrv01"

    #----
    # 1.0: Creating a Table
        $Table = $null
        $tabName = "Font Cache Files"
         
    # Create Table object
        $Table = New-Object System.Data.DataTable “$tabName”
           
    #Define Columns
        $col1 = New-Object System.Data.DataColumn "Server",([string])
        $col2 = New-Object System.Data.DataColumn "# Files",([int])
                    
        
            
    #Add the Columns
        $Table.columns.add($col1) 
        $Table.columns.add($col2)
       
foreach ($XaServer in $XaServers)
    {
        $XaServer = $XaServer.HostName
        $XaServer
        Write-Progress -Status "Working on $XaServer" -Activity "Please wait ..."
        $FilePath = "\\$XaServer\C$\Windows\ServiceProfiles\LocalService\AppData\Local"
        $FontCacheFiles = Get-ChildItem -Path "$FilePath\FontCache-S-1-5-21-*" -File -Force
        #$FontCacheFiles.Count

        # Create a row 1
           $row = $table.NewRow()
        # Enter data in the row
            $row.Server = "$XaServer"
            $row."# Files" = $FontCacheFiles.Count 
                       
        
        # Add the row to the table
            $table.Rows.Add($row)
    }

#Display the table
    "`n"
    Write-Host "$tabName" -ForegroundColor Cyan
    $Table | Format-Table -AutoSize 
     #$table | Out-GridView        