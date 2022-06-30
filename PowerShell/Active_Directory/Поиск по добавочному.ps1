# Выпадающее окно ввода для переменной $user
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
$nl = [System.Environment]::NewLine

$Number = [Microsoft.VisualBasic.Interaction]::InputBox(" Например: 1996 $nl Вводить только одно значение!!!", "Введите добавочный")

Get-ADUser -SearchBase "DC=loesk,DC=lokal" -Properties * -LDAPFilter "(msRTCSIP-Line=*$number*)" | ft name, SamAccountName

Read-Host -Prompt "Press Enter to exit"