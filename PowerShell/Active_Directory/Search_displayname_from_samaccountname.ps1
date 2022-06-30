# Поиск ФИО по логину
Import-Module ActiveDirectory
Import-CSV -Path "D:\scripts\get-aduser.csv" | ForEach-Object -process {
Get-ADUser -Identity $_.Name -Properties * | select displayname,Department,enabled,distinguishedname | Export-Csv -Path D:\junk\get-aduser_res.csv -Append -Force -Encoding utf8 -NoTypeInformation
}