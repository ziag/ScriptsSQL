 
 			
BULK
INSERT   dbo.[Claim_PlagesASupprimer]

FROM 'D:\TempSQL\fichier.txt'
WITH 
(
FIELDTERMINATOR = '\t',
rowterminator = '\n',
FIRSTROW = 2 

) 

 