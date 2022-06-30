chcp 1251
Forfiles -p "D:\Shares\Группа развития розничной сети" -s -m *.* -d -30 -c "cmd /c del /q @path"