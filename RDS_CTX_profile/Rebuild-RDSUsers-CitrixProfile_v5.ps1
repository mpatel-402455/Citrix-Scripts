$User = @() #create the empty array (@())
$date = Get-Date -UFormat %b-%d-%Y-%H%M%S
$UserList = (Get-Content -Path D:\MyScripts\IBMS_Scripts\RDS\RDS-UsersList.txt)
#$UserList.gettype()
$TotalProfiles = $UserList.Length
$ProfilePath = "D:\MyScripts\IBMS_Scripts\RDS\"
#$ProfilePath = "\\lab.ca\dfs\TSProf01\"

Write-Verbose -Message ("Scanning total $TotalProfiles profiles for corruption") -Verbose
Write-Verbose -message "Please wait, searching for corrupt Citrix profiles." -verbose


    
    foreach ($user in $UserList) {
    for ($i=0; $i -lt $UserList.Length; $i++) {
        {
            $UserID = $UserList[$i]
            Write-Verbose -Message "Corrupt profile found for: $UserID"  -Verbose
            #$UserList[$i]           
            $CorrupProfile = Get-ChildItem -Path ($ProfilePath + $UserList[$i]+"\*") -Filter *.tmp -Hidden | Select -ExpandProperty DirectoryName -Unique 
            $CorrupProfile
            Write-Verbose -Message "Removing corrupt profile for :$UserID" -Verbose
            
            #REMOVE Profile
            
            if (Test-Path $CorrupProfile)
                {
                    Remove-Item -Path ($CorrupProfile+"\*") -Force -Recurse    
                    $CorruptPrfileCount = $CorruptPrfileCount + 1
                    Write-Verbose -Verbose $CorruptPrfileCount
                }
            else
                {
                    Write-Verbose -Message "No corrupt profile found"
                }
        }
  }
  }
  
    #http://stackoverflow.com/questions/20856634/nested-foreach-in-powershell