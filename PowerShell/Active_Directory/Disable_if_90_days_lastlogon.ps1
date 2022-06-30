# Скрипт очистки полей в уволенных
# Подключение модуля AD
Import-Module activedirectory
# Получение актуальной даты минус 90 дней и запись в переменную
$OldDate=(Get-Date).AddDays(-90)
# Поиск пользователей с отключенной УЗ последним входом в систему страше 90 дней от актуальной даты в юнитах AD
Get-ADUser -SearchBase "OU=уволенные,OU=Users,OU=R39,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Properties * -Filter * |Where {!($_.LastLogonDate) -or $_.LastLogonDate -lt $OldDate} | ForEach-Object -process { 
Set-ADUser -Identity $_.samaccountname -Enabled $false }