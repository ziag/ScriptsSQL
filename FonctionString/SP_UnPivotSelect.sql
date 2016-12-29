CREATE Proc [dbo].[SP_UnPivotSelect] (@Select varchar(4000), @OrderByColName varchar(1)='N')
as
/*
exec SP_UnPivotSelect 'select * from tabnomitem ', 'N'
*/
Declare @SQL varchar(max)
Declare @Columns varchar(8000)
Declare @ColumnList varchar(8000)
Declare @SelectList varchar(8000)
Declare @ColName varchar(200)
Declare @LookFor varchar(200)
Declare @i int

DECLARE @nSQL nvarchar(4000)
DECLARE @params nvarchar(4000)
DECLARE @Crsr CURSOR
DECLARE @Report CURSOR

Declare @OrdPos int
Declare @Flags int
Declare @Size int
Declare @DataType int
Declare @Prec int
Declare @Scale int
Declare @Pos int
Declare @Dir varchar(1)
Declare @Hide int
Declare @ColId int
Declare @ObjId int
Declare @dbid int
Declare @DbName sysname

set nocount on

if patindex('%SELECT%', upper(@Select))=0
begin
  Select 'Missing ''Select'' Clause'
  return
end

set @i=patindex('%FROM%', upper(@Select))
if @i=0
begin
  Select 'Missing ''From'' Clause'
  return
end


set @Columns='_rn_ int identity, __________ varchar(max)' -- to be used for #PivotTable (below) 
set @ColumnList='__________,'
set @SelectList='__________'


-- Get names of all columns by supplying a cursor (@Crsr) on @Select to sp_describe_cursor_columns
SELECT @nSQL = 
	N' SET @Crsr = CURSOR STATIC FOR ' + @Select + 
	N' FOR READ ONLY ' +
	N' OPEN @Crsr '
SELECT @params = N'@Crsr cursor OUTPUT ' 
EXEC sp_executesql @nSQL, @params,  @Crsr = @Crsr OUTPUT  

EXEC master.dbo.sp_describe_cursor_columns
    @cursor_return = @Report OUTPUT, 
    @cursor_source = N'variable', 
    @cursor_identity = N'@Crsr'

FETCH NEXT from @Report into @ColName, @OrdPos, @Flags, @Size, @DataType, @Prec, @Scale, 
				@Pos, @Dir, @Hide, @ColId, @ObjId, @dbid, @DbName
WHILE (@@FETCH_STATUS <> -1)
BEGIN
  if isnull(@ColName,'')='' set @ColName='NoColumnName'
  set @LookFor='%, ' + @ColName + ',%'

  If patindex(@LookFor, @ColumnList)<>0
  Begin -- make sure column name is unique 
    set @i=0
    while patindex(@LookFor, @ColumnList)<>0
    begin
      set @i=@i+1
      set @LookFor='%, ' + @ColName + '_' + convert(varchar,@i) + ',%'
    end
    set @ColName=@ColName + '_' + convert(varchar,@i)
  End

  set @Columns=@Columns + ', ' + @ColName + ' varchar(max)'
  set @ColumnList=@ColumnList + ' ' + @Colname + ','
  set @SelectList=@SelectList + ', isnull(convert(varchar(max),' + @ColName + '), ''NULL'') ' + @ColName
     
  FETCH NEXT from @Report into @ColName, @OrdPos, @Flags, @Size, @DataType, @Prec, @Scale, 
				  @Pos, @Dir, @Hide, @ColId, @ObjId, @dbid, @DbName
END

CLOSE @Report
DEALLOCATE @Report

set @ColumnList=substring(@ColumnList, 1, len(@ColumnList)-1)


-- Create a table which will be used for pivoting the results and then use it in the select
set @SQL='Create table #PivotTable (' + @Columns + ') '

set @SQL=@SQL + 'Insert into #PivotTable '
set @i=patindex('%SELECT%', upper(@Select))
set @SQL=@SQL + substring(@Select, 1, @i+6) + ''''', '
set @SQL=@SQL + substring(@Select, @i+7, 9999) + ' '

set @SQL=@SQL + 'Update #PivotTable set __________=_rn_ '

set @SQL=@SQL + 'SELECT Col [Column], isnull(ColVal,''NULL'') [Value] '
set @SQL=@SQL + 'FROM (SELECT ' + @SelectList + ' FROM #PivotTable) p '
set @SQL=@SQL + 'UNPIVOT (ColVal FOR Col IN '
set @SQL=@SQL + '(' + @ColumnList + ') ' 
set @SQL=@SQL + ')AS unpvt '
if @OrderByColName='Y' set @SQL=@SQL + 'Order by 1 '

print @SQL 

exec (@SQL)