# Example : Get all Citrix Sessions

  Get-BrokerSession -AdminAddress Xisadcgti05 |Select-Object -Property AppState,SessionState,SessionType, @{Name='ApplicationName';E={$_.ApplicationsInUse}}, MachineName, UserFullName, UserName, UntrustedUserName 

