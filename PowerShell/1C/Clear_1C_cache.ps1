# Получение текущего пользователя без домена
$user = ((get-wmiobject -Class Win32_Computersystem).Username).replace("LOESK\","")
# Переменная тома с виндой
$c = $env:SYSTEMDRIVE
# Закрытие 1с
Stop-Process -processname 1cv8s -ErrorAction Ignore
# Очистка подпапок
Get-ChildItem ($c+"\users\"+$user+"\AppData\Local\1c\1cv8\") | Remove-Item -force -recurse
Get-ChildItem ($c+"\users\"+$user+"\AppData\Roaming\1C\1cv8\") | Remove-Item -force -recurse