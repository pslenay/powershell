$SourceStoreScope = 'LocalMachine'
$SourceStorename = 'WebHosting'
 
$SourceStore = New-Object  -TypeName System.Security.Cryptography.X509Certificates.X509Store  -ArgumentList $SourceStorename, $SourceStoreScope
$SourceStore.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadOnly)
 
$cert = $SourceStore.Certificates | Where-Object { $_.subject -eq 'CN=autodiscover.sev-zap.ru' }
  

if(Get-ChildItem -Path Cert:\LocalMachine\My -Recurse | Where-Object {$_.thumbprint -eq $Cert.Thumbprint}) {
$SourceStore.Close()
$DestStore.Close()}
else {
$DestStoreScope = 'LocalMachine'
$DestStoreName = 'My'
 
$DestStore = New-Object  -TypeName System.Security.Cryptography.X509Certificates.X509Store  -ArgumentList $DestStoreName, $DestStoreScope
$DestStore.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
$DestStore.Add($cert)

$SourceStore.Close()
$DestStore.Close()

$Sender = "CertNotification@sev-zap.ru"
$Recipient = "Support@sev-zap.ru"
$Subject = 'Внимание! На сервере Exchange был обновлен сертификат Lets encrypt'
$BodyTxt1 = 'На SPB-EX2013 был автоматически обновлен и перезаписан сертификат Lets encrypt в хранилище сертификатов "Размещение веб-служб" локального компьютера.'
$BodyTxt2 = 'Скрипт добавил сертификат в папку "Личное" локального компьютера. Срок действия до (формат ММ:ДД:ГГ):'
$BodyTxt3 = 'Необходимо удалить старый сертификат Lets encrypt из папки "Личное" локального компьютера.'
$BodyTxt4 = 'Данное сообщение отправленно скриптом с сервера SPB-EX2013'
$smtpserver ="m.sev-zap.ru"

$EmailBody = $BodyTxt1 + [System.Environment]::NewLine + $BodyTxt2 + " " + ($cert).NotAfter + " " + [System.Environment]::NewLine + [System.Environment]::NewLine +$BodyTxt3 + [System.Environment]::NewLine + $BodyTxt4 -join ' '
Send-MailMessage -To $Recipient -From $Sender -SmtpServer $smtpserver -Subject $Subject -Body $EmailBody -Encoding 'UTF8'}