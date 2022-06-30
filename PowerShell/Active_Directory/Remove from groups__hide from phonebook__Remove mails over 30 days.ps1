# Скрипт очистки полей в уволенных
# Подключение модуля AD
Import-Module activedirectory
# Подключение модуля Exchange
Import-PSSession (New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://R00excashub02.main.russianpost.ru/powershell/ -Authentication Kerberos)
# Получение актуальной даты - 7 дней и запись в переменную
$OldDate=(Get-Date).AddDays(-7)
# Поиск пользователей с отключенной УЗ последним входом в систему страше 7 дней от актуальной даты в юнитах AD
Get-ADUser -SearchBase "OU=уволенные,OU=Users,OU=R39,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Properties * -Filter {enabled -eq 'false'} |Where {!($_.LastLogonDate) -or $_.LastLogonDate -lt $OldDate} | ForEach-Object -process {
$ADgroups = Get-ADPrincipalGroupMembership -Identity $_.samaccountname | where {$_.Name -ne "Domain Users"}
if ($ADgroups -eq $NULL) {
    write-host "Пользователь $_.samaccountname не имеет назначенных групп" -foregroundcolor red -backgroundcolor black}
else {
Remove-ADPrincipalGroupMembership -Identity $_.samaccountname -MemberOf $ADgroups -Confirm:$false
Write-Host -ForegroundColor Green "Список групп, из которых исключен пользователь $_.samaccountname"
$adgroups | ft name
$Adusers = $null
$adgroups = $null
}

# Скрытие найденной УЗ с списке почтовых адресатов Exchange
Set-Mailbox -Identity $_.samaccountname -HiddenFromAddressListsEnabled $true
# Применение политики хранения для писем в почтовых ящиках "Удаление старше 30 дней"
Set-Mailbox -Identity $_.samaccountname -RetentionPolicy "Удаление старше 30 дней" 
# Очистка поля Manager в карточке пользователя
Set-ADUser -Identity $_.samaccountname -Manager $NULL
# Очистка полей телефонов
Set-ADUser -Identity $_.samaccountname -HomePhone $NULL
Set-ADUser -Identity $_.samaccountname -OfficePhone $NULL
Set-ADUser -Identity $_.samaccountname -MobilePhone $NULL
Set-ADUser -Identity $_.samaccountname -fax $NULL
}
