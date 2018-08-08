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
