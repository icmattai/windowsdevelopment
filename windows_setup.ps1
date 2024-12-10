#This Script will Install most applications on a new PC

Write-Output "Gathering Application List"
$applicationList=Import-Csv .\applicationlist.csv
Write-Output "Applications to be installed are:"
$applicationList

foreach($application in $applicationList){
    Write-Output "Installing" $application.appName
    winget install --id $application.appID --source $application.appSource
}

#Uninstall Microsoft Shit
Write-Output "Uninstalling Microsoft Garbage"

Write-Output "Gathering Garbage Application List"
$garbageApplicationList=Import-Csv .\microsoftgarbage.csv
foreach($garbageApplication in $garbageApplicationList){
    Write-Output "Checking if $($garbageApplication.garbageAppName) exists"
    $garbageApplicationTest=Get-AppxPackage -Name $garbageApplication.garbageAppName -ErrorAction SilentlyContinue
    if ($garbageApplicationTest){
        Write-output "$($garbageApplication.garbageAppName) exists and will now be removed"
        Get-AppxPackage -Name $garbageApplication.garbageAppName|Remove-AppPackage
    }
    else{
        Write-Output "$($garbageApplication.garbageAppName) does not exist - No Action Required"
    }  
}