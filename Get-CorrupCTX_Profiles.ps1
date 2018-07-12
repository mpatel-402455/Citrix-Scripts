$date = Get-Date -UFormat %b-%d-%Y-%H%M%S

$profiel_path= \\dev.lab.ca\ctxprof\TSProf01\*\*
Write-Verbose -message "Please wait searching for corrupt profiles." -verbose

#$profiles = (Get-ChildItem \\corp.ctv.ca\agfs\TSProf01\*\* -Filter *.tmp -Hidden | Select -ExpandProperty DirectoryName -Unique) 
$profiles = (Get-ChildItem \\dev.lab.ca\ctxprof\TSProf01\*\* -Filter *.tmp -Hidden | Select -ExpandProperty DirectoryName -Unique) 
$profiles | Out-File "D:\MyScripts\Output Files\Corrupt_Profiles_$date.txt"
$PCount = $profiles.Count

Write-Verbose  "$PCount corrupt profiles are found."-Verbose
