Import-Module activedirectory
#New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://R00excashub02.main.russianpost.ru -Authentication Kerberos
$OldDate=(Get-Date).AddDays(-7)
Get-ADUser -SearchBase "OU=2016 год,OU=уволенные,OU=Users,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Properties * -Filter {(enabled -eq 'false') -and (LastLogonDate -lt $OldDate)} | ForEach-Object -process {
$ADgroups = Get-ADPrincipalGroupMembership -Identity $_.samaccountname | where {$_.Name -ne "Domain Users"}
if ($ADgroups -eq $NULL) {
    write-host " Перемещение выполнено. Пользователь $_.samaccountname не имеет назначенных групп" -foregroundcolor red -backgroundcolor black}
else {
Remove-ADPrincipalGroupMembership -Identity $_.samaccountname -MemberOf $ADgroups -Confirm:$false
Write-Host -ForegroundColor Green "Список групп, из которых исключен пользователь $_.samaccountname"
$adgroups | ft name
$Adusers = $null
$adgroups = $null
}
Set-Mailbox -Identity $_.samaccountname -HiddenFromAddressListsEnabled $true
Set-Mailbox -Identity $_.samaccountname -RetentionPolicy "Удаление старше 30 дней" 
}
