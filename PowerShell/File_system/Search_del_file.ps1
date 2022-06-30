$DeletedFile = "%Таблицы.xlsx%"
# Set-ExecutionPolicy RemoteSigned
Add-Type –Path ‘C:\Program Files (x86)\MySQL\MySQL Connector Net 6.9.8\Assemblies\v4.5\MySql.Data.dll'
$Connection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString='server=172.20.10.85;uid=ps;pwd=P@ssw0rd;database=audit;charset=utf8'}
$Connection.Open()
$MYSQLCommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$MYSQLDataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
$MYSQLDataSet = New-Object System.Data.DataSet
$MYSQLCommand.Connection=$Connection
$MYSQLCommand.CommandText="SELECT user_name,dt_time from track_del where file_name LIKE '$DeletedFile'"
$MYSQLDataAdapter.SelectCommand=$MYSQLCommand
$NumberOfDataSets=$MYSQLDataAdapter.Fill($MYSQLDataSet, "data")
foreach($DataSet in $MYSQLDataSet.tables[0])
{
write-host "User:" $DataSet.user_name "at:" $DataSet.dt_time
}
$Connection.Close()