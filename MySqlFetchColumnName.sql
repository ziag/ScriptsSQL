BEGIN TRAN
 
 
Select * from openquery(MYSQLSVR,'SELECT COLUMN_NAME, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS')  

WHERE COLUMN_NAME like '%fav%' 


Select * from openquery(MYSQLSVR,'SELECT  *
FROM Signets')  

 
 

ROLLBACK