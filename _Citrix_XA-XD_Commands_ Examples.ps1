# Example : Get all Citrix Sessions
  Get-BrokerSession -AdminAddress BrokerController01 | Select-Object -Property AppState,SessionState,SessionType, @{Name='ApplicationName';E={$_.ApplicationsInUse}}, MachineName, UserFullName, UserName, UntrustedUserName 

# Example: Get specified users session
  Get-BrokerSession -AdminAddress BrokerController01 | Where-Object {$_.UserName -eq "DomainName\userID"} | Select-Object -Property AppState,SessionState,SessionType, @{Name='ApplicationName';E={$_.ApplicationsInUse}}, MachineName, UserFullName, UserName, UntrustedUserName  

# Example: Stops or Logs Off specified users session
  Get-BrokerSession -AdminAddress BrokerController01 | Where-Object {$_.UserName -eq "DomainName\userID"} | Stop-BrokerSession 

# Example: Show Published Applicaitons in XA6.5
   Get-XAApplication -ComputerName CtxXML01.lab.com | Select-Object -Property DisplayName, BrowserName | ft -AutoSize

#Example: Shows Configured Users/Group info for specified published applicaiton in XA 6.5
  Get-XAAccount -ComputerName CtxXML01.lab.com -BrowserName "MS Word 2016"

#Example: Shows Published Applications report including, WorkerGroup, Servers, DisplayName, Discription, and Users
Get-XAApplicationReport -ComputerName CtxXML01.lab.com -BrowserName "MS Word 2016" | select-object WorkerGroupNames, @{n=”Servers”;e={[string]::join(” ; “, $_.ServerNames)}}, DisplayName, Description, @{n=”Users”;e={[string]::join(” ; “, $_.Accounts)}}


# Example: Create CSV inventory for Citrix v6.5 XenApp info
  Get-XAWorkerGroup | select workergroupname, @{n = 'server' ; E = {$_.servernames -join ','}}, @{n= 'OU' ; E = {$_.OUs -join ','}} | Export-Csv c:\temp\wg-list-MVP2.csv
  Get-XAApplicationReport * | select ApplicationType, DisplayName, FolderPath, Enabled, HideWhenDisabled, ContentAddress, CommandLineExecutable, WorkingDirectory, AnonymousConnectionsAllowed, AddToClientStartMenu, ClientFolder, StartMenuFolder, AddToClientDesktop, ConnectionsThroughAccessGatewayAllowed, OtherConnectionsAllowed, AccessSessionConditionsEnabled, @{n="AccessSessionConditions";e={[string]::join(" ; ", $_.AccessSessionConditions)}}, InstanceLimit, MultipleInstancesPerUserAllowed, CpuPriorityLevel, AudioType, AudioRequired, SslConnectionEnabled, EncryptionLevel, EncryptionRequired, WaitOnPrinterCreation, WindowType, ColorDepth, TitleBarHidden, MaximizedOnStartup, OfflineAccessAllowed, CachingOption, AlternateProfiles, RunAsLeastPrivilegedUser, @{n="Servers";e={[string]::join(" ; ", $_.ServerNames)}}, @{n="WorkerGroups";e={[string]::join(" ; ", $_.WorkerGroupNames)}}, @{n="Users";e={[string]::join(" ; ", $_.Accounts)}} | Export-Csv c:\temp\app-list-MVP2.csv


# Example: Get all Citrix Sessions
	Get-BrokerSession -AdminAddress DDCServName |Select-Object -Property SessionState,SessionType, @{Name='ApplicationName';E={$_.ApplicationsInUse}}, MachineName, UserFullName, UserName, UntrustedUserName 


# Example: Get specified users session
  Get-BrokerSession -AdminAddress DDCServName | Where-Object {$_.UserName -eq "Domain\UserID"} 
| Select-Object -Property CatalogName,AppState,SessionState,SessionType, @{Name='ApplicationName';E={$_.ApplicationsInUse}}, MachineName, UserFullName, UserName, UntrustedUserName  
 
# Example: Stops or Logs off specified users session
  Get-BrokerSession -AdminAddress DDCServName | Where-Object {$_.UserName -eq "Domain\UserID"} | Stop-BrokerSession 

# Get Sessions
  Get-BrokerSession  -AdminAddress "DDCName.domain.com:80" -Filter "((UserName -like `"*UserID*`") -or (DesktopGroupName -like `"*UserID*`") -or (ClientName -like `"*UserID*`") -or (CatalogName -like `"*UserID*`") -or (DNSName -like `"*UserID*`") -or (HostingServerName -like `"*UserID*`") -or (HostedMachineName -like `"*UserID*`"))" -MaxRecordCount 500 -Property @("UserName","DNSName","DesktopGroupName","CatalogName","BrokeringTime","SessionState","AppState","SessionSupport","Uid","DesktopUid","MachineSummaryState","IsAnonymousUser","Protocol") -ReturnTotalRecordCount -Skip 0 -SortBy "+UserName" 

#Example: Get the events to show if the broker has lost connection to the database:
 
$servers = (Get-BrokerController).DNSName
foreach ($server in (Get-BrokerController).DNSName) { $server; Get-WinEvent -ComputerName $server -FilterHashtable @{providername='citrix broker service'; id=1201,3501,3004;}  | ft -a -wrap timecreated, message }
  
$servers = (Get-BrokerController).DNSName
$server; Get-WinEvent -max 5  -FilterHashtable @{providername='citrix broker service'; id=1201,3501,3004;}  | ft -a -wrap timecreated, message

#============
#Example: Get the events to show if the broker has lost connection to the database:
 
$servers = (Get-BrokerController).DNSName
foreach ($server in (Get-BrokerController).DNSName) { $server; Get-WinEvent -ComputerName $server -FilterHashtable @{providername='citrix broker service'; id=1201,3501,3004;}  | ft -a -wrap timecreated, message }
  
$servers = (Get-BrokerController).DNSName
$server; Get-WinEvent -max 5  -FilterHashtable @{providername='citrix broker service'; id=1201,3501,3004;}  | ft -a -wrap timecreated, message


# Example: Also can use following command:
	Get-EventLog -Source "Citrix Broker Service" -InstanceId 1201,3501,3004 -LogName Application | Select-Object -Property EventID,TimeGenerated,Message -First 5 | ft -AutoSize -Wrap

	# To restart the service.
	Get-Service -DisplayName "*Citrix Broker Service*"| Restart-Service

#============
#Example: Unregistered desktop
  #To check if Servers is registered  use following command on DDC:
	Get-BrokerMachine -AdminAddress DDCservName01 | Format-Table -AutoSize MachineName,RegistrationState,DeliveryType 

  #Restart the service on the Citrix server 
    Get-Service BrokerAgent | Restart-Service 
    
 # TO check event logs for to see if the DDC having issue in registering on Session Host servers

  Get-WinEvent -ProviderName "Citrix Desktop Service" -max 15 | ft -Wrap -AutoSize timecreated, message 
  Get-WinEvent -ProviderName "Citrix Desktop Service" -max 5 | ft -Wrap -AutoSize timecreated, message
#==============

#Check VDP, StroreFront  SDK ports
  PS C:\Program Files\Citrix\Broker\Service> cd 'C:\Program Files\Citrix\Broker\Service\'
  PS C:\Program Files\Citrix\Broker\Service> .\BrokerService.exe /show

	SDK Port: 80
	VDA Port: 80
	StoreFront Port: 80
	StoreFront TLS Port: 443
	Log File:
  
# Checking Database Connection
  Get-EventLog -Source "Citrix Broker Service" -InstanceId 1200, 1201,3501,3004 -LogName Application | Select-Object -Property EventID,TimeGenerated,Message -First 5 | ft -AutoSize -Wrap

#============================================
# Citrix HighAvailbility / LocalHostCache  (LHC)
https://support.citrix.com/article/CTX228758
https://support.citrix.com/article/CTX230775


# If you see an error in event log with instance ID 505 then its an issue.
  Get-EventLog -Source "Citrix ConfigSync Service"  -LogName Application | Select-Object -Property EventID,TimeGenerated,Message -First 5 | ft -AutoSize -Wrap 

#Working LCH example event logs:
  Get-EventLog -Source "Citrix ConfigSync Service"  -LogName Application -ComputerName xisawodcgti02| Select-Object -Property EventID,TimeGenerated,Message -First 5 | ft -AutoSize -Wrap 

  
#============================================

# Check reboot schedule 

 Get-BrokerRebootSchedule | Select-Object -Property DesktopGroupName,Day,Enabled,Frequency,RebootDuration,StartTime,WarningDuration,WarningRepeatInterval |

# Check Logs on DDC

Get-EventLog -LogName Application -InstanceId 3100,3101,3102,3103,3104,3105,3106,3012,3104,3013 -Source *Citrix* | Select-Object -Property EventID,Source,TimeGenerated,Message -First 15 | Format-Table -AutoSize -Wrap
Get-EventLog -LogName Application -InstanceId 3012,3013,3104,3013 -Source "Citrix Broker Service" | Select-Object -Property EventID,Source,TimeGenerated,Message -First 55 | Format-Table -AutoSize -Wrap

Get-EventLog -LogName Application -Source "Citrix Broker Service" | where {$_.Message -like "*domain\HostName*"}| Select-Object -Property EventID,Source,TimeGenerated,Message -First 55 | Format-Table -AutoSize -Wrap

Get-EventLog -LogName Application -InstanceId 3012,3013,3104,3013 -Source "Citrix Broker Service" -After '08/10/2019 00:00:00' | Select-Object -Property EventID,Source,TimeGenerated,Message -First 20 | Format-Table -AutoSize -Wrap

#============================================

#Get Description of Desktop or Applications

  Get-BrokerApplication | select AdminFolderName, Description | ft -AutoSize
  Get-BrokerEntitlementPolicyRule | Select-Object PublishedName,Name,Description | ft -AutoSize



