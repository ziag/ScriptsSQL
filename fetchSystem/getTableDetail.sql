BEGIN TRAN

SELECT  t.name as NomTable
		,c.name as NomColonne 
		,p.name as  [DataType]
		,c.max_length 
		,c.is_identity
		,c.is_nullable
	 
		
FROM    sys.tables as t

INNER JOIN sys.columns as c
	on t.object_id = c.object_id

JOIN SYS.TYPES AS P
ON C.SYSTEM_TYPE_ID=P.SYSTEM_TYPE_ID


WHERE t.name in ('tabTransactions', 'tabPaiement','tabItem', 'tabnomitem','tabTypeCompte'
				,'tabcompagnie','tabFraisenPorcentage','tabTypePaiement','tabdepot') 

AND p.name <> 'sysname'

ORDER BY NomTable  desc


SELECT c.name, * FROM sys.tables AS t 
INNER JOIN  sys.columns AS c ON c.object_id = t.object_id 
WHERE c.name LIKE '%tabitem%'


EXECUTE sp_help tabitem


ROLLBACK