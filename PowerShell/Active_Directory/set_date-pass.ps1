Import-Module ActiveDirectory
# Установка срока действия УЗ и запрет смены пароля
Get-ADUser -SearchBase "OU=ООО НСТ,OU=Subcontractors,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Filter "enabled -eq 'true'" | ForEach-Object -process { Set-ADUser -Identity $_.SamAccountName -AccountExpirationDate 15.02.2020 }
Get-ADUser -SearchBase "OU=ООО НСТ,OU=Subcontractors,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Filter "enabled -eq 'true'" | ForEach-Object -process { Set-ADUser -Identity $_.SamAccountName -PasswordNeverExpires $true }