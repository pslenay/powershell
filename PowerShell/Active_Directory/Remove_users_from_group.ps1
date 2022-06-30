Import-Module activedirectory
$Users = Get-ADUser -searchbase "OU=уволенные,OU=Users,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Properties * -Filter {enabled -eq 'false'}
ForEach ($user in $users) {$ADgroups = Get-ADPrincipalGroupMembership -Identity $user | where {$_.Name -ne "Domain Users"}
if ($ADgroups -eq $NULL) {
    write-host " Перемещение выполнено. Пользователь $user не имеет назначенных групп" -foregroundcolor red -backgroundcolor black}
else {
Remove-ADPrincipalGroupMembership -Identity $user -MemberOf $ADgroups -Confirm:$false
Write-Host -ForegroundColor Green "Список групп, из которых исключен пользователь $user"
$adgroups | ft name
$Adusers = $null
$adgroups = $null
}}