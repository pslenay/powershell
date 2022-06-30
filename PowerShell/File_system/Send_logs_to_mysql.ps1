Add-Type –Path ‘C:\Program Files (x86)\MySQL\MySQL Connector Net 6.9.8\Assemblies\v4.5\MySql.Data.dll'
$Connection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString='server=172.20.10.85;uid=ps;pwd=P@ssw0rd;database=audit;charset=utf8'}
$Connection.Open()
$sql = New-Object MySql.Data.MySqlClient.MySqlCommand
$sql.Connection = $Connection
$today = get-date -DisplayHint date -UFormat %Y-%m-%d
Get-WinEvent -FilterHashTable @{LogName="Security";starttime="$today";id=4663} | Foreach {
$event = [xml]$_.ToXml()
if($event)
{
$Time = Get-Date $_.TimeCreated -UFormat "%Y-%m-%d %H:%M:%S"
$File = $event.Event.EventData.Data[6]."#text"

$File = $File.Replace(‘\’,’|’)
$User = $event.Event.EventData.Data[1]."#text"
$Computer = $event.Event.System.computer
$sql.CommandText = "INSERT INTO track_del  (server,file_name,dt_time,user_name ) VALUES ('$Computer','$File','$Time','$User')"
$sql.ExecuteNonQuery()
}
}
$Reader.Close()
$Connection.Close()