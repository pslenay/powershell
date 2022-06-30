﻿Import-Module ActiveDirectory
Get-ADComputer -searchbase "OU=R78,OU=FGUP,DC=main,DC=russianpost,DC=ru" -Filter {Description -like "*Anna.Moskaleva*"} -Properties * | ft Description,Name,EmailAddress,Department,StreetAddress,Office,OfficePhone -hidetableheaders