### СКРИПТ ДЛЯ ПРОСМОТРА ЛОГИЧЕСКИХ ДИСКОВ У ПОЛЬЗОВАТЕЛЯ

# Выпадающее окно ввода для переменной $user
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
$nl = [System.Environment]::NewLine
$User = [Microsoft.VisualBasic.Interaction]::InputBox(" Например: ivanov $nl Вводить только одно значение!!!", "Введите Логин пользователя")

# Выпадающее окно ввода для переменной $user
$Computer = [Microsoft.VisualBasic.Interaction]::InputBox(" Например: 00-9301 $nl Вводить только одно значение!!!", "Введите имя компьютера")

# Вводим логин пользователя. Можно раскоментировать read-host и вводить значения прямо в строку выполнения скрипта
# $User = "mamin-an" #read-host "Введите логин пользователя"

# Вводим имя компьютера
# $Computer = "00-9301" #read-host "Введите имя компьютера"

# Получаем SID доменной УЗ пользователя через AD
$SID = ((Get-ADUser $User -Properties *).SID).value

# Заводим путь к ветке реестра HKEY_USERS нужного пользовтеля на основе SID
$Registry = "Registry::HKEY_USERS\"
$HKEY = $Registry+$SID+"\NETWORK\*"

# Запускаем службу WinRM. Если она не запущенна, Invoke-Command не работает!
Set-service WinRM -ComputerName $Computer -Status Running -PassThru

# Получение логических дисков через удаленное выполнения скрипта. По сколько это удаленное выполнение скрипта, необходимо передавать параметры, иначе переменная равна нулю
Invoke-Command –ComputerName $Computer –ScriptBlock {param($HKEY) Get-ItemProperty $HKEY | Select PSChildName,RemotePath} -ArgumentList $HKEY

# Получение Id процесса службы WinRM и остановка служба на основе PId
$Process = Get-WmiObject -Class win32_service -ComputerName $Computer| Where-Object {$_.name -match "WinRM"}
Stop-Process -Id ($Process).ProcessId -Force

# Ожидание 2 секунды и вывод информации о статусе службы.
Start-Sleep -s 2
Write-Host Служба WinRM на компьютере $Computer (Get-WmiObject -Class win32_service -ComputerName $Computer| Where-Object {$_.name -match "WinRM"}).State
break