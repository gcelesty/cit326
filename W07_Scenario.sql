-- 1

-- If you put everyone in sysadmin, that means everyone has access to
-- everything in the network. Since everyone is admin, everyone has the
-- same viewing and editing capablitiy as the admin, which can jeperdize the
-- network's data. TYPICALLY ONLY the DBA is the only person with this role.
-- Only DBA should have this access because you are allowing anyone to have the
-- role and ability
-- Can do anything within SQL Server
-- Completely bypasses all security checks
-- Can do everything any other role can do and more
-- Most powerful role in SQL server. Limit its access to those who absolutely need it

-- 2

-- a
-- create ralph and add him to sysadmin
USE [master]
GO
CREATE LOGIN [ralph_dba_w07] WITH PASSWORD=N'password', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ralph_dba_w07]
GO

-- b
SELECT   name,type_desc,is_disabled, modify_date
FROM     master.sys.server_principals
WHERE    IS_SRVROLEMEMBER ('sysadmin',name) = 1
ORDER BY name;

-- c
select 'Name' = SP.name,
SP.is_disabled as [is_disabled],
SP.modify_date 'Last Modified'

from sys.server_role_members RM,
sys.server_principals SP
where RM.role_principal_id = suser_id
('Sysadmin')
and RM.member_principal_id = SP.principal_id;

-- create table
create table custom_audit.sysadmin_priviledges
	(
	Name varchar(150) NULL,
	is_disabled varchar(5) NULL,
	Last_Modified datetime
	);

-- insert data
insert into custom_audit.sysadmin_priviledges
select 'Name' = SP.name,
SP.is_disabled as [is_disabled],
SP.modify_date Last_Modified

from sys.server_role_members RM,
sys.server_principals SP
where RM.role_principal_id = suser_id
('Sysadmin')
and RM.member_principal_id = SP.principal_id;


-- create job


-- step 1 of job
-- if table exists drop it and create the new table
drop table if exists custom_audit.sysadmin_priviledges_$(ESCAPE_NONE(DATE))

create table custom_audit.sysadmin_priviledges_$(ESCAPE_NONE(DATE))
	(
	Name varchar(150) NULL,
	is_disabled varchar(5) NULL,
	Last_Modified datetime
	);

-- step 2 of job
-- insert data
insert into custom_audit.sysadmin_priviledges_$(ESCAPE_NONE(DATE))
select 'Name' = SP.name,
SP.is_disabled as [is_disabled],
SP.modify_date 'Last Modified'

from sys.server_role_members RM,
sys.server_principals SP
where RM.role_principal_id = suser_id
('Sysadmin')
and RM.member_principal_id = SP.principal_id;


-- login as ralph
-- add 4 new login users w/ sysadmin access