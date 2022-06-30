Import-Module ActiveDirectory
Get-ADGroupMember -Identity "isvs_users" |Set-ADUser -PasswordNeverExpires:$True
# Get-ADGroupMember -Identity "SSLVPN-home-thick" |Set-ADUser -PasswordNeverExpires:$True