Import-Module ActiveDirectory
Add-PSSnapin Quest.ActiveRoles.ADManagement
$COMPAREDATE=GET-DATE
#Move and disable inactive computers
$NumberDays=180
get-qadcomputer  -searchroot "OU=WKS,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -SizeLimit 0 -IncludedProperties  LastLogonTimeStamp | ForEach-object {
if(($CompareDate-$_.LastLogonTimeStamp).Days -gt $NumberDays) {move-qadobject -identity $_.dn -newparentcontainer "OU=Disabled,OU=WKS,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" 
#| disable-qadobject
}}
#Set company
get-qaduser -searchroot "ou=users,ou=r78,ou=fgup,dc=main,dc=russianpost,dc=ru" -sizelimit 0| foreach {
set-qaduser -identity $_.samaccountname -Company "УФПС Санкт-Петербурга и Ленинградской области"}
#Add Users to R78-All-Users
get-qaduser -searchroot "ou=ауф,ou=users,ou=r78,ou=fgup,dc=main,dc=russianpost,dc=ru" -sizelimit 0| ForEach-Object -process {Add-ADGroupMember -Identity "R78-All-Users" -Members $_.dn}
get-qaduser -searchroot "ou=ОСП,ou=users,ou=r78,ou=fgup,dc=main,dc=russianpost,dc=ru" -sizelimit 0| ForEach-Object -process {Add-ADGroupMember -Identity "R78-All-Users" -Members $_.dn}
#Add Users on R78-Lync-Access
get-qaduser -searchroot "ou=ауф,ou=users,ou=r78,ou=fgup,dc=main,dc=russianpost,dc=ru" -sizelimit 0| ForEach-Object -process {Add-ADGroupMember -Identity "R78-Lync-access" -Members $_.dn}
#Add Users on R78-All-Auf
get-qaduser -searchroot "ou=ауф,ou=users,ou=r78,ou=fgup,dc=main,dc=russianpost,dc=ru" -sizelimit 0| ForEach-Object -process {Add-ADGroupMember -Identity "R78-All-Auf" -Members $_.dn}
#Add computers with Windows 10 on R78-WKS-Win10
get-qadcomputer -searchroot "OU=АУФ,OU=WKS,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" | ForEach-Object {
if($_.osname -match "Windows 10") { add-qadgroupmember -identity "R78-WKS-Win10" -member $_.dn}}
#Add Servers on R78-SCCM-Server-client-exclusion-GPOF
add-qadgroupmember -identity "R78-SCCM-Server-client-exclusion-GPOF" -member (get-qadcomputer -searchroot "OU=АУФ,OU=Servers,OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru")
#Remove groupmember if company notmatch Санкт-Петербург
Get-qaduser -MemberOf "R78-All-Users" -SizeLimit 0 | ForEach-Object -process {
If($_.company -notmatch "Санкт-Петербург") {remove-qadgroupmember -identity "R78-All-Users" -member $_.dn}}
Add-ADGroupMember “R78-All-Users” -Members (Get-ADGroupMember "A78-All-Users-АСЦ" )
Add-ADGroupMember “R78-MRC-All-Users” -Members (Get-ADGroupMember "A78-All-Users-АСЦ" )
Add-ADGroupMember “R78-CP-VPN-MRC_Severo-Zapad” -Members (Get-ADGroupMember "R51-CP-VPN-Murmansk" )
Add-ADGroupMember “R78-CP-VPN-MRC_Severo-Zapad” -Members (Get-ADGroupMember "R35-CP-VPN-Vologda" )
Add-ADGroupMember “R78-CP-VPN-MRC_Severo-Zapad” -Members (Get-ADGroupMember "R11-CP-VPN-Komi" )
Add-ADGroupMember “R78-CP-VPN-MRC_Severo-Zapad” -Members (Get-ADGroupMember "R60-CP-VPN-Pskov" )
Add-ADGroupMember “R78-CP-VPN-MRC_Severo-Zapad” -Members (Get-ADGroupMember "R29-CP-VPN-Arkhangelsk" )
# группы рассылок для начальников почтамтов и главных инженеров
Remove-ADGroupMember -Identity R78-CEO-PCH -Members (Get-ADUser -SearchBase "ou=users,ou=r78,ou=fgup,dc=main,dc=russianpost,dc=ru" -Filter {(title -notlike "Начальник*почтамт*" -or title -notlike "Начальник* МРП*") -or (enabled -eq "false") }) -confirm:$false
Add-ADGroupMember -Identity R78-CEO-PCH -Members (Get-ADUser -SearchBase "ou=users,ou=r78,ou=fgup,dc=main,dc=russianpost,dc=ru" -Filter {(title -like "Начальник*почтамт*" -or title -like "Начальник* МРП*") -and (enabled -eq "true") }) 
Remove-ADGroupMember -Identity R78-GEng-PCH -Members (Get-ADUser -SearchBase "ou=users,ou=r78,ou=fgup,dc=main,dc=russianpost,dc=ru" -Filter {(title -notlike "Главный инженер*") -or (enabled -eq "false") }) -confirm:$false
Add-ADGroupMember -Identity R78-GEng-PCH -Members (Get-ADUser -SearchBase "ou=users,ou=r78,ou=fgup,dc=main,dc=russianpost,dc=ru" -Filter {(title -like "Главный инженер*") -and (enabled -eq "true") })