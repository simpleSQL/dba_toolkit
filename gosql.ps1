<#
Powershell Script to Flip On/Off SQL Server Services
Version: 1.2
Compat: SQL Server 2019
Author: Jack Worthen
Date: 03/06/2021
jackworthen.com
#>

clear-host
 
$svc=Get-Service
$i
$i=1
foreach($service in $svc)
{
if ($svc[$i].name -eq "MSSQLSERVER" -or
    $svc[$i].name -eq "SQLSERVERAGENT" -or
    $svc[$i].name -eq "MSSQLFDLauncher" -or
    $svc[$i].name -eq "SQLServerReportingServices" -or
    $svc[$i].name -eq "MsDtsServer150" -or
    $svc[$i].name -eq "SQLTELEMETRY" -or
    $svc[$i].name -eq "SSISTELEMETRY150" -or
    $svc[$i].name -eq "SQLWriter")
    {
        if($svc[$i].status -eq "Stopped")
        {
            start-service -name $svc[$i].Name -PassThru
        }
        if($svc[$i].status -eq "Running")
        {    
            stop-service -name $svc[$i].Name -Force -PassThru
        }
        }
$i++
}
Write-Output " "
Write-Output "SQL Services Successfully Flipped." 
Read-Host -Prompt "Press Enter"
