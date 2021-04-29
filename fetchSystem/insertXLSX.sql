 
 /*
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
GO
RECONFIGURE;
GO
*/

/*
IF OBJECT_ID(N'tempPayPal' ,N'U') IS NOT NULL 
DROP TABLE tempPayPal;
 

CREATE TABLE tempPayPal(
						[Date] varchar(255),
						[Time] varchar(255),
						[TimeZone] varchar(255),
						[Name] varchar(255),
						[Type] varchar(255),
						[Status] varchar(255),
						[Currency] varchar(255),
						[Gross] varchar(255),
						[Fee] varchar(255),
						[Net] varchar(255),
						[From Email Address] varchar(255),
						[To Email Address] varchar(255),
						[Transaction ID] varchar(255),
						[Shipping Address] varchar(255),
						[Address Status] varchar(255),
						[Item Title] varchar(255),
						[Item ID] varchar(255),	
						[Shipping Amount] varchar(255),
						[Insurance Amount] varchar(255),
						[Sales Tax] varchar(255),	
						[Option 1 Name] varchar(255),
						[Option 1 Value] varchar(255),
						[Option 2 Name] varchar(255),
						[Option 2 Value] varchar(255),
						[Reference Txn ID] varchar(255),
						[Invoice Number] varchar(255),
						[Custom Number] varchar(255),
						[Quantity] varchar(255),
						[Receipt ID] varchar(255),	
						[Balance] varchar(255),	
						[Address Line 1] varchar(255),	
						[Address Line 2] varchar(255),
						[City] varchar(255),
						[Province] varchar(255),
						[Zip Postal Code] varchar(255),
						[Country] varchar(255),
						[Contact Phone Number] varchar(255),
						[Subject]	 varchar(255),
						[Note] varchar(255),
						[Country Code] varchar(255),
						[Balance Impact] varchar(255)
						);

select *  
from tempPayPal   

*/
--BULK INSERT tempPayPal FROM 'D:\tempSQL\pp.TXT'
--WITH (FIELDTERMINATOR ='\t',ROWTERMINATOR =' \n')

--/*You now have your bulk data*/

--insert into tempPayPal  --(field1, field2, field3, field4, field5, field6)
--select * --txt.FIELD1, txt.FIELD2, txt.FIELD3, txt.FIELD4, 'something else1', 'something else2' 
--from tempPayPal  --#TEXTFILE_1 txt

-- drop table #TEXTFILE_1

sp_configure 'show advanced options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO
SELECT *
--INTO BonusUpload
FROM
OPENROWSET('Microsoft.ACE.OLEDB.16.0'
,'Excel 16.0 Xml;HDR=YES;
Database=C:\Source\un.xlsx'
,'SELECT * FROM [Feuil1$]'
)


 

/*
INSERT INTO tblSample
2.
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
3.
'Excel 12.0 Xml;HDR=YES;Database=C:\Test.xlsx',
4.
'SELECT * FROM [Sheet1$]');


;.l,kmn jb
*/
 
