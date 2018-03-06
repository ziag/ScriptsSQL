/*

Author: rabie harriga

Version:SQL 2005, 2008, 2008 R2,2012,2014,2016

Decription:This Script allows you to determine the list of unused indexes in your databases

*/

select object_name (i.object_id) as NomTable,isnull( i.name,'HEAP') as IndexName 

from sys.objects o inner join sys.indexes i

ON i.[object_id] = o.[object_id] left join

sys.dm_db_index_usage_stats s 

on i.index_id = s.index_id and s.object_id = i.object_id



where object_name (o.object_id) is not null

and object_name (s.object_id) 

is null

AND o.[type] = 'U'

and isnull( i.name,'HEAP') <>'HEAP'
and i.is_primary_key = 0 and i.is_unique = 0 
union all



select object_name (i.object_id) as NomTable,isnull( i.name,'HEAP') as IndexName 

from sys.objects o inner join sys.indexes i

ON i.[object_id] = o.[object_id] left join

sys.dm_db_index_usage_stats s 

on i.index_id = s.index_id and s.object_id = i.object_id

where user_seeks= 0

and user_scans=0

and user_lookups= 0

AND o.[type] = 'U'

and isnull( i.name,'HEAP') <>'HEAP'

and i.is_primary_key = 0 and i.is_unique = 0 

order by NomTable asc
