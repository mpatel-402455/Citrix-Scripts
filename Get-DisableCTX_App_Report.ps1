$date = Get-Date -UFormat %Y-%m-%d-%H%M%S
$date
$FarmName = (Get-XAFarm | Select-Object -Property FarmName).FarmName
$OutFilePath = "C:\TEMP\Disable_App_List_"+$FarmName+"_"+$date+".csv"

$DisabledApps = Get-XAApplication | Select-Object BrowserName | Get-XAApplicationReport | Where-Object {$_.enabled -eq $false} |Select-Object -Property *

$DisabledApps | Select-Object @{ Name='AppDisplayName'; E={$_.DisplayName} },FolderPath,Enabled,HideWhenDisabled, @{ Name='Server'; E={if (!($_.ServerNames -ne $null)) {"N/A"} else {$_.ServerNames -join ", "} } },@{ Name='WorkerGroupNames'; E={if (!($_.WorkerGroupNames -ne $null)) {"N/A"} else {$_.WorkerGroupNames -join ", "}  } }, @{ Name='Accounts'; E={ @($_.Accounts | ForEach-Object { $_.AccountDisplayName }) -join ", "} },ApplicationType,Description | Export-Csv -Path $OutFilePath -NoTypeInformation



#@{ Name='WorkerGroupNames'; E={$_.WorkerGroupNames -join ", "} }


#$DisabledApps = Get-XAApplication | Get-XAApplicationReport | Where-Object {$_.enabled -eq $false} |Select-Object -Property *

#$DisabledApps | Select-Object @{ Name='AppDisplayName'; E={$_.DisplayName} },FolderPath,Enabled,HideWhenDisabled, @{ Name='Servers'; E={$_.ServerNames -join ", "} }, @{ Name='Accounts'; E={ @($_.Accounts | ForEach-Object { $_.AccountDisplayName }) -join ", "} },ApplicationType,Description | Export-Csv -Path C:\temp\Disabled_App_list_MVP1.0_$date.csv -NoTypeInformation
<#
 $app = Get-XAApplication "App-Test-SE303922" | Select-Object -Property * | Get-XAApplicationReport
 $app2 = Get-XAApplication "Test" | Select-Object -Property * | Get-XAApplicationReport
 
$app | Select-Object -Property @{ Name='WorkerGroupNames'; E={if (!($_.WorkerGroupNames -ne $null)) {"N/A"} else {$_.WorkerGroupNames -join ", "} } }
$app2 | Select-Object -Property @{ Name='WorkerGroupNames'; E={if (!($_.WorkerGroupNames -ne $null)) {"N/A"} else {$_.WorkerGroupNames -join ", "}  } }
$app | Select-Object -Property @{ Name='Server'; E={if (!($_.ServerNames -ne $null)) {"N/A"} else {$_.ServerNames -join ", "} } }
$app2 | Select-Object -Property @{ Name='Server'; E={if (!($_.ServerNames -ne $null)) {"N/A"} else {$_.ServerNames -join ", "}  } }
#>
