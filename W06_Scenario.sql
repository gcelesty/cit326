-- 1

-- Full weekly + differential daily (good)
-- Full weekly + incremental daily (good)

-- Differential: only copy data changed since last full backup
-- ex. If full backup done on Sunday, a differential backup on Monday backs
--		up all the files changed or added since Sunday. A Tuesday differential backs up
--		all the change files since Sunday's full back up, including files change on Monday

-- Incremental: copies data that has been changed since the last backup of any kind
-- ex. If full backup done on Sunday, Monday's incremental backup would only copy anything changed since Sunday's
--		full backup. But Tuesday's incremental will only backup files changed since Monday's incremental

-- Full backup

BACKUP DATABASE [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\w06bowlingfull.bak' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


use BowlingLeagueExample;
select * from people.teams;

insert into people.teams values ('11', 'Longhorns', '77');
select getdate();
-- 2022-10-23 16:55:23.433

--diff backup


insert into people.teams values ('12', 'Cowboys', '33');
select getdate();
-- 2022-10-23 16:58:04.823

--diff backup

-- restore since 22 was incorrect
-- restore w/ time above, diff back up, disk, overwrite, close existing connections


-- access backup if a day or two is lost
-- save on a removeable hard drive and detach at end-of-date so it does not get shorted with computers
-- double safe: get a cloud account with any service online and save backups there so you have a another
--		reliable option to count on if the organization lost its computers

--diff backup at end

-- 2

select name, recovery_model_desc, recovery_model
from sys.databases;

-- Full backup + transaction
-- This would be the best option since He does not have a data storage limit since he wants optimal security
-- and safety. It would be best to do one Full back up at the end of the day. During the day however so you
-- don't loss any progress I would recommend a transaction log just to be able to undo to a point-in-time
-- versus having to restart with none of that day's work saved.

-- change status to full from simple
alter database WideWorldImporters set recovery full;

-- FULL backup
BACKUP DATABASE [WideWorldImporters] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\w06wideFull' WITH NOFORMAT, NOINIT,  NAME = N'WideWorldImporters-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--TRN backup
BACKUP LOG [WideWorldImporters] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\w06wide.trn' WITH NOFORMAT, NOINIT,  NAME = N'WideWorldImporters-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

use WideWorldImporters;
select * from purchasing.PurchaseOrders;

insert into purchasing.PurchaseOrders values ('2075', '6', '2013-01-01', '2', '2', '2013-01-15', 'cit361', '1', null, null, '6', '2013-01-02 07:00:00.0000000');
select getdate();
-- 2022-10-23 17:03:14.493

-- trn back up

insert into purchasing.PurchaseOrders values ('2076', '6', '2013-01-01', '2', '2', '2013-01-15', 'cit361', '1', null, null, '6', '2013-01-02 07:00:00.0000000');
select getdate();
-- 2022-10-23 17:04:10.417

--trn backup
-- restore w/ time above, trn back up, disk, overwrite, close existing connections

use WideWorldImporters;
select * from Warehouse.StockItemTransactions;

delete from Warehouse.StockItemTransactions;
select getdate();
-- 2022-10-23 17:06:45.607

-- restore w/ time above, trn back up, disk, overwrite, close existing connections

