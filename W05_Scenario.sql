-- 1
alter table people.bowlers
add Bowler_Email varchar(50) null;

update people.Bowlers
set Bowler_Email = concat(BowlerFirstName,BowlerLastName,'@gmail.com');

-- 2

-- a
USE [master]
GO
CREATE LOGIN [bob_the_scorekeeper] WITH PASSWORD=N'password', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [BowlingLeagueExample]
GO
CREATE USER [bob_the_scorekeeper] FOR LOGIN [bob_the_scorekeeper]
GO

-- b
create view people.limited_view
as
select Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Bowlers.BowlerMiddleInit, Bowlers.BowlerCity, Bowlers.BowlerState, Bowlers.BowlerZip, Bowlers.TeamID
from people.Bowlers;

-- adding bob
USE [BowlingLeagueExample]
GO
ALTER ROLE [db_datareader] DROP MEMBER [bob_the_scorekeeper]
GO
use [BowlingLeagueExample]
GO
GRANT SELECT ON SCHEMA::[people] TO [bob_the_scorekeeper]
GO


-- 3

-- a 
-- created carol_the_programmer the same as bob_the_scorekeeper
USE [master]
GO
CREATE LOGIN [carol_the_programmer] WITH PASSWORD=N'password', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
use [master];
GO
USE [BowlingLeagueExample]
GO
CREATE USER [carol_the_programmer] FOR LOGIN [carol_the_programmer]
GO
-- opened encrypt wizard and check address, phone #, email

-- b
use [BowlingLeagueExample]
GO
GRANT INSERT ON SCHEMA::[people] TO [carol_the_programmer]
GO
use [BowlingLeagueExample]
GO
GRANT SELECT ON SCHEMA::[people] TO [carol_the_programmer]
GO


-- 4