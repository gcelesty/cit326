
--I watched the video and ran the steps! Celeste George

-- SQL Server Configuration Manager
--C:\Windows\SysWOW64\SQLServerManager15.msc

exec sp_readerrorlog 0, 1, 'Login failed';

--step 1

create table custom_audit.failed_logins
	(
	message_date datetime,
	message_type varchar(20) NULL,
	message varchar(150) NULL
	);

-- step 2

insert into custom_audit.failed_logins
exec sp_readerrorlog 0, 1, 'Login failed';

-- step 3

drop table if exists custom_audit.failed_logins_$(ESCAPE_NONE(DATE))

create table custom_audit.failed_logins_$(ESCAPE_NONE(DATE))
	(
	message_date datetime,
	message_type varchar(20) NULL,
	message varchar (150) NULL
	);

-- step 4

insert into custom_audit.failed_logins_$(ESCAPE_NONE(DATE))
exec sp_readerrorlog 0, 1, 'Login failed';

-- step 5


--I watched the video and ran the steps! Celeste George

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [message_date]
      ,[message_type]
      ,[message]
  FROM [msdb].[custom_audit].[failed_logins_20221026]