$date = Get-Date -UFormat %Y-%m-%d-%H%M%S
$date

$FarmName = (Get-XAFarm -ComputerName XActrl01 | Select-Object -Property FarmName).FarmName

#$OutFilePath = "C:\TEMP\XAServersHotfixList"+$FarmName+"_"+$date+".csv"

$OutFilePath = "C:\temp\XAServersHotfixList"+$FarmName+"_"+$date+".csv"
 
 $XAServers = Get-XAServer -ComputerName XActrl01(controller to establish a remote connection) | Select-Object -Property ServerName
 #$XAServers 
# Get-XAServerHotfix -ServerName XActrl01 | Select-Object -Property servername, HotfixName, installedon,installedby,hotfixtype -First 1
 
 foreach ($server in $XAServers)
    {
        Get-XAServerHotfix -ServerName $server.ServerName -ComputerName XActrl01 | Select-Object -Property servername, HotfixName, installedon,installedby,hotfixtype | Sort-Object servername| Export-Csv -Path $OutFilePath -NoTypeInformation -Append
        #
    }
