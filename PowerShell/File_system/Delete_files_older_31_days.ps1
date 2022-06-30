# Установка предельной даты изменения файла (старше этого периода файл будут удален)
$limit = (Get-Date).AddDays(-31)
# $IsDir = {$_.PsIsContainer} Директория
# $IsFile = {!$_.PsIsContainer} Файл
# Удаление только файлов из папки и подпапок (без удаления подпапок)
# Get-ChildItem C:\test -Include *.* -Exclude C:\test\test\not -Recurse |ForEach { $_.Delete()} #|Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit -and $_.LastWriteTime -lt $limit  } |ForEach { $_.Delete()}
Get-ChildItem –Path "\\loesk\обмен" -Recurse  -File | Where-Object {$_.Directory -notlike "\\loesk\обмен\PST*"}`
                                                    | Where-Object {$_.Directory -notlike "\\loesk\обмен\Сектор_связи*"}`
                                                    | Where-Object {$_.Directory -notlike "‪\\loesk\обмен\Юрист"}`
                                                    | Where-Object {$_.Directory -notlike "‪\\loesk\обмен\Филиалы\Восточный"}`
                                                    | Where-Object {$_.Directory -notlike "‪\\loesk\обмен\Филиалы\Западный"}`
                                                    | Where-Object {$_.Directory -notlike "\\loesk\обмен\Филиалы\Пригородный"}`
                                                    | Where-Object {$_.Directory -notlike "‪\\loesk\обмен\Филиалы\Северный"}`
                                                    | Where-Object {$_.Directory -notlike "‪\\loesk\обмен\Филиалы\Центральный"}`
                                                    | Where-Object {$_.Directory -notlike "\\loesk\обмен\Филиалы\Южный"}`
                                                    | Where-Object {$_.Directory -notlike "\\loesk\обмен\Общая\ОРП_ВРП*"}`
                                                    | Where-Object {$_.Directory -notlike "\\loesk\обмен\Общая\Приказ 904*"}`
                                                    | Where-Object {$_.Directory -notlike "\\loesk\обмен\Общая\Сектор_связи*"}`
                                                    | Where-Object {$_.Directory -notlike "\\loesk\обмен\Общая\ФРВ*"}`
                                                    | Where-Object {!$_.PSIsContainer}`
                                                    | Where-Object {$_.CreationTime -lt $limit}`
                                                    | Where-Object {$_.LastWriteTime -lt $limit }`
                                                    | ForEach {$_.Delete()}


##### Удаление пустых папок
# Восточный
Get-ChildItem -Path "\\loesk\обмен\Филиалы\Восточный" -Recurse -Force | 
Where-Object {$_.PSIsContainer -eq $true} | 
% {if((Get-ChildItem -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | 
    Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).sum -eq $null){Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue}
}

# Западный
Get-ChildItem -Path "\\loesk\обмен\Филиалы\Западный" -Recurse -Force | 
Where-Object {$_.PSIsContainer -eq $true} | 
% {if((Get-ChildItem -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | 
    Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).sum -eq $null){Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue}
}

# Пригородный
Get-ChildItem -Path "\\loesk\обмен\Филиалы\Пригородный" -Recurse -Force | 
Where-Object {$_.PSIsContainer -eq $true} | 
% {if((Get-ChildItem -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | 
    Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).sum -eq $null){Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue}
}

# Северный
Get-ChildItem -Path "\\loesk\обмен\Филиалы\Северный" -Recurse -Force | 
Where-Object {$_.PSIsContainer -eq $true} | 
% {if((Get-ChildItem -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | 
    Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).sum -eq $null){Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue}
}

# Центральный
Get-ChildItem -Path "\\loesk\обмен\Филиалы\Центральный" -Recurse -Force | 
Where-Object {$_.PSIsContainer -eq $true} | 
% {if((Get-ChildItem -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | 
    Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).sum -eq $null){Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue}
}

# Южный
Get-ChildItem -Path "\\loesk\обмен\Филиалы\Южный" -Recurse -Force | 
Where-Object {$_.PSIsContainer -eq $true} | 
% {if((Get-ChildItem -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | 
    Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).sum -eq $null){Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue}
}