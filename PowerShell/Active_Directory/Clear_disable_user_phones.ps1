# Скрипт очистки полей в уволенных
# Подключение модуля AD
Import-Module activedirectory

# Получение актуальной даты - 7 дней и запись в переменную
$OldDate=(Get-Date).AddDays(-7)

# Поиск пользователей с отключенной УЗ последним входом в систему страше 7 дней от актуальной даты в юнитах AD
Get-ADUser -SearchBase "DC=loesk,DC=lokal" -Properties * -Filter {enabled -eq 'false'} | ForEach-Object -process {

# Очистка полей телефонов
Set-ADUser -Identity $_.samaccountname -HomePhone $null
Set-ADUser -Identity $_.samaccountname -OfficePhone $null
Set-ADUser -Identity $_.samaccountname -MobilePhone $null
Set-ADUser -Identity $_.samaccountname -fax $null
Set-ADUser -Identity $_.samaccountname -Clear otherTelephone
Set-ADUser -Identity $_.samaccountname -Clear ipPhone
Set-ADUser -Identity $_.samaccountname -Clear pager
Set-ADUser -Identity $_.samaccountname -Clear 'msRTCSIP-Line'
}