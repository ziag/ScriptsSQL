 
USE master
GO

CREATE procedure [dbo].[getPrimaryKeys] @db_name varchar(100), @table_name varchar(100)
as
declare 
@sql_pk varchar(3000)
BEGIN

SET @sql_pk = ''
SET @sql_pk = 'select KCU.COLUMN_name COL_NAME, c.DATA_TYPE, c.CHARACTER_MAXIMUM_LENGTH CHAR_LENGTH, c.NUMERIC_PRECISION NUMERIC_PRECISION, 
              c.NUMERIC_PRECISION_RADIX NUMERIC_PREC_RADIX
              from '+@db_name
              +'.INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU
              Join '+@db_name+'.INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC
              ON  KCU.CONSTRAINT_SCHEMA = TC.CONSTRAINT_SCHEMA
              AND KCU.CONSTRAINT_NAME = TC.CONSTRAINT_NAME
              AND KCU.TABLE_SCHEMA = TC.TABLE_SCHEMA
              AND KCU.TABLE_NAME = TC.TABLE_NAME
              join '+@db_name+'.INFORMATION_SCHEMA.COLUMNS C
              ON c.TABLE_CATALOG = tc.TABLE_CATALOG
              and c.TABLE_SCHEMA = tc.TABLE_SCHEMA
              and c.TABLE_NAME = tc.TABLE_NAME
              and c.COLUMN_NAME = kcu.COLUMN_NAME
              and TC.TABLE_CATALOG = '''+@db_name+''' and TC.TABLE_NAME = '''+@table_name+''''
--print @sql_pk
exec (@sql_pk)
END
GO
 