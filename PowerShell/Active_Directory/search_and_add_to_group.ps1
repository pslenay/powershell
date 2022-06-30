Import-Module ActiveDirectory

$users = Get-ADUser -searchbase "OU=Всеволожский почтамт,OU=ОПС,OU=Users,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Filter {SamAccountName -like "ops1*"} -Properties *
ForEach ($user in $users) {
$san= $user.samaccountname
$ops= Get-ADUser -Identity $san -Properties *
Add-ADGroupMember "R78-Lync-Access" -Members $ops
}



#Add-ADGroupMember "R78-ops-187099" -Members (Get-ADUser -searchbase "OU=Тосненский почтамт,OU=ОПС,OU=Users,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Filter {SamAccountName -like "ops187*"} -Properties *)