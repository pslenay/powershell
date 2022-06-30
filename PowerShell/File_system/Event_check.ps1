Get-WinEvent -EA SilentlyContinue -FilterHashtable @{
    LogName = "Security";
    StartTime = (Get-Date).AddHours(-1);
    ID = 4720,4722,4725,4726,4740,4767} |
select TimeCreated,
       Id,
       @{N = 'UserName'; E = {(([xml]$_.ToXml()).event.EventData.Data | ? Name -eq 'TargetUserName').'#text'}},
       @{N = 'Operator'; E = {(([xml]$_.ToXml()).event.EventData.Data | ? Name -eq 'SubjectUserName').'#text'}},
	   @{N = 'DisplayName'; E = {(([xml]$_.ToXml()).event.EventData.Data | ? Name -eq 'DisplayName').'#text'}},
       @{N = 'Message';  E = {$_.Message.Split('.')[0]}} | Export-Csv -Delimiter ';' -Encoding UTF8 -Path C:\Temp\audit_log_csv -Append