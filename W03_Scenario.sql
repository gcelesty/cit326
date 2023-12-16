--1
--a) SQL server is there for backward compatibiity ONLY, which is why we use Windows auth instead
--	Windows auth is more secure bc it makes use of the Active Directory Infrastructure (enables 
--	admins to manage permissions & access to network resources) to authenticate 
--	users using encrypted messages between servers
--b) authentication = verifies the identity of a user or service (windows or mixed mode)
--	authorization = determines their access rights, only authorized users are able to
--		execute statements or perform operations (grant, deny, revoke)
--c) instance, properties, security, server authentication to sql & windows
--d) They have access to confidential and important data. Info getting leaked or even
--	getting hacked is a possiblity since they can go through and view anything. Anyone has
--	access to select any database on the server and look through the information stored.


--2
-- bowling database
USE [BowlingLeagueExample]
GO
CREATE SCHEMA [people]
GO
CREATE SCHEMA [games]
GO

select 'ALTER SCHEMA people TRANSFER ' + name + ';' from sys.tables;
ALTER SCHEMA people TRANSFER Bowlers;
GO
ALTER SCHEMA people TRANSFER Teams;
GO

select 'ALTER SCHEMA games TRANSFER ' + name + ';' from sys.tables;
ALTER SCHEMA games TRANSFER Bowler_Scores;
GO
ALTER SCHEMA games TRANSFER Match_Games;
GO

--school database
USE [SchoolSchedulingExample]
GO
CREATE SCHEMA [faculty]
GO
CREATE SCHEMA [student]
GO

select 'ALTER SCHEMA faculty TRANSFER ' + name + ';' from sys.tables;
ALTER SCHEMA faculty TRANSFER Faculty;
GO
ALTER SCHEMA faculty TRANSFER Faculty_Categories;
GO
ALTER SCHEMA faculty TRANSFER Faculty_Classes;
GO
ALTER SCHEMA faculty TRANSFER Faculty_Subjects;
GO

select 'ALTER SCHEMA student TRANSFER ' + name + ';' from sys.tables;
ALTER SCHEMA student TRANSFER Student_Class_Status;
GO
ALTER SCHEMA student TRANSFER Student_Schedules;
GO
ALTER SCHEMA student TRANSFER Students;
GO


--security, new login
USE [master]
GO
CREATE LOGIN [iron_man] WITH PASSWORD=N'password' MUST_CHANGE, DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [BowlingLeagueExample]
GO
CREATE USER [iron_man] FOR LOGIN [iron_man]
GO
USE [BowlingLeagueExample]
GO
ALTER ROLE [db_datareader] ADD MEMBER [iron_man]
GO

--to map, find user login in database, securables, search for schemas, select the wanted schema,
--GRANT select to login, REMOVE datareader membership in my login




--3
USE [SchoolSchedulingExample]
GO
CREATE ROLE [super_hero]
GO

USE [SchoolSchedulingExample]
GO
GRANT SELECT ON [faculty].[Faculty] to [super_hero]
GRANT SELECT ON [faculty].[Faculty_Categories] to [super_hero]
GRANT SELECT ON [faculty].[Faculty_Classes] to [super_hero]
GRANT SELECT ON [faculty].[Faculty_Subjects] to [super_hero]
GO

--mapping new users to role of super hero
USE [master]
GO
CREATE LOGIN [scarlet_witch] WITH PASSWORD=N'password', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [SchoolSchedulingExample]
GO
CREATE USER [scarlet_witch] FOR LOGIN [scarlet_witch]
GO
USE [SchoolSchedulingExample]
GO
ALTER ROLE [super_hero] ADD MEMBER [scarlet_witch]
GO

USE [master]
GO
CREATE LOGIN [black_widow] WITH PASSWORD=N'password', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [SchoolSchedulingExample]
GO
CREATE USER [black_widow] FOR LOGIN [black_widow]
GO
USE [SchoolSchedulingExample]
GO
ALTER ROLE [super_hero] ADD MEMBER [black_widow]
GO


--4
USE SchoolSchedulingExample;
SELECT c.name column_name, t.name table_name, is_nullable
FROM sys.columns c
JOIN sys.tables t
ON c.object_id = t.object_id
WHERE is_nullable = 1;

use BowlingLeagueExample
select * from sys.schemas;

use SchoolSchedulingExample
select class_desc, type, permission_name
from sys.server_permissions
where class_desc = 'endpoint';



