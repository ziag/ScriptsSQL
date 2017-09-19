 

DECLARE @bulkInsert NVARCHAR(250) 
DECLARE @nomFichierInsertManuel NVARCHAR(250) = 'D:\tempSQL\pp.TXT'
DECLARE @dateDebut AS DATETIME = '2017-28-07'
DECLARE @dateFin AS DATETIME = @dateDebut + 1


IF OBJECT_ID(N'tempPayPal' ,N'U') IS NOT NULL 
DROP TABLE tempPayPal;
 

CREATE TABLE tempPayPal(
						[DATE] [NVARCHAR](MAX) NULL,
						[TIME] [NVARCHAR](MAX) NULL,
						[TimeZone] [NVARCHAR](MAX) NULL,
						[Name] [NVARCHAR](MAX) NULL,
						[TYPE] [NVARCHAR](MAX) NULL,
						[Status] [NVARCHAR](MAX) NULL,
						[Currency] [NVARCHAR](MAX) NULL,
						[Gross] [NVARCHAR](MAX) NULL,
						[Fee] [NVARCHAR](MAX) NULL,
						[Net] [NVARCHAR](MAX) NULL,
						[FROM Email Address] [NVARCHAR](MAX) NULL,
						[TO Email Address] [NVARCHAR](MAX) NULL,
						[TRANSACTION ID] [NVARCHAR](MAX) NULL,
						[Shipping Address] [NVARCHAR](MAX) NULL,
						[Address Status] [NVARCHAR](MAX) NULL,
						[Item Title] [NVARCHAR](MAX) NULL,
						[Item ID] [NVARCHAR](MAX) NULL,	
						[Shipping Amount] [NVARCHAR](MAX) NULL,
						[Insurance Amount] [NVARCHAR](MAX) NULL,
						[Sales Tax] [NVARCHAR](MAX) NULL,	
						[OPTION 1 Name] [NVARCHAR](MAX) NULL,
						[OPTION 1 VALUE] [NVARCHAR](MAX) NULL,
						[OPTION 2 Name] [NVARCHAR](MAX) NULL,
						[OPTION 2 VALUE] [NVARCHAR](MAX) NULL,
						[Reference Txn ID] [NVARCHAR](MAX) NULL,
						[Invoice Number] [NVARCHAR](MAX) NULL,
						[Custom Number] [NVARCHAR](MAX) NULL,
						[Quantity] [NVARCHAR](MAX) NULL,
						[Receipt ID] [NVARCHAR](MAX) NULL,	
						[Balance] [NVARCHAR](MAX) NULL,	
						[Address Line 1] [NVARCHAR](MAX) NULL,	
						[Address Line 2] [NVARCHAR](MAX) NULL,
						[City] [NVARCHAR](MAX) NULL,
						[Province] [NVARCHAR](MAX) NULL,
						[Zip Postal Code] [NVARCHAR](MAX) NULL,
						[Country] [NVARCHAR](MAX) NULL,
						[Contact Phone Number] [NVARCHAR](MAX) NULL,
						[Subject]	 [NVARCHAR](MAX) NULL,
						[Note] [NVARCHAR](MAX) NULL,
						[Country Code] [NVARCHAR](MAX) NULL,
						[Balance Impact] [NVARCHAR](MAX) NULL
						);


SET @bulkInsert = 'BULK
					INSERT   dbo.tempPayPal      					 
					FROM  ''' + @nomFichierInsertManuel +'''
					WITH
					(
					CODEPAGE=''ACP'',   
					FIELDTERMINATOR = ''\t'',
					ROWTERMINATOR = ''\n'',
					FIRSTROW = 2 
					)  '
 
		
 				
EXECUTE sp_executesql @bulkInsert
/*
SELECT * FROM tempPayPal as pp 		
*/

SELECT 'Transaction dans PayPal mais pas dans le Mec'  
SELECT  LEN(ntel.NumAutorisation ) , SUBSTRING(ntel.NumAutorisation, 5, 15),  LEN(SUBSTRING(ntel.NumAutorisation, 5, 15)), *
FROM    tempPayPal AS pp 

LEFT JOIN UDA_Axiant.dbo.tabNumTransactionEnLigne AS ntel
	ON SUBSTRING(ntel.NumAutorisation, 5, 15) = LEFT( pp.[TRANSACTION ID] , 15) 

WHERE  ntel.NumTrans IS NULL 
AND pp.DATE IS NOT NULL 
	


SELECT 'Transaction dans le Mec mais pas dans PayPal'
SELECT  LEN(ntel.NumAutorisation ) , SUBSTRING(ntel.NumAutorisation, 5, 15),  LEN(SUBSTRING(ntel.NumAutorisation, 5, 15)), *
FROM    UDA_Axiant.dbo.tabNumTransactionEnLigne AS ntel

LEFT JOIN tempPayPal AS pp 
	ON SUBSTRING(ntel.NumAutorisation, 5, 15) = LEFT( pp.[TRANSACTION ID] , 15) 

WHERE NomCarte = 'paypal'
AND ntel.DateNum > @dateDebut 
AND ntel.DateNum < @dateFin 
AND pp.[TRANSACTION ID] IS NULL 


