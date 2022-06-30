#Get-ADUser -SearchBase ‘OU=уволенные,OU=Users,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru’ -filter * -properties TelephoneNumber, OfficePhone | ft Name, TelephoneNumber, OfficePhone > C:\Users\alexander.mamin\Desktop

#выгрузка пользователей через список в csv
Import-Module activedirectory
#$users = import-csv -Path "D:\scripts\dismissed.csv"
Remove-Item -Path D:\junk\missnumberALL.csv -Force

#$a= $user.name
Get-ADUser -searchbase "OU=Users,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Filter {TelephoneNumber -like "*616*,,*"} -Properties * | select displayname,samaccountname,TelephoneNumber | Export-Csv -Path D:\junk\missnumberAll.csv -Delimiter ";" -Append -Force -Encoding utf8 -NoTypeInformation
Get-ADUser -searchbase "OU=Users,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Filter {TelephoneNumber -like "*616*,,*"} -Properties * | select displayname,samaccountname,TelephoneNumber | Write-Host