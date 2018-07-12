
$XaServers = import-csv -path 'C:\MyScripts\Citrix Scripts\XA XENAPP SERVERS_List.csv'
#------
# 1.0: Creating a Table
        $Table = $null
        $tabName = "Stale Profile"
    
foreach ($XaServer in $XaServers)
    {
        #$StaleProfiles = $null
        $XaServer = $XaServer.HostName
        

        $StaleProfiles = Get-ChildItem -Path "\\$XaServer\C$\Users" -Exclude Administrator, Default, Public, Ctx_StreamingSvc | `
        Where-Object {($_.LastWriteTime -lt ((Get-Date).AddDays(-1)))} | `
        Select-Object -Property Name, FullName, LastWriteTime 
        $count = @($StaleProfiles).Count
        
        
        If ($count -gt 0)
            {
                Write-Host "$count : Stale Profiles found on $XaServer" -ForegroundColor Cyan
                $StaleProfiles | Format-Table -AutoSize 
            }
        else
            {
                Write-Host "$XaServer No stale Profiles found on any XA Servers" -ForegroundColor Green
            }
    }


           