-- full backup
BACKUP DATABASE [RecipesExample] TO  
DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\RecipesExample_11052022.BAK' 
WITH  COPY_ONLY, NOFORMAT, INIT,  NAME = N'RecipesExample-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO

-- database backups for all databases for previous week
SELECT 
CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, 
msdb.dbo.backupset.database_name, 
msdb.dbo.backupset.backup_start_date, 
msdb.dbo.backupset.backup_finish_date, 
msdb.dbo.backupmediafamily.physical_device_name, 
CASE msdb..backupset.type 
WHEN 'D' THEN 'Database' 
WHEN 'L' THEN 'Log' 
END AS backup_type, 
msdb.dbo.backupset.backup_size, 
--msdb.dbo.backupmediafamily.logical_device_name, 
--msdb.dbo.backupmediafamily.physical_device_name, 
msdb.dbo.backupset.name AS backupset_name
FROM msdb.dbo.backupmediafamily 
INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
WHERE (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) >= GETDATE() - 7) 
ORDER BY 
msdb.dbo.backupset.database_name, 
msdb.dbo.backupset.backup_finish_date

-- show maintenance plan
-- execute plan
-- sql sever agent jobs, view history, success