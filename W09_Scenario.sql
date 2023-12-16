
-- check size of database and exclude databases that have a log file OvER 100 MB
SELECT DB_NAME(database_id) AS database_name, 
    size/128.0 AS CurrentSizeMB
FROM sys.master_files
WHERE database_id > 5 
AND type_desc = 'LOG'
ORDER BY size DESC

--open docker terminal
	-- cd home
--open powershell
	-- cd c:\'Program Files'\'Microsoft SQL Server'\MSSQL15.MSSQLSERVER\MSSQL\Backup
	-- docker cp './School_FULL_11.12.22.bak' affectionate_raman:'/home/SchoolSchedulingExample.bak'
--verify in docker terminal
	-- ls to see all files in /home file in conatiner
--go to SQL
	--open the connection with port 49433
	--restore database
	--in files tab, select relocate files
	--click okay
	--refresh to verify restore database is there