# Servers for check: 00-rdcb02, 00-rdsgw

function get-logonhistory{
Param (
 [string]$Computer = (Read-Host 00-rdcb02),
 [int]$Days = 1
 )
 cls
 $Result = @()
 Write-Host "Gathering Event Logs, this can take awhile..."
 $ELogs = Get-EventLog Security -Source Microsoft-Windows-Security-Auditing -After (Get-Date).AddDays(-$Days) -ComputerName $Computer
 If ($ELogs)
 { Write-Host "Processing..."
 ForEach ($Log in $ELogs)
 { If ($Log.InstanceId -eq 4624)
   { $ET = "Logon"
   }

   ElseIf ($Log.InstanceId -eq 4672)
   { $ET = "Logon"
   }

   ElseIf ($Log.InstanceId -eq 4634)
   { $ET = "Logoff"
   }

   Else
   { Continue
   }
   $Result += New-Object PSObject -Property @{
    Time = $Log.TimeWritten
    'Event Type' = $ET
   #User = (New-Object System.Security.Principal.SecurityIdentifier $Log.ReplacementStrings[0]).Translate([System.Security.Principal.NTAccount])
   #или это 
   User = $Log.ReplacementStrings[1]
   }
 }
 $Result | Select Time,"Event Type",User | Sort Time -Descending | Export-Csv "C:\Remote_users_00-rdcb02.csv" -Append
 $Result | Select Time,"Event Type",User | Sort Time -Descending | Out-GridView
 Write-Host "Done."
 }
 Else
 { Write-Host "Problem with $Computer."
 Write-Host "If you see a 'Network Path not found' error, try starting the Remote Registry service on that computer."
 Write-Host "Or there are no logon/logoff events (XP requires auditing be turned on)"
 }
}
 
get-logonhistory -Computer "00-rdcb02" -Days "1"
