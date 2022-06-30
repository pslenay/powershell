####### ИТЕРАЦИЯ С ПОЛЬЗОВАТЕЛЯМИ №2
# Создание массива $users, поиск с фильтром по выключенным УЗ в "OU=Центральный аппарат,DC=loesk,DC=lokal"
# Примечание: Вопросительный знак - алиас для where
$users = Get-ADUser -searchbase "OU=Центральный аппарат,DC=loesk,DC=lokal" -Properties * -Filter {enabled -eq 'false'}

ForEach ($user in $users) {
#Вывод информации по перемещаемому сотруднику (ФИО, расположение)
Write-Host Директория пользователя $user.Name и должность $user.Title до перемещения: $user.DistinguishedName

# Перенос пользователя в нужную OU в зависомости от LastLogonDate
# ([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) - преобразовывает абракадабру в AD в поле "LastLogon" в человеческий вид времени
if (!(([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)))) {Write-Host У пользователя $User.Name нет Lastlogon даты}
if (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -lt (Get-Date) -and (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-30)))) {Write-Host Пользователь $user.SamAccountName логинился меньше месяца назад}
if (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-31)) -and (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-60)))) {Move-ADObject $user -TargetPath "OU=1 месяц OFF,OU=Users,OU=OFF,DC=loesk,DC=lokal"}
if (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-61)) -and (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-90)))) {Move-ADObject $user -TargetPath "OU=2 месяца OFF,OU=Users,OU=OFF,DC=loesk,DC=lokal"}
if (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-91)) -and (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-2000)))) {Move-ADObject $user -TargetPath "OU=3 месяца OFF,OU=Users,OU=OFF,DC=loesk,DC=lokal"}
$user=$null
}


####### ИТЕРАЦИЯ С ПОЛЬЗОВАТЕЛЯМИ №2
# Создание массива $users, поиск с фильтром по выключенным УЗ в "OU=Filials,DC=loesk,DC=lokal"
# Примечание: Вопросительный знак - алиас для where
$users = Get-ADUser -searchbase "OU=Filials,DC=loesk,DC=lokal" -Properties * -Filter {enabled -eq 'false'}

ForEach ($user in $users) {
#Вывод информации по перемещаемому сотруднику (ФИО, расположение)
Write-Host Директория пользователя $user.Name и должность $user.Title до перемещения: $user.DistinguishedName

# Перенос пользователя в нужную OU в зависомости от LastLogonDate
# ([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) - преобразовывает абракадабру в AD в поле "LastLogon" в человеческий вид времени
if (!(([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)))) {Write-Host У пользователя $User.Name нет Lastlogon даты}
if (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -lt (Get-Date) -and (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-30)))) {Write-Host Пользователь $user.SamAccountName логинился меньше месяца назад}
if (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-31)) -and (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-60)))) {Move-ADObject $user -TargetPath "OU=1 месяц OFF,OU=Users,OU=OFF,DC=loesk,DC=lokal"}
if (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-61)) -and (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-90)))) {Move-ADObject $user -TargetPath "OU=2 месяца OFF,OU=Users,OU=OFF,DC=loesk,DC=lokal"}
if (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-91)) -and (([datetime]::FromFileTime((Get-ADUser $user -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-2000)))) {Move-ADObject $user -TargetPath "OU=3 месяца OFF,OU=Users,OU=OFF,DC=loesk,DC=lokal"}
$user=$null
}




####### ИТЕРАЦИЯ С КОМПЬЮТЕРАМИ №1
# Создание массива и поиск с фильтром по LastLogonDate в "OU=Центральный аппарат,DC=loesk,DC=lokal"
# Примечание: Вопросительный знак - алиас для where
$Computers = Get-ADComputer -searchbase "OU=Центральный аппарат,DC=loesk,DC=lokal" -Properties * -Filter * 

ForEach ($Computer in $Computers) {

# Вывод информации по перемещнному компьютеру (Имя, расположение)
Write-Host Директория компьютера $Computer.Name до перемещения: $Computer.DistinguishedName

# Перенос пользователя в нужную OU в зависомости от LastLogonDate
# ([datetime]::FromFileTime((Get-ADComputer $Compute -Properties *).LastLogon)) - преобразовывает абракадабру в AD в поле "LastLogon" в человеческий вид времени
if (!(([datetime]::FromFileTime((Get-ADComputer $Compute -Properties *).LastLogon)))) {Write-Host На компьютере $Computer.Name нет Lastlogon даты}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt (Get-Date) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-30)))) {Write-Host Компьютер $Computer.Name логинился меньше месяца назад}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-31)) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-60)))) {Write-Host Компьютер $Computer.Name логинился меньше 2-х месяцев назад}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-61)) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-90)))) {Move-ADObject $Computer -TargetPath "OU=2 месяца OFF,OU=Computers,OU=OFF,DC=loesk,DC=lokal"}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-91)) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-2000)))) {Move-ADObject $Computer -TargetPath "OU=3 месяца OFF,OU=Computers,OU=OFF,DC=loesk,DC=lokal"}
}


####### ИТЕРАЦИЯ С КОМПЬЮТЕРАМИ №2
# Создание массива и поиск с фильтром по LastLogonDate в "OU=Filials,DC=loesk,DC=lokal"
# Примечание: Вопросительный знак - алиас для where
$Computers = Get-ADComputer -searchbase "OU=Filials,DC=loesk,DC=lokal" -Properties * -Filter * 

ForEach ($Computer in $Computers) {

# Вывод информации по перемещнному компьютеру (Имя, расположение)
Write-Host Директория компьютера $Computer.Name до перемещения: $Computer.DistinguishedName

# Перенос пользователя в нужную OU в зависомости от LastLogonDate
# ([datetime]::FromFileTime((Get-ADComputer $Compute -Properties *).LastLogon)) - преобразовывает абракадабру в AD в поле "LastLogon" в человеческий вид времени
if (!(([datetime]::FromFileTime((Get-ADComputer $Compute -Properties *).LastLogon)))) {Write-Host На компьютере $Computer.Name нет Lastlogon даты}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt (Get-Date) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-30)))) {Write-Host Компьютер $Computer.Name логинился меньше месяца назад}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-31)) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-60)))) {Write-Host Компьютер $Computer.Name логинился меньше 2-х месяцев назад}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-61)) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-90)))) {Move-ADObject $Computer -TargetPath "OU=2 месяца OFF,OU=Computers,OU=OFF,DC=loesk,DC=lokal"}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-91)) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-2000)))) {Move-ADObject $Computer -TargetPath "OU=3 месяца OFF,OU=Computers,OU=OFF,DC=loesk,DC=lokal"}
}


####### ИТЕРАЦИЯ С КОМПЬЮТЕРАМИ №3
# Создание массива и поиск с фильтром по LastLogonDate (младше 3 месяцев и старше 2 месяцев) в "OU=Computers,DC=loesk,DC=lokal"
# Примечание: Вопросительный знак - алиас для where
$Computers = Get-ADComputer -searchbase "OU=Computers,DC=loesk,DC=lokal" -Properties * -Filter * | ? {$_.LastLogonDate -lt ((Get-Date).AddDays(-60))}

ForEach ($Computer in $Computers) {

# Вывод информации по перемещнному компьютеру (Имя, расположение)
Write-Host Директория компьютера $Computer.Name до перемещения: $Computer.DistinguishedName

# Перенос пользователя в нужную OU в зависомости от LastLogonDate
# ([datetime]::FromFileTime((Get-ADComputer $Compute -Properties *).LastLogon)) - преобразовывает абракадабру в AD в поле "LastLogon" в человеческий вид времени
if (!(([datetime]::FromFileTime((Get-ADComputer $Compute -Properties *).LastLogon)))) {Write-Host На компьютере $Computer.Name нет Lastlogon даты}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt (Get-Date) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-30)))) {Write-Host Компьютер $Computer.Name логинился меньше месяца назад}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-31)) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-60)))) {Write-Host Компьютер $Computer.Name логинился меньше 2-х месяцев назад}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-61)) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-90)))) {Move-ADObject $Computer -TargetPath "OU=2 месяца OFF,OU=Computers,OU=OFF,DC=loesk,DC=lokal"}
if (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -lt ((Get-Date).AddDays(-91)) -and (([datetime]::FromFileTime((Get-ADComputer $Computer -Properties *).LastLogon)) -gt ((Get-Date).AddDays(-2000)))) {Move-ADObject $Computer -TargetPath "OU=3 месяца OFF,OU=Computers,OU=OFF,DC=loesk,DC=lokal"}
}