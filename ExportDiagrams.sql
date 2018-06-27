-------------------------------------------------------------------------
-- Name: ExportDiagrams.sql
-- Date: 2018-05-25
-- Release: 1.0
-- Summary:
--   * Export diagrams in current database to an import script.
-- Returns:
--   * Script to insert all database diagrams.
-------------------------------------------------------------------------
set nocount on;

-- Export diagram
declare @principal_id int = 0;
declare @diagram_id int = 0;
declare @version int = 0;
declare @index int = 1;
declare @size int = 0;
declare @chunk int = 32;
declare @line varchar(max);
-- Diagram loop
declare @diagramName sysname;
declare @itemCount int = 0;
declare @item int = 0;
declare @firstDiagram bit = 1;
declare @diagrams table (
	Id int identity primary key,
	[Schema] sysname not null,
	[Name] sysname not null
	);

print '-------------------------------------------------------------------------';
print '-- Script to restore all diagrams from database [' + db_name() + '].'
print '-------------------------------------------------------------------------';
print '--use ' + db_name();
print '--go';
print ''

if (
		exists (
			select 1
			from information_schema.tables
			where table_schema = 'dbo'
				and table_name = 'sysdiagrams'
			)
		)
begin
	insert into @diagrams
	select [Schema] = 'dbo',
		[Name] = [name]
	from dbo.sysdiagrams;

	select @item = min(Id)
	from @diagrams;

	select @itemCount = count(Id)
	from @diagrams;

	while @item < @itemCount + 1
	begin
		select @diagramName = [Name]
		from @diagrams
		where Id = @item;

		------------------------------------------------------------------------
		-- Export diagram
		set @principal_id = 0;
		set @diagram_id = 0;
		set @version = 0;
		set @index = 1;
		set @size = 0;
		set @chunk = 32;
		set @line = '';

		select @principal_id = principal_id,
			@diagram_id = diagram_id,
			@version = [version],
			@size = datalength([definition])
		from dbo.sysdiagrams
		where name = @diagramName;

		if @diagram_id is null
		begin
			print '-------------------------------------------------------------------------';
			print '-- Error: Diagram name [' + @diagramName + '] could not be found in [' + db_name() + '].';
			print '-------------------------------------------------------------------------';
		end
		else
		begin
			print '-------------------------------------------------------------------------';
			print '-- Summary: Restore diagram [' + @diagramName + '] from database [' + db_name() + '].';
			print '-------------------------------------------------------------------------';
			print 'print ''=== Restoring diagram [' + @diagramName + '] ==='';';
			print 'set nocount on;';

			if (@firstDiagram = 1)
			begin
				print 'declare @newid int;';
				print 'declare @outputs table (Id int not null);';
			end
			else
			begin
				print '-- declare @newid int;';
				print '-- declare @outputs table (Id int not null);';
				print 'delete from @outputs;';
			end

			print 'begin try';

			select @line = '    insert into dbo.sysdiagrams ([name], [principal_id], [version], [definition])' + ' output inserted.diagram_id into @outputs' + ' values (''' + @diagramName + ''', ' + cast(@principal_id as varchar(10)) + ', ' + cast(@version as varchar(10)) + ', 0x);'
			from dbo.sysdiagrams
			where diagram_id = @diagram_id;

			print @line;
			print '    set @newid = (select top(1) Id from @outputs order by Id);';
			print 'end try';
			print 'begin catch';
			print '    print ''=== '' + error_message() + '' ==='';';
			print '    return;';
			print 'end catch;';
			print '';
			print 'begin try';

			while @index < @size
			begin
				select @line = '    update dbo.sysdiagrams set definition.write(' + convert(varchar(66), substring("definition", @index, @chunk), 1) + ', null, 0) where diagram_id = @newid; -- index:' + cast(@index as varchar(10))
				from dbo.sysdiagrams
				where diagram_id = @diagram_id;

				print @line;

				set @index = @index + @chunk;
			end

			print '';
			print '    print ''=== Diagram [' + @diagramName + '] restored at diagram_id='' + cast(@newid as varchar(10)) + ''. ==='';';
			print 'end try';
			print 'begin catch';
			print '    delete from dbo.sysdiagrams where diagram_id = @newid;';
			print '    print ''=== '' + error_message() + '' ==='';';
			print 'end catch;';
			print '-- End of restore diagram [' + @diagramName + '] script.';
			print '';
		end

		-- End Export diagram
		------------------------------------------------------------------------
		set @firstDiagram = 0;
		set @item += 1;
	end
end

print '-- End of restore all diagram script.';
