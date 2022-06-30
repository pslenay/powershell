 $psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add(
  "Connect to Exchange",
    {
        $s = New-PSSession -ConfigurationName Microsoft.Exchange `
        -ConnectionUri http://d01EXCAS01.main.russianpost.ru/PowerShell/ `
        -Authentication Kerberos
        Import-PSSession $s
    },
  "Control+Alt+Z"
)  
