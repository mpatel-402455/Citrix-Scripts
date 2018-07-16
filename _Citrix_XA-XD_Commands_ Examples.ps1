# Example : Get all Citrix Sessions
  Get-BrokerSession -AdminAddress BrokerController01 | Select-Object -Property AppState,SessionState,SessionType, @{Name='ApplicationName';E={$_.ApplicationsInUse}}, MachineName, UserFullName, UserName, UntrustedUserName 

# Example: Get specified users session
  Get-BrokerSession -AdminAddress BrokerController01 | Where-Object {$_.UserName -eq "DomainName\userID"} | Select-Object -Property AppState,SessionState,SessionType, @{Name='ApplicationName';E={$_.ApplicationsInUse}}, MachineName, UserFullName, UserName, UntrustedUserName  

# Example: Stops or Logs Off specified users session
  Get-BrokerSession -AdminAddress BrokerController01 | Where-Object {$_.UserName -eq "DomainName\userID"} | Stop-BrokerSession 

