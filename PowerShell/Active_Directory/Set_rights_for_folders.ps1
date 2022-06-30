# Права наследования:
# (OI) — object inherit
# (CI) — container inherit
# (IO) — inherit only
# (NP) — don’t propagate inherit
# (I) — Permission inherited from parent container

# Список основных прав доступа:
# D — право удаления
# F — полный доступ
# N — нет доступа
# M — доступ на изменение
# RX — доступ на чтение и запуск
# R — доступ только на чтение
# W — доступ только на запись

# Детальные разрешения:
# DE — Delete
# RC — read control
# WDAC — write DAC
# WO — write owner
# S — synchronize
# AS — access system security
# MA — maximum allowed
# GR — generic read
# GW — generic write
# GE — generic execute
# GA — generic all
# RD — read data/list directory
# WD — write data/add file
# AD — append data/add subdirectory
# REA — read extended attributes
# WEA — write extended attributes
# X — execute/traverse
# DC — delete child
# RA — read attributes
# WA — write attributes

# Параметры командной строки iCACLS:
#/T - операция выполняется для всех соответствующих файлов и каталогов, расположенных в заданном каталоге.
#/C - выполнение операции продолжается при любых файловых ошибках. Сообщения об ошибках по-прежнему выводятся на экран. 
#/L - операция выполняется над самой символьной ссылкой, а не над ее целевым объектом. 
#/Q - утилита ICACLS подавляет сообщения об успешном выполнении. 

# Настройка наследования:
# e - включение наследования
# d - отключение наследования и копирование ACE (Access Control Entries).
# r - удаление всех унаследованных ACE

# Пример для добавление группы на определенную папку
# ВНИМАНИЕ, ПРАВА НА НИЖЕ СТОЯЩИЕ ПАПКИ ТАКЖЕ БУДУТ ИЗМЕНЕНЫ, ДАЖЕ ЕСЛИ ОТКЛЮЧЕНО НАСЛЕДОВАНИЕ! (Уберите ключ "/T", если не нужно применение на все файлы и каталоги)
# start-process "icacls.exe" -ArgumentList '"D:\Всякая фигня\Test\1" /grant "main\R78-fs01-Finance_PEO-RO":(OI)(CI)(RX) /T /C /Q'

# Для всех папок и подпапок нужно писать -Recurse

# Настройка прав для папок на 1 уровень ниже искомой. ""=' (при одинарной кавычке, в коде не идет обращение к переменной, читает ее как строку). 
# ВНИМАНИЕ, ПРАВА НА НИЖЕ СТОЯЩИЕ ПАПКИ ТАКЖЕ БУДУТ ИЗМЕНЕНЫ, ДАЖЕ ЕСЛИ ОТКЛЮЧЕНО НАСЛЕДОВАНИЕ! (Уберите ключ "/T", если не нужно применение на все файлы и каталоги):
Get-ChildItem -Directory -Path "D:\Всякая фигня\Test" | % {
$path = $_.FullName
write """$path"" /grant ""main\R78-fs01-Finance_PEO-RO"":(OI)(CI)(RX) /T /C /Q"
start-process "icacls.exe" -ArgumentList """$path"" /grant ""main\R78-fs01-Finance_PEO-RO"":(OI)(CI)(RX) /T /C /Q"
}  