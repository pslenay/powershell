msiexec /i "\\sccm\SCCM_Library\Soft\Office\1C\8.3.15.1830 x32\1CEnterprise 8.msi" /q TRANSFORMS=adminstallrestart.mst;1049.mst DESIGNERALLCLIENTS=1 THINCLIENT=1 WEBSERVEREXT=0 SERVER=0 CONFREPOSSERVER=0 CONVERTER77=0 SERVERCLIENT=0 LANGUAGES=RU
copy /y "\\sccm\SCCM_Library\Soft\Office\1C\nethasp.ini" "%ProgramFiles(x86)%\1cv8\conf"
copy /y "\\sccm\SCCM_Library\Soft\Office\1C\nethasp.ini" "%ProgramFiles%\1cv8\conf"