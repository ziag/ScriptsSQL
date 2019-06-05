BEGIN TRAN

SELECT  *
FROM   Sigart.dbo.tblIntervenants as i  
where NoTVP = '' 



SELECT  *
FROM    sys.tables as t 
inner join sys.columns as c on t.object_id = c.object_id 
where c.name like '%dateChoix%'


ROLLBACK