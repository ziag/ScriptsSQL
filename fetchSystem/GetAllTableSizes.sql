--USE [UDA_iAcces]
--GO
--/****** Object:  StoredProcedure [dbo].[GetAllTableSizes]    Script Date: 04/15/2014 13:44:59 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER PROCEDURE [dbo].[GetAllTableSizes]
--AS
/*
    Obtains spaced used data for ALL user tables in the database
*/
DECLARE @TableName VARCHAR(100)    --For storing values in the cursor

--Cursor to get the name of all user tables from the sysobjects listing
DECLARE tableCursor CURSOR
FOR 
select [name]
from dbo.sysobjects 
where  OBJECTPROPERTY(id, N'IsUserTable') = 1
FOR READ ONLY

--A procedure level temp table to store the results
CREATE TABLE #TempTable
(
    nomTable varchar(100),
    nombreDeLignes varchar(100),
    espaceReserver varchar(50),
    espaceData varchar(50),
    espacesIndex varchar(50),
    espaceInutiliser varchar(50)
)

--Open the cursor
OPEN tableCursor

--Get the first table name from the cursor
FETCH NEXT FROM tableCursor INTO @TableName

--Loop until the cursor was not able to fetch
WHILE (@@Fetch_Status >= 0)
BEGIN
    --Dump the results of the sp_spaceused query to the temp table
    INSERT  #TempTable
        EXEC sp_spaceused @TableName

    --Get the next table name
    FETCH NEXT FROM tableCursor INTO @TableName
END

--Get rid of the cursor
CLOSE tableCursor
DEALLOCATE tableCursor

--Select all records so we can use the reults
SELECT * 
FROM #TempTable
ORDER BY espaceData DESC

--Final cleanup!
DROP TABLE #TempTable

