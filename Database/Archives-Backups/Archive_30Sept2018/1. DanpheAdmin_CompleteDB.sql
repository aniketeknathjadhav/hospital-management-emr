---FIND and replace: DanpheAdmin with your required DatabaseName acc. to Branch---

USE [master]
GO
if db_id('DanpheAdmin') is not null
BEGIN
  ALTER DATABASE [DanpheAdmin] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  Drop Database [DanpheAdmin]
END
GO
CREATE DATABASE [DanpheAdmin]
GO

USE [DanpheAdmin]
GO

/****** Object:  Table [dbo].[Danphe_SQLAuditLog]    Script Date: 5/11/2018 8:20:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Danphe_SQLAuditLog](
	[ServerName] [nvarchar](128) NULL,
	[LoginName] [sysname] NOT NULL,
	[LoginType] [varchar](13) NOT NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[SelectAccess] [int] NULL,
	[InsertAccess] [int] NULL,
	[UpdateAccess] [int] NULL,
	[DeleteAccess] [int] NULL,
	[DBOAccess] [int] NULL,
	[SysadminAccess] [int] NULL,
	[AuditDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysAdmin_DBLog]    Script Date: 5/11/2018 8:20:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysAdmin_DBLog](
	[DBLogId] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](50) NULL,
	[FolderPath] [varchar](100) NULL,
	[DatabaseName] [varchar](50) NULL,
	[DatabaseVersion] [varchar](10) NULL,
	[IsDBRestorable] [bit] NULL,
	[Action] [varchar](20) NULL,
	[ActionType] [varchar](10) NULL,
	[Status] [varchar](10) NULL,
	[MessageDetail] [varchar](max) NULL,
	[Remarks] [varchar](300) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[DeleteOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_SysAdmin_DBLog_DBLogId] PRIMARY KEY CLUSTERED 
(
	[DBLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysAdmin_Parameters]    Script Date: 5/11/2018 8:20:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysAdmin_Parameters](
	[ParameterId] [int] IDENTITY(1,1) NOT NULL,
	[ParameterGroupName] [varchar](100) NULL,
	[ParameterName] [varchar](200) NULL,
	[ParameterValue] [varchar](1000) NULL,
	[ValueDataType] [varchar](50) NULL,
	[Description] [varchar](1000) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ParameterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[SysAdmin_Parameters] ON 
GO
INSERT [dbo].[SysAdmin_Parameters] ([ParameterId], [ParameterGroupName], [ParameterName], [ParameterValue], [ValueDataType], [Description], [CreatedOn]) VALUES (1, N'Admin', N'DbBackupFolderPath', N'C:\DanpheHealthInc_PvtLtd_Files\Data\DbBackup\', N'string', N'this is where the database will be backed up daily', CAST(N'2017-09-13T23:14:46.010' AS DateTime))
GO
INSERT [dbo].[SysAdmin_Parameters] ([ParameterId], [ParameterGroupName], [ParameterName], [ParameterValue], [ValueDataType], [Description], [CreatedOn]) VALUES (2, N'Admin', N'DbBackupDays', N'5', N'string', N'This for tell days to keep database backup files into local directory', CAST(N'2017-09-13T23:14:46.067' AS DateTime))
GO
INSERT [dbo].[SysAdmin_Parameters] ([ParameterId], [ParameterGroupName], [ParameterName], [ParameterValue], [ValueDataType], [Description], [CreatedOn]) VALUES (3, N'Admin', N'DatabaseCurrentVersion', N'2.0', N'string', N'This for store database current version information storing', CAST(N'2017-09-13T23:14:46.083' AS DateTime))
GO
INSERT [dbo].[SysAdmin_Parameters] ([ParameterId], [ParameterGroupName], [ParameterName], [ParameterValue], [ValueDataType], [Description], [CreatedOn]) VALUES (4, N'Admin', N'DaillyDBBackupLimit', N'5', N'string', N'This core value set for dailly how many times user can take backup of database', CAST(N'2017-09-13T23:14:46.097' AS DateTime))
GO
INSERT [dbo].[SysAdmin_Parameters] ([ParameterId], [ParameterGroupName], [ParameterName], [ParameterValue], [ValueDataType], [Description], [CreatedOn]) VALUES (5, N'Admin', N'LiveDBName', N'Danphe_EMR_LIVE', N'string', N'This for store current Live DB Name for taking backup not AdminDB', CAST(N'2017-09-13T23:14:46.107' AS DateTime))
GO
INSERT [dbo].[SysAdmin_Parameters] ([ParameterId], [ParameterGroupName], [ParameterName], [ParameterValue], [ValueDataType], [Description], [CreatedOn]) VALUES (6, N'Common', N'SQLAuditFilePath', N'C:\\DanpheHealthInc_PvtLtd_Files\R2V1_Dev\Data\DbAudit\', N'string', N'Location path for save sql audit file', CAST(N'2017-12-15T17:49:43.280' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[SysAdmin_Parameters] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Core_CFG_Parameters]    Script Date: 5/11/2018 8:20:32 PM ******/
ALTER TABLE [dbo].[SysAdmin_Parameters] ADD  CONSTRAINT [UK_Core_CFG_Parameters] UNIQUE NONCLUSTERED 
(
	[ParameterGroupName] ASC,
	[ParameterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Danphe_SQLAuditLog] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
/****** Object:  StoredProcedure [dbo].[SP_Danphe_SQLAudit]    Script Date: 5/11/2018 8:20:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Danphe_SQLAudit]
	@FromDate DateTime=null,
	@ToDate DateTime=null,
	@LogType varchar(100)=null
	
AS
/*
FileName: [SP_Danphe_SQLAudit]
CreatedBy/date: Nagesh/Sagar/2017-10-04
Description: to get the Invoice Details as per IRD requirements  or SQL DB Audit
--This file contains all info about SQLAudit creation and save database activity log and use as per requirement
--Using this file script we creating separate database i.e. SQLAudit
--Sql Audit script create files in specified folder on your local machine(server)
--This file is important for see all activity
--We taking path from Core_parameter table
---------create a database called SQLAudit and a table in it called AuditDBLogin.--------
--Need to create temporary table for this script run

REMARKS:
--Below is a action list for see log activity
-------Parameters List
--CREATE
--ALTER
--DROP
--SELECT
--INSERT
--UPDATE
--DELETE
--TABLE
--VIEW
--TRIGGER
--STORED_PROCEDURE
--SCHEMA
--LOGIN_INFO
--SERVER_ACTIVITY

---------------------------------------------------------------------------
S.No.    UpdatedBy/Date                             Remarks
--------------------------------------------------------------------------------
1       Nagesh/Sagar/2017-10-04	                    created the script
2.      Sud/2017-11-20               Modified       Altered To Match the TimeZone for event_time
                                                    parameterized livedbname instead of CurrentDbName.
---------------------------------------------------------------------------------
*/


BEGIN
	Declare @SqlAuditFilePath nvarchar(max),@sqlQuery varchar(max)=null
    
	Set @SqlAuditFilePath =(select ParameterValue from SysAdmin_Parameters where ParameterName='SQLAuditFilePath');
	Set @SqlAuditFilePath=@SqlAuditFilePath+'*.sqlaudit';
	SET @ToDate = DATEADD(DAY, 1, @ToDate); -- adding 1 day since '2017-01-01' is considered as '2017-01-01 00:00:00', which means current day is not started yet. 
	--SET @ToDate ='2017/10/30'

	declare @LiveDbName varchar(100)
	set @LiveDbName=(select top 1 ParameterValue from SysAdmin_Parameters 
	                where ParameterGroupName='Admin' and ParameterName='LiveDBName')

	--Set @LogType='STORED_PROCEDURE';
	select @sqlQuery=
	(CASE @LogType
	WHEN 'CREATE'  THEN  N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,''CREATE'' AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	DEFAULT, DEFAULT) where action_id=''CR'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105)'

	WHEN 'ALTER'  THEN  N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,''ALTER'' AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	DEFAULT, DEFAULT) where action_id=''AL'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105)' 

	WHEN 'DROP'  THEN  N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,''DROP'' AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	DEFAULT, DEFAULT) where action_id=''DR'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105)' 

	WHEN 'SELECT'  THEN  N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,''SELECT'' AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	DEFAULT, DEFAULT) where action_id=''SL'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105)' 

	WHEN 'INSERT'  THEN   N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,''INSERT'' AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	DEFAULT, DEFAULT) where action_id=''IN'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105)' 

	WHEN 'UPDATE'  THEN   N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,''UPDATE'' AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	DEFAULT, DEFAULT) where action_id=''UP'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105)' 

	WHEN 'DELETE'  THEN   N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,''DELETE'' AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	DEFAULT, DEFAULT) where action_id=''DL'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105)'  

	WHEN 'TABLE'  THEN  N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,
	(SELECT CASE action_id
	WHEN ''AL'' THEN ''ALTER''
	WHEN ''CR'' THEN ''CREATE''
	WHEN ''SL'' THEN ''SELECT''
	WHEN ''DR'' THEN ''DROP''
	WHEN ''IN'' THEN ''INSERT''
	WHEN ''UP'' THEN ''UPDATE''
	WHEN  ''DL'' THEN ''DELETE''
	ELSE action_id
	END )AS action_id
	,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	 DEFAULT, DEFAULT) where  schema_name=''dbo'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105) and 
	 (action_id=''CR''or action_id=''AL''or action_id=''DR'' or action_id=''SL''
	 or action_id=''IN''or action_id=''UP''or action_id=''DL'')'

	 WHEN 'VIEW'  THEN  N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,(SELECT CASE action_id
	WHEN ''AL'' THEN ''ALTER''
	WHEN ''CR'' THEN ''CREATE''
	WHEN ''SL'' THEN ''SELECT''
	WHEN ''DR'' THEN ''DROP''
	WHEN ''IN'' THEN ''INSERT''
	WHEN ''UP'' THEN ''UPDATE''
	WHEN  ''DL'' THEN ''DELETE''
	ELSE action_id
	END )AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	 DEFAULT, DEFAULT) where  class_type=''V''and schema_name=''dbo'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105) and (action_id=''CR''or action_id=''AL''or action_id=''DR'' or action_id=''SL''
	 or action_id=''IN''or action_id=''UP''or action_id=''DL'')' 

	WHEN 'TRIGGER'  THEN  N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,(SELECT CASE action_id
	WHEN ''AL'' THEN ''ALTER''
	WHEN ''CR'' THEN ''CREATE''
	WHEN ''SL'' THEN ''SELECT''
	WHEN ''DR'' THEN ''DROP''
	WHEN ''IN'' THEN ''INSERT''
	WHEN ''UP'' THEN ''UPDATE''
	WHEN  ''DL'' THEN ''DELETE''
	ELSE action_id
	END )AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	 DEFAULT, DEFAULT) where  class_type=''TR'' and database_name='''+@LiveDbName+''' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105) and (action_id=''CR''or action_id=''AL''or action_id=''DR'' or action_id=''SL''
	 or action_id=''IN''or action_id=''UP''or action_id=''DL'')'
 
	WHEN 'STORED_PROCEDURE'  THEN  N'
	SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,(SELECT CASE action_id
	WHEN ''AL'' THEN ''ALTER''
	WHEN ''CR'' THEN ''CREATE''
	WHEN ''DR'' THEN ''DROP''
	WHEN ''EX'' THEN ''EXECUTE''
	ELSE action_id
	END )AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
	 DEFAULT, DEFAULT) where   database_name='''+@LiveDbName+''' and class_type=''P'' and DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and convert(date,'''+convert(varchar(20),@TODATE,105)+''',105) and (action_id=''CR''or action_id=''AL''or action_id=''DR'' or action_id=''EX'')'

	WHEN 'LOGIN_INFO'  THEN  N'
	 SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,(SELECT CASE action_id
	WHEN ''LGIS'' THEN ''LOGIN SUCCESSFULLY''
	WHEN ''LGIF'' THEN ''LOGIN FAILED''
	ELSE action_id
	END )AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id
	 FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',DEFAULT, DEFAULT) where DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and
	 convert(date,'''+convert(varchar(20),@TODATE,105)+''',105) and (action_id=''LGIS''or action_id=''LGIF'')'

	WHEN 'SERVER_ACTIVITY'  THEN  N'
	 SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,(SELECT CASE action_id
	WHEN ''SVSR'' THEN ''SERVER STARTED''
	WHEN ''SVSD'' THEN ''SERVER SHUTDOWN''
	WHEN ''SVCN'' THEN ''SERVER CONTINUE''
	WHEN ''SVPD'' THEN ''SERVER PAUSED''

	ELSE action_id
	END )AS action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id
	 FROM  sys.fn_get_audit_file('''+@SqlAuditFilePath+''',DEFAULT, DEFAULT) where DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) BETWEEN convert(date,'''+convert(varchar(20),@FROMDATE,105)+''',105) and
	  convert(date,'''+convert(varchar(20),@TODATE,105)+''',105) and (action_id=''SVSR''or action_id=''SVSD''or action_id=''SVCN'' or action_id=''SVPD'')' 
	else
	  N'Select DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), event_time) ''event_time'',server_instance_name,action_id,statement,schema_name,server_principal_name,database_name,object_name,session_id from sys.fn_get_audit_file('''+@SqlAuditFilePath+''',
								 DEFAULT, DEFAULT)'
	END  
	)

EXECUTE  (@sqlQuery)
END-----end of SP: SP_Danphe_SQLAudit -- 
GO
/****** Object:  StoredProcedure [dbo].[SP_SysADM_Backup_Database]    Script Date: 5/11/2018 8:20:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--stored procedure for Backup database
Create PROCEDURE [dbo].[SP_SysADM_Backup_Database] 
(
@CreatedBy int=null,
@ActionType varchar(10)
)
AS
/*
FileName: [SP_SysADM_DatabaseBackup]
CreatedBy/date: Sud/2017Aug17
Description: Backup database to local directory
Remarks:    
Change History
-------------------------------------------------------
S.No.    UpdatedBy/Date                        Remarks
-------------------------------------------------------
1       Nagesh/2017-Aug-19	                   Modified script for Insert log into DatabaseBackupLog table
2		Nagesh/2017-Aug-22						Modified script
--------------------------------------------------------
*/

Begin     	
	Declare @dbBackupResult int=0,@BackupFullPath varchar(256),@FolderPath varchar(256), @FileName varchar(100), 
	 @TimeStamp Varchar(14),@DatabaseName varchar(100),@DatabaseVersion varchar(10), @ExecutionStatus varchar(10)
	
	Begin TRY				
		set @DatabaseName=(SELECT TOP 1 ParameterValue FROM SysAdmin_Parameters
						WHERE ParameterGroupName='Admin' AND ParameterName='LiveDBName')		
		set @FolderPath =(SELECT TOP 1 ParameterValue FROM SysAdmin_Parameters
						WHERE ParameterGroupName='Admin' AND ParameterName='DbBackupFolderPath')
		set @DatabaseVersion=(select top 1 ParameterValue from SysAdmin_Parameters
					WHERE ParameterGroupName='Admin' AND ParameterName='DatabaseCurrentVersion')
		SET @TimeStamp=CONVERT(VARCHAR(20),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(20),GETDATE(),108),':','')
		
		set @FileName = @TimeStamp+'_'+@DatabaseName+'.BAK'
		set @BackupFullPath = @FolderPath+ @FileName		
		BACKUP DATABASE @DatabaseName TO DISK = @BackupFullPath
		Set @dbBackupResult=1;
		set @ExecutionStatus='success'
	End Try
	Begin Catch
	 set @dbBackupResult=0;
	 Declare @errorMsg varchar(max)
	 set @errorMsg=ERROR_MESSAGE()
	 --Insert log entry for failed backup
	 	Exec     [SP_SysADM_Insert_DBLog] 
			 @FileName=@FileName
			,@FolderPath=@FolderPath
			,@DatabaseName=@DatabaseName
			,@DatabaseVersion=@DatabaseVersion
			,@IsDBRestorable=0
			,@Action='backup'  
			,@ActionType=@ActionType
			,@Status='failed'
			,@MessageDetail=@errorMsg
			,@CreatedBy=@CreatedBy			
			,@IsActive=0

    set @ExecutionStatus='failed'
	End Catch
	if @dbBackupResult=1
	 BEGIN
			--Second Transaction of Insert Log entry
	--Execute stored procedure of log
			Exec     [SP_SysADM_Insert_DBLog] 
					 @FileName=@FileName
					,@FolderPath=@FolderPath
					,@DatabaseName=@DatabaseName
					,@DatabaseVersion=@DatabaseVersion
					,@IsDBRestorable=1
					,@Action='backup'  
					,@ActionType=@ActionType
					,@Status='success'
					,@MessageDetail='Database backup successfully taken.'		
					,@CreatedBy=@CreatedBy			
					,@IsActive=1

		--update IsRestorable status =1 for this current db
		UPDATE SysAdmin_DBLog
		SET IsDBRestorable= 
			(CASE WHEN DBLogId=(select DBLogId from SysAdmin_DBLog where [FileName]=@FileName and [Action]='backup' )  THEN 1
				  ELSE 0
			 END)
	End---end if
 	
 --return the execution status--it's required to select the value to be used for ExecuteScalar command
 select @ExecutionStatus as 'status'
End


GO
/****** Object:  StoredProcedure [dbo].[SP_SysADM_Delete_DatabaseBackup]    Script Date: 5/11/2018 8:20:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--stored procedure for delete old database backup
Create PROCEDURE [dbo].[SP_SysADM_Delete_DatabaseBackup] 
AS
/*
FileName: [SP_SysADM_Delete_DatabaseBackup]
CreatedBy/date: NageshBB/2017Aug19
Description: To delete old database backup files from local directory and Insert Log into DatabaseBackup table
Remarks:    
Change History
-------------------------------------------------------
S.No.    UpdatedBy/Date                        Remarks
-------------------------------------------------------
1       Nagesh/2017-Aug-19	                   created the script
2		Nagesh/2017-Aug-22						Modified Script 
--------------------------------------------------------
*/
Begin
Declare @dbBackupDeleteResult int
	Begin TRY
		Declare @Days int=Convert(int,( (SELECT TOP 1 ParameterValue FROM SysAdmin_Parameters
		WHERE ParameterGroupName='Admin' AND ParameterName='DbBackupDays')))

		Declare @DeletedDate  smalldatetime=(GETDATE()-@Days) 
		,@Path Nvarchar(100)=(SELECT TOP 1 ParameterValue FROM SysAdmin_Parameters WHERE ParameterGroupName='Admin' AND ParameterName='DbBackupFolderPath')
		,@FileExtension Nvarchar(10)=N'BAK' --file extension

		Declare @xml XML, @ConvertedDateFormat Nvarchar(50)
		Set @xml =(select @DeletedDate as DeleteDate FOR XML Path(''))
		Select @ConvertedDateFormat = t.c.value('.','varchar(100)') from @xml.nodes('/DeleteDate') t(c)

		Execute master.dbo.xp_delete_file
		0,@Path,@FileExtension,@ConvertedDateFormat
		set @dbBackupDeleteResult=1
	End Try
	Begin Catch
	 set @dbBackupDeleteResult=0;
	End Catch
	if @dbBackupDeleteResult=1
	 Begin		
		Update [dbo].[SysAdmin_DBLog]
		Set DeleteOn=getdate(), IsActive=0 where IsActive=1 and convert(smalldatetime,CreatedOn) <convert(smalldatetime,getdate()-@Days)
	End
End

GO
/****** Object:  StoredProcedure [dbo].[SP_SysADM_Insert_DBLog]    Script Date: 5/11/2018 8:20:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--stored procedure for insert or maintain log of database restore, backup, delete and also if fails against any action
Create PROCEDURE [dbo].[SP_SysADM_Insert_DBLog] 
(
@FileName varchar(50)=null,
@FolderPath varchar(100)=null,
@DatabaseName varchar(50)=null,
@DatabaseVersion varchar(10)=null,
@IsDBRestorable bit=null,
@Action varchar(20)=null, 
@ActionType varchar(10)=null, 
@Status varchar(10)=null,
@MessageDetail varchar(max)=null, 
@Remarks varchar(300)=null,
@CreatedBy int=null,
@IsActive bit=null
)
AS
/*
FileName: [SP_SysADM_Insert_DBLog]
CreatedBy/date: Nagesh/28-Aug-2017
Description:stored procedure for insert or maintain log of database restore, backup, delete and also if fails against any action
Remarks:    
Change History
-------------------------------------------------------
S.No.    UpdatedBy/Date                        Remarks
-------------------------------------------------------
1       Nagesh/2017-Aug-28	                   Created Stored procedure
--------------------------------------------------------
*/

Begin    		
	Begin TRY						
		Insert into dbo.SysAdmin_DBLog
		(      
             [FileName] 
            ,[FolderPath]
            ,[DatabaseName]
            ,[DatabaseVersion] 
            ,[IsDBRestorable] 
            ,[Action]  
            ,[ActionType] 
            ,[Status] 
            ,[MessageDetail]
            ,[Remarks] 
            ,[CreatedBy] 
            ,[CreatedOn] 
            ,[IsActive] 
		)
	  Values 
	  (
			 @FileName
			,@FolderPath
			,@DatabaseName
			,@DatabaseVersion
			,@IsDBRestorable
			,@Action  
			,@ActionType
			,@Status
			,@MessageDetail
			,@Remarks
			,@CreatedBy 
			,getdate()
			,@IsActive
	  )
	End Try
	Begin Catch
	 return Error_message();
	End Catch			
End


GO
