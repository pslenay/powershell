$Sender = "Кому отправить"
$Subject = 'Внимание! Скоро истекает срок действия Вашего пароля!'
$BodyTxt1 = 'Срок действия Вашего пароля для'
$BodyTxt2 = 'заканчивается через '
$BodyTxt3 = 'дней. Не забудьте заранее сменить Ваш пароль (Инструкция по смене пароля во вложении).'
$BodyTxt4 = 'В случае возникновения вопросов, обратитесь в службу "!!Техническая поддержка".'
$Attachment = "Локальный путь до файла"
$smtpserver ="Имя SMTP сервера"
$warnDays = (get-date).adddays(7)
$2Day = get-date

# Поиск пользователей с истекающим паролем (7/3/менее одного дня осталось до истечения) и отправка ему сообщения с информацией по смене пароля

$UXUsers = Get-ADUser -SearchBase 'OU=Отделы,DC=Domen,DC=RU' -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} -Properties msDS-UserPasswordExpiryTimeComputed, EmailAddress, Name | select Name, @{Name ="ExpirationDate";Expression= {[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}, EmailAddress
foreach ($user in $UXUsers) {
if (($user.ExpirationDate -lt (get-date).adddays(8)) -and ($user.ExpirationDate -gt (get-date).adddays(6))) {
$lastdays = ( $user.ExpirationDate -$2Day).days
$EmailBody = $BodyTxt1, $user.name, $BodyTxt2, $lastdays, $BodyTxt3 + [System.Environment]::NewLine + $BodyTxt4  -join ' '
Send-MailMessage -To $user.EmailAddress -From $Sender -SmtpServer $smtpserver -Subject $Subject -Body $EmailBody -Attachments $Attachment -Encoding 'UTF8'}

if (($user.ExpirationDate -lt (get-date).adddays(4)) -and ($user.ExpirationDate -gt (get-date).adddays(2))) {
$lastdays = ( $user.ExpirationDate -$2Day).days
$EmailBody = $BodyTxt1, $user.name, $BodyTxt2, $lastdays, $BodyTxt3 + [System.Environment]::NewLine + $BodyTxt4  -join ' '
Send-MailMessage -To $user.EmailAddress -From $Sender -SmtpServer $smtpserver -Subject $Subject -Body $EmailBody -Attachments $Attachment -Encoding 'UTF8'}

if (($user.ExpirationDate -lt (get-date).adddays(2)) -and ($user.ExpirationDate -gt (get-date))) {
$lastdays = ( $user.ExpirationDate -$2Day).days
$EmailBody = $BodyTxt1, $user.name, $BodyTxt2, $lastdays, $BodyTxt3 + [System.Environment]::NewLine + $BodyTxt4  -join ' '
Send-MailMessage -To $user.EmailAddress -From $Sender -SmtpServer $smtpserver -Subject $Subject -Body $EmailBody -Attachments $Attachment -Encoding 'UTF8'}
}
