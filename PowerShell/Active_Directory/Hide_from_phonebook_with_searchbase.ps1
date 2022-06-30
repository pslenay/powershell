# Подключение модуля AD
Import-Module activedirectory
# Подключение модуля Exchange
# Enter-PSSession -ComputerName "spb-ex2013"

# Получение актуальной даты - 7 дней и запись в переменную
# $OldDate=(Get-Date).AddDays(-7)

# Поиск пользователей в определенной OU
Get-ADUser -SearchBase "OU=Disabled Users,DC=SZ-SPB,DC=SEV-ZAP,DC=RU" -Properties * -Filter *| ForEach-Object -process {


# $ADgroups = Get-ADPrincipalGroupMembership -Identity $_.samaccountname | where {$_.Name -ne "Domain Users"}
# if ($ADgroups -eq $NULL) {
#    write-host "Пользователь $_.samaccountname не имеет назначенных групп" -foregroundcolor red -backgroundcolor black}
# else {
# Remove-ADPrincipalGroupMembership -Identity $_.samaccountname -MemberOf $ADgroups -Confirm:$false
# Write-Host -ForegroundColor Green "Список групп, из которых исключен пользователь $_.samaccountname"
# $adgroups | ft name
# $Adusers = $null
# $adgroups = $null
# }


# Скрытие найденной УЗ с списке почтовых адресатов Exchange
Set-Mailbox -Identity $_.samaccountname -HiddenFromAddressListsEnabled $true

# Применение политики хранения для писем в почтовых ящиках "Удаление старше 30 дней"
# Set-Mailbox -Identity $_.samaccountname -RetentionPolicy "Удаление старше 30 дней" 

# Очистка поля Manager в карточке пользователя
Set-ADUser -Identity $_.samaccountname -Manager $NULL

# Очистка полей телефонов
Set-ADUser -Identity $_.samaccountname -HomePhone $null
Set-ADUser -Identity $_.samaccountname -OfficePhone $null
Set-ADUser -Identity $_.samaccountname -MobilePhone $null
Set-ADUser -Identity $_.samaccountname -fax $null
Set-ADUser -Identity $_.samaccountname -Clear otherTelephone
Set-ADUser -Identity $_.samaccountname -Clear ipPhone
Set-ADUser -Identity $_.samaccountname -Clear pager

# Очистка поля Office (офис)
Set-ADUser -Identity $_.samaccountname -Office $null
}
