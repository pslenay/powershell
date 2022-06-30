# Подключаем модуль Powershell для работы с AD
Import-Module ActiveDirectory

# OU Куда переносим пользователей
$targetOU = "OU=OFF,DC=loesk,DC=lokal"

# OU Откуда берем пользователей
$sourceOU="OU=Отдел ИБ,OU=ЗГД по безопасности,OU=Центральный аппарат,DC=loesk,DC=lokal"

# Создание массива $users, поиск с фильтром по выключенныем УЗ в $sourceOU, при условии, что пользователи не находятся в $targetOU
# Примечание: Вопросительный знак - алиас для where
$users = Get-ADUser -searchbase $sourceOU -Properties * -Filter {enabled -eq 'false'} | ? {$_.CN -notlike "OU=OFF,DC=loesk,DC=lokal"}

# Запуск цикла и обработка каждой строки массива
ForEach ($user in $users) 
{
# Перенос пользователя в нужную $targetOU
Move-ADObject $user -TargetPath $targetOU

#Вывод информации по перемещнному сотруднику (ФИО, должность)
Write-Host $_.Name -NoNewline
Write-Host " -"$_.Title

#Вывод на экран куда перемещен пользователь.
Write-Host $targetOU
}