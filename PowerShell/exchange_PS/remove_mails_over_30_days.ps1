
import-csv -Path "D:\scripts\Green_jaba.csv" | ForEach-Object -Process {
Set-Mailbox -Identity $_.san -RetentionPolicy "Удаление старше 30 дней" }