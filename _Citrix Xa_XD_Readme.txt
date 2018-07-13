How to runn commands for Citrix XA/XD 7.x

How to Connect to 
# XA/XD Controllers
$controllers = @("BrokerController01.qa.lab.local",
                 "BrokerController02.qa.lab.local",
                 "BrokerController03.qa.lab.local",
                 "BrokerController04.qa.lab.local"
                ) 
Add-PSSnapin Citrix.Broker.Admin.* 
Get-BrokerSession -AdminAddress $controllers[0] 

 

https://docs.citrix.com/en-us/xenapp-and-xendesktop/7-6/cds-sdk-wrapper-rho/xad-commands/citrix-broker-admin-v2-wrapper-xd76.html 


Get-BrokerController -AdminAddress "IP or Controllers FQDN"

Example 1:
Get-BrokerSession -AdminAddress BrokerController01 |Select-Object -Property AppState,SessionState,SessionType, ApplicationsInUse, MachineName, UserFullName, UserName -First 1
