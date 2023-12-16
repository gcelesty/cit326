select * from project;

insert into project values ('p4', 'Rexburg Rapids', 150000.00);
select getdate();
---2022-10-19 22:37:01.593

insert into project values ('p5', 'Barnum''s Circus', 145000.00);
select getdate();
---2022-10-19 22:41:20.300

delete from project;
--2022-10-19 22:54:13.517

BACKUP LOG [sample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\sampletlog3.trn' WITH NOFORMAT, NOINIT,  NAME = N'sample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

USE [master]
ALTER DATABASE [sample] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [sample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\sample_LogBackup_2022-10-19_22-56-56.bak' WITH NOFORMAT, NOINIT,  NAME = N'sample_LogBackup_2022-10-19_22-56-56', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [sample] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\fullsample.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE LOG [sample] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\sampletlog.trn' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [sample] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\sampletlog.trn' WITH  FILE = 2,  NOUNLOAD,  STATS = 5,  STOPAT = N'2022-10-19T22:41:20'
ALTER DATABASE [sample] SET MULTI_USER

GO


