BEGIN TRAN

-- In most cases, the following steps will repair the database (in this example: salesforce backups):

-- Increase the available storage space.

-- Create back-ups of database files *.mdf (Primary Data File), *.ndf (Secondary Data Files, if available) and *.ldf (Log Files).

-- Set the database to mode “online“:
ALTER DATABASE [salesforce backups] SET ONLINE  

-- Run CheckDB against the database in question (only warnings):
DBCC CHECKDB('[salesforce backups]') WITH NO_INFOMSGS
--If CheckDB has completed without warning, the database does not need to be repaired.Otherwise proceed to step #5

--Before repair, the database has to be set to single user mode:
ALTER DATABASE [salesforce backups] SET SINGLE_USER

--There are different repair levels. Usually, one begins with “REPAIR_REBUILD“:
DBCC CHECKDB('[salesforce backups]',REPAIR_REBUILD)
--If the repair is successful, the database may be set back to multiple user mode (see step #9).

--Otherwise, repair level “REPAIR_ALLOW_DATA_LOSS” is next. Please note that (as the name suggests) this may result in a loss of data:
DBCC CHECKDB('[salesforce backups]',REPAIR_ALLOW_DATA_LOSS)
--If repair was successful, the database may be set back to multiple user status (see step #9).

--Finally, you can try repair via the “EMERGENCY“ mode:
ALTER DATABASE [salesforce backups] SET EMERGENCY
ALTER DATABASE [salesforce backups] SET SINGLE_USER
DBCC CHECKDB ([salesforce backups],REPAIR_ALLOW_DATA_LOSS) WITH
NO_INFOMSGS,ALL_ERRORMSGS

--Set database to status “Online” and re-activate multiple user mode:
ALTER DATABASE [salesforce backups] SET ONLINE
ALTER DATABASE [salesforce backups] SET MULTI_USER
--If everything worked out, the status “Recovery Pending“ should disappear after refreshing.>


 

ROLLBACK