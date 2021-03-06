USE [master]
GO
/****** Object:  StoredProcedure [dbo].[usp_FindColumnUsage]    Script Date: 05/11/2012 14:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
    ALTER PROCEDURE [dbo].[usp_FindColumnUsage] 
        @vcTableName varchar(100), 
        @vcColumnName varchar(100)
    AS
    /************************************************************************************************
    DESCRIPTION: Creates prinatable report of all stored procedures, views, triggers  and user-defined functions that reference  the  table/column passed into the proc.
    PARAMETERS:  @vcTableName - table containing searched column  @vcColumnName - column being searched for
    REMARKS:  To print the output of this report in Query Analyzer/Management   Studio select the execute mode to be file and you will  be prompted for a file name to save as. Alternately  you can select the execute mode to be text, run the query, set  the focus on the results pane and then select File/Save from  the menu.  This procedure must be installed in the database where it will  be run due to it's use of database system tables.USAGE:    usp_FindColumnUsage 'jct_contract_element_card_sigs', 'contract_element_id'
    
    AUTHOR: Karen Gayda
    DATE: 07/19/2007
    MODIFICATION 
    HISTORY:WHO  D
    ATE  
    DESCRIPTION---  ---------- -------------------------------------------
    
    *************************************************************************************************/
    
    SET NOCOUNT ON 
    PRINT ''
    PRINT 'REPORT FOR DEPENDENCIES FOR TABLE/COLUMN:'
    PRINT '-----------------------------------------'
    PRINT  @vcTableName + '.' +@vcColumnName
    PRINT ''
    PRINT ''
    PRINT 'STORED PROCEDURES:'
    PRINT ''
    SELECT DISTINCT  SUBSTRING(o.NAME,1,60) AS [Procedure Name]  
    FROM sysobjects o  
    INNER JOIN syscomments c   ON o.ID = c.ID  
    WHERE  o.XTYPE = 'P'   AND c.Text LIKE '%' + @vcColumnName + '%' + @vcTableName + '%'      
    ORDER BY  [Procedure Name]
    PRINT CAST(@@ROWCOUNT as Varchar(5)) + ' dependent stored procedures for column "' + @vcTableName + '.' +@vcColumnName +  '".' 
    PRINT''
    PRINT''
    PRINT 'VIEWS:'
    PRINT''
    SELECT DISTINCT  SUBSTRING(o.NAME,1,60) AS [View Name]  
    FROM sysobjects o  
    INNER JOIN syscomments c   ON o.ID = c.ID  
    WHERE  o.XTYPE = 'V'   AND c.Text LIKE '%' + @vcColumnName + '%' + @vcTableName + '%'      
    ORDER BY  [View Name]
    PRINT CAST(@@ROWCOUNT as Varchar(5)) + ' dependent views for column "' + @vcTableName + '.' +@vcColumnName +  '".'
    PRINT ''
    PRINT ''
    PRINT 'FUNCTIONS:'
    PRINT ''
    SELECT DISTINCT  SUBSTRING(o.NAME,1,60) AS [Function Name],  
    CASE WHEN o.XTYPE = 'FN' THEN 'Scalar'   WHEN o.XTYPE = 'IF' THEN 'Inline'   WHEN o.XTYPE = 'TF' THEN 'Table'   ELSE '?'  END  as [Function Type]  
    FROM sysobjects o  
    INNER JOIN syscomments c   ON o.ID = c.ID  
    WHERE  o.XTYPE IN ('FN','IF','TF')   AND c.Text LIKE '%' + @vcColumnName + '%' + @vcTableName + '%'      
    ORDER BY  [Function Name]
    PRINT CAST(@@ROWCOUNT as Varchar(5)) + ' dependent functions for column "' + @vcTableName + '.' +@vcColumnName +  '".'
    PRINT''
    PRINT''
    PRINT 'TRIGGERS:'
    PRINT''
    SELECT DISTINCT  SUBSTRING(o.NAME,1,60) AS [Trigger Name]  
    FROM sysobjects o  
    INNER JOIN syscomments c   ON o.ID = c.ID  
    WHERE  o.XTYPE = 'TR'   AND c.Text LIKE '%' + @vcColumnName + '%' + @vcTableName + '%'      
    ORDER BY  [Trigger Name]
    PRINT CAST(@@ROWCOUNT as Varchar(5)) + ' dependent triggers for column "' + @vcTableName + '.' +@vcColumnName +  '".'