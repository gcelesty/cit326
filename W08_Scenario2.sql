-- if someone recovered w/o your knowledge
exec sp_readerrorlog 0, 1, 'Recovery completed for';

--create table of all recoveries completed
create table database_recovery_table
	(
	message_date datetime,
	message_type varchar(20) NULL,
	message varchar(500) NULL
	);

-- insert recovery logs into table
insert into database_recovery_table
exec sp_readerrorlog 0, 1, 'Recovery completed for';


-- create the table log with date, if table exists then drop table with the same date
drop table if exists database_recovery_table_$(ESCAPE_NONE(DATE))

create table database_recovery_table_$(ESCAPE_NONE(DATE))
	(
	message_date datetime,
	message_type varchar(20) NULL,
	message varchar(500) NULL
	);