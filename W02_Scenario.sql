--1
USE WideWorldImporters;
SELECT name, create_date, modify_date, type
FROM sys.tables
WHERE type = 'U';

USE BowlingLeagueExample;
SELECT name, create_date, modify_date, type
FROM sys.tables
WHERE type = 'U';

USE SchoolSchedulingExample;
SELECT name, create_date, modify_date, type
FROM sys.tables
WHERE type = 'U';



--2
USE WideWorldImporters;
SELECT c.name as column_name, c.max_length, t.name as table_name
FROM sys.columns c
INNER JOIN sys.tables t
ON c.object_id = t.object_id
WHERE c.name LIKE '%name%';

USE BowlingLeagueExample;
SELECT c.name as column_name, c.max_length, t.name as table_name
FROM sys.columns c
INNER JOIN sys.tables t
ON c.object_id = t.object_id
WHERE c.name LIKE '%name%';

USE SchoolSchedulingExample;
SELECT c.name as column_name, c.max_length, t.name as table_name
FROM sys.columns c
INNER JOIN sys.tables t
ON c.object_id = t.object_id
WHERE c.name LIKE '%name%';





--3 pt 1
USE WideWorldImporters;
SELECT name, physical_name, size
FROM sys.database_files
WHERE size > 1024;

USE BowlingLeagueExample;
SELECT name, physical_name, size
FROM sys.database_files
WHERE size > 1024;

USE SchoolSchedulingExample;
SELECT name, physical_name, size
FROM sys.database_files
WHERE size > 1024;




--3 pt 2
USE WideWorldImporters;
SELECT ((sum(size)) * 8) / 1024
FROM sys.database_files;

USE BowlingLeagueExample;
SELECT ((sum(size)) * 8) / 1024
FROM sys.database_files;

USE SchoolSchedulingExample;
SELECT ((sum(size)) * 8) / 1024
FROM sys.database_files;


--4

--ansi_padded: Controls the way the column stores values shorter than the 
--	defined size of the column, and the way the column stores values that have 
--	trailing blanks in char, varchar, binary, and varbinary data.
USE WideWorldImporters;
SELECT c.name column_name, t.name table_name, is_ansi_padded
FROM sys.columns c
JOIN sys.tables t
ON c.object_id = t.object_id
WHERE is_ansi_padded = 1;

-- 1 means is nullable, 0 is not nullable
USE RecipesExample;
SELECT c.name column_name, t.name table_name, is_nullable
FROM sys.columns c
JOIN sys.tables t
ON c.object_id = t.object_id
WHERE is_nullable = 1;