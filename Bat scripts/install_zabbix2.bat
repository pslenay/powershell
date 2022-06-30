SET INSTALLFOLDER=C:\Program Files\Zabbix Agent 2
SET HOSTNAME=%COMPUTERNAME%.%USERDNSDOMAIN%

msiexec /package "C:\Users\mamin\Downloads\zabbix_agent2.msi" /quiet /norestart SERVER=spb-zabbix.sz-spb.sev-zap.ru SERVERACTIVE=spb-zabbix.sz-spb.sev-zap.ru HOSTNAME="%COMPUTERNAME%.%USERDNSDOMAIN%" INSTALLFOLDER="%INSTALLFOLDER%"