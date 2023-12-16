
-- 1
-- reports, standard reports, backup and restore events (more in depth info)

select
	bs.database_name,
	bs.backup_start_date,
	bs.backup_finish_date,
	bs.server_name,
	bs.user_name,
	bs.type,
	bm.physical_device_name
from msdb.dbo.backupset AS bs
inner join msdb.dbo.backupmediafamily AS bm 
on bs.media_set_id = bm.media_set_id;

-- 2
BACKUP DATABASE [SalesOrdersExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\SalesOrdersExample.bak' WITH NOFORMAT, NOINIT,  NAME = N'SalesOrdersExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
	-- back up all databases & rerun query from #1

-- 3
BACKUP DATABASE [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExample.bak' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
	-- go to desktop shortcut, Backup, edit bowling to george_bowling_development.bak
	-- restore on "databases", restore database
	-- destination: database name "bowling_TEST"
	-- source: device, choose the george_bowling_development.bak
	-- change database name back to bowling_TEST
USE [master]
BACKUP LOG [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExample_LogBackup_2022-10-08_16-50-08.bak' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample_LogBackup_2022-10-08_16-50-08', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [bowling_TEST] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\george_bowling_development.bak' WITH  FILE = 1,  MOVE N'BowlingLeagueExample' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\bowling_TEST.mdf',  MOVE N'BowlingLeagueExample_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\bowling_TEST_log.ldf',  NOUNLOAD,  STATS = 5
GO
	-- all data in new test database
	--explain ss & process

-- 4
	--use powershell to delete data & restore it successfully