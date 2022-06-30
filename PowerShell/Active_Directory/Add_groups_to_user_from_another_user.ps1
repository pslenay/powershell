$CopyFromUser = Get-ADUser bojelko -prop MemberOf
$CopyToUser = Get-ADUser hrustaleva -prop MemberOf
$CopyFromUser.MemberOf | Where{$CopyToUser.MemberOf -notcontains $_} |  Add-ADGroupMember -Members $CopyToUser