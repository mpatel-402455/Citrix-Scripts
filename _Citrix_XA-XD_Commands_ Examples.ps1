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
