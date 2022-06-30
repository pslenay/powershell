##### СКРИПТ ДЛЯ ВЕРСИИ 8.3.15.1830!!! 
##### В СЛУЧАЕ ИЗМЕНЕНИЯ ВЕРСИИ ИЛИ ПУТЬ НЕ ЗАБУДЬ ИЗМЕНИТЬ:
##### ПУТЬ ДО ФАЙЛОВ 1С
##### ПРОВЕРИТЬ БАТНИКИ В NETLOGON НА DOMAIN CONTROLLER И ИХ СОДЕРЖИМОЕ
##### ПРОВЕРИТЬ ВЕРСИИ VC_REDIST
##### ПРОВЕРИТЬ .INI ФАЙЛ

# ПРОВЕРКА ОС НА DC И SERVER. ЕСЛИ TRUE - НЕ ВЫПОЛНЯТЬ СКРИПТ.
# If ( (Get-WmiObject -Class Win32_OperatingSystem).ProductType -match "2|3") {Write-Host IT`S A SERVER OR DC!!! NONONO!!!} # 2 - DC (Domain controller), 3 - Server OS
    If ( (Get-WmiObject -Class Win32_OperatingSystem).ProductType -match "3") # 3 - Server OS
        {Write-Host IT"'"S A SERVER!!! NONONO!!!}

    Elseif ( (Get-WmiObject -Class Win32_OperatingSystem).ProductType -match "2") # 2 - DC (Domain controller)
        {Write-Host IT"'"S A DC!!! NONONO!!!}

    Else{
        Write-Host workstation
# ОЧИСТКА КЭША ПОЛЬЗОВАТЕЛЯ
# Получение текущего пользователя без домена
    $user = ((get-wmiobject -Class Win32_Computersystem).Username).replace("LOESK\","")
# Переменная тома с виндой
    $c = $env:SYSTEMDRIVE
# Закрытие 1с
    Stop-Process -processname 1cv8s -ErrorAction Ignore
# Очистка подпапок
    Get-ChildItem ($c+"\users\"+$user+"\AppData\Local\1c\1cv8\") | Remove-Item -force -recurse -ErrorAction Ignore
    Get-ChildItem ($c+"\users\"+$user+"\AppData\Roaming\1C\1cv8\") | Remove-Item -force -recurse -ErrorAction Ignore
# Очистка переменных
    $c = $null
    $user =$null

# ДЕИНСТАЛЯЦИЯ ВСЕХ ВЕРСИЙ 1С НА КОМПЬЮТЕРЕ

    $1c_installed = Get-WmiObject Win32_Product | Where-Object {$_.Name -match "^(1С|1C)"}
        ForEach ($1c_remove in $1c_installed) {
        $IdentifyingNumber = ($1c_remove).IdentifyingNumber
        Start-Process -Wait -FilePath msiexec -ArgumentList  ('/uninstall "' + $IdentifyingNumber + '"/quiet /norestart""')}


# ПРОВЕРКА ОС НА БИТНОСТЬ И УСТАНОВКА ПО 1C 8.3.15.1830 (ВЕРСИЯ vc_redist - 14.14.26405).
    # Для 32-х битной ОС
        If ( (Get-WmiObject Win32_OperatingSystem).OSArchitecture -match "32") {
        
        # Проверка наличия vc_redist для 32-х битной версии

             If (Get-WmiObject Win32_Product | Where-Object {$_.Name -match "x86 Additional Runtime - 14.14.26405"}) 
                {Write-Host already exist}

             else {
        # Если vc_redist.x86.exe нет - установка
        # $vc_redist_x86 = (Get-ChildItem -Path '\\sccm\SCCM_Library\Soft\Office\1C\8.3.15.1830 x32\vc_redist.x86.exe' | Where-Object {$_.Name -match "^vc_redist.*.exe$"}).Name
             Start-Process -Wait -FilePath '\\sccm\SCCM_Library\Soft\Office\1C\8.3.15.1830 x32\vc_redist.x86.exe' -ArgumentList ('/install /quiet ')
             }

        # Проверка существования msi файла
        # $1c_x86 = (Get-ChildItem -Path '\\sccm\SCCM_Library\Soft\Office\1C\8.3.15.1830 x32' | Where-Object {$_.Name -match "^(1CEnterprise 8 \(x86-64\)|1CEnterprise 8)\.msi$"}).Name
            \\loesk.lokal\NETLOGON\install_1c\install_1c_x86_8_3_15_1830.bat
    } 

        else {
            If (Get-WmiObject Win32_Product | Where-Object {$_.Name -match "x64 Additional Runtime - 14.14.26405"}) 
                {Write-Host already exist}

           else {
           # Если vc_redist.x64.exe нет - установка
           # $vc_redist_x64 = (Get-ChildItem -Path '\\sccm\SCCM_Library\Soft\Office\1C\8.3.15.1830 x64' | Where-Object {$_.Name -match "^vc_redist.*.exe$"}).Name
                Start-Process -Wait -FilePath '\\sccm\SCCM_Library\Soft\Office\1C\8.3.15.1830 x64\vc_redist.x64.exe' -ArgumentList ('/install /quiet ')
                }

        # Проверка существования msi файла
        # $1c_x64 = (Get-ChildItem -Path '\\sccm\SCCM_Library\Soft\Office\1C\8.3.15.1830 x64' | Where-Object {$_.Name -match "^(1CEnterprise 8 \(x86-64\)|1CEnterprise 8)\.msi$"}).Name
            \\loesk.lokal\NETLOGON\install_1c\install_1c_x64_8_3_15_1830.bat
             }
}