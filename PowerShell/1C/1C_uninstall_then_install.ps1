# Деинсталяция всех версий 1С на компьютере

$1c_installed = Get-WmiObject Win32_Product | Where-Object {$_.Name -match "^(1С|1C)"}
ForEach ($1c_remove in $1c_installed) {
     $IdentifyingNumber = ($1c_remove).IdentifyingNumber
     Start-Process -Wait -FilePath msiexec -ArgumentList  ('/uninstall "' + $IdentifyingNumber + '"/quiet /norestart""')}


# Проверка ОС на битность и установка ПО 1C 8.3.15.1830 (Версия vc_redist - 14.14.26405).
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